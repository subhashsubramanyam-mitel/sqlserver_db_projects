-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-01-20
-- Description:	Sync Service Product data
-- Change Log:   2012-05-09 Optimal access to ServiceProduct Billing Dates
--               Also due to dates uncertainty, decide to pull all service product data.
--  Change Log:  Add LichenServiceId, LichenPlanId for comparisons
--	Change Log:  Add DateServiceCloseOrdered, MonthServiceCloseOrdered, ClosedByPersonId
--  Change Log:  Avoid joining tables on remote servers
--  Change Log:  modify match clause to take care of null productid
--  Change Log:  obtain productid from LastSBP, then NullSBP, then S
--               Note: even then, productId is null in some cases
--  Change Log:   when productid is from NUllSBP, the price should also come from there!
--  Change Log:  Jan 22, 2013, change match criteria for null productId
--  change Log:  Aug 14, 2014, add circuit status
-- =============================================
CREATE PROCEDURE [oss].[UspSyncServiceProduct] 
	-- Add the parameters for the stored procedure here
	@lastSyncUTC datetime = NULL  -- 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing ServiceProduct data';

	MERGE oss.ServiceProduct as target
	USING (
	SELECT * FROM OpenQuery([M5DB], '
		SELECT 
			S.Id as ServiceId, S.LichenServiceId,
			P.Id as ProductId, P.LichenPlanId,
			S.ServiceClassId,
			S.ServiceStatusId,
			C.CircuitStatusId,
			S.AccountId,
			S.InvoiceServiceGroupId,
			S.LocationId,
			REPLACE(REPLACE(S.Name, CHAR(10), ''''), CHAR(9), '''') Name,
			CASE WHEN (S.TN is not null) THEN 1 ELSE 0 END as IsAttachedToTN,
			REPLACE(REPLACE(S.TN, CHAR(10), ''''), CHAR(9), '''') TN,
			CASE WHEN PP.InvoiceLabelOverride is not null and PP.InvoiceLabelOverride <> '''' and PP.InvoiceLabelOverride <> '' ''
				THEN PP.InvoiceLabelOverride
				ELSE P.Name 
				END as InvoiceLabel,
			S.OrderId,
			CASE 
				 WHEN O.OrderTypeId = 2 and Lo.Id is not null THEN 9 -- Linked Add
				 WHEN O.Id is null THEN -1 -- Unspecified
				 ELSE O.OrderTypeId
			END as OrderTypeId,
			CASE WHEN O.OrderTypeId = 0 THEN 1  -- Initial order
			     WHEN Lo.Id is not null and LO.OrderTypeId = 0 THEN 1 -- Linked to Initial Order
			     ELSE 0
			END  as WasInInitialOrder,
			
			Coalesce(O.ProjectManagerId, LO.ProjectManagerId) as OrderProjectManagerId,
			Coalesce(O.CreatedByPersonId, LO.CreatedByPersonId) as OrderCreatedByPersonId,
			Coalesce(O.OrderedById, LO.OrderedById,0) as OrderedById,
			Coalesce(O.SalesPersonId, LO.SalesPersonId,0) as OrderSalesPersonId,	
			CASE WHEN LastSBP.Id is not null THEN LastSBP.MRR ELSE NullSBP.MRR END as MonthlyCharge,
			CASE WHEN LastSBP.Id is not null THEN LastSBP.NRC ELSE NullSBP.NRC END as OneTimeCharge,
			
			Billing.dbo.UfnUTCTimeToLocalDate(S.DateCreated) as DateSvcCreated,
			Billing.dbo.UfnUTCTimeToLocalDate(S.DateModified) as DateSvcModified,
			(S.DateLiveScheduled) as DateSvcLiveScheduled,
			(S.DateLiveActual) as DateSvcLiveActual,
			(CS.DateCreatedOriginal) DateSvcCloseOrdered,
			dbo.UfnFirstOfMonth(CS.DateCreatedOriginal)  MonthSvcCloseOrdered,
			CS.CreatedByPersonId ClosedByPersonId,
			(S.DateClosed) as DateSvcClosed,
			(FirstSBP.DateFrom) as DateBillingValidFrom,
			(LastSBP.DateTo) as DateBillingValidTo,
			S.CreatedByPersonId,
			S.ModifiedByPersonId
		FROM 
			dbo.service_Service S with(nolock)
			left join dbo.order_Order O on O.Id = S.OrderId
			left join dbo.order_Order LO on LO.Id = O.LinkedOrderId 
		
			left join Billing.dbo.VwServiceProductBillingInterval2 SPBI with (nolock)
				on SPBI.ServiceId = S.Id
			left join dbo.billing_ServiceBillingPeriod FirstSBP with(nolock)
				on FirstSBP.Id = SPBI.FirstSBPId
			left join dbo.billing_ServiceBillingPeriod LastSBP with(nolock)
				on LastSBP.Id = SPBI.LastSBPId
			left join dbo.billing_ServiceBillingPeriod NullSBP with(nolock)
				on NullSBP.Id  = SPBI.NullSBPId
			left join dbo.billing_product P on P.Id = coalesce(LastSBP.ProductId,NullSBP.ProductId,S.ProductId) -- 2013-01-07
			left join dbo.billing_PricePlanPrice PPP on PPP.Id = LastSBP.PricePlanPriceId
			left join dbo.billing_PricePlan PP on PP.Id = PPP.PricePlanId
			left join (
				select OIS.ServiceId, MAX(CO.CreatedByPersonId) CreatedByPersonId, MAX(CO.DateCreatedOriginal) DateCreatedOriginal, COUNT(1) num
				from dbo.order_OrderItemService OIS 
				inner join dbo.order_OrderItem OI on OI.Id = OIS.OrderItemId and OI.OrderItemTypeId = 6
				inner join dbo.order_Order CO on CO.Id = OI.OrderId and CO.OrderTypeId = 4
				Group by OIS.ServiceId
			) CS on CS.ServiceId = S.Id
			left join dbo.circuit_Circuit C on C.ServiceId = S.Id
		') foo
	)
	    AS source
	ON target.ServiceId = source.ServiceId and 
		(target.productId = source.Productid OR (target.productId is null and source.productid is null))
	WHEN MATCHED 
		THEN	
		UPDATE SET 
			target.OrderProjectManagerId = source.OrderProjectManagerId,
			target.OrderCreatedByPersonId = source.OrderCreatedByPersonId,
			target.OrderedById = source.OrderedById,
			target.OrderSalesPersonId = source.OrderSalesPersonId,
			target.LichenServiceId = source.LichenServiceId,
			target.LichenPlanId = source.LichenPlanId,
			target.ServiceClassId = source.ServiceClassId,
			target.ServiceStatusId = source.ServiceStatusId,
			target.CircuitStatusId = source.CircuitStatusId,
			target.AccountId = source.AccountId,
			target.InvoiceServiceGroupId = source.InvoiceServiceGroupId,
			target.LocationId = source.LocationId,
			target.ServiceBundleId = null, -- deprecated
			target.Name = source.Name ,
			target.IsAttachedToTN = source.IsAttachedToTN ,
			target.TN = source.TN ,
			target.InvoiceLabel = source.InvoiceLabel ,
			target.OrderId = source.OrderId,
			target.OrderTypeId = source.OrderTypeId ,
			target.WasInInitialOrder = source.WasInInitialOrder ,
			target.MonthlyCharge = source.MonthlyCharge ,
			target.OneTimeCharge = source.OneTimeCharge ,
			target.DateSvcCreated = source.DateSvcCreated ,
			target.DateSvcModified = source.DateSvcModified ,
			target.DateSvcLiveScheduled = source.DateSvcLiveScheduled ,
			target.DateSvcLiveActual = source.DateSvcLiveActual ,
			target.DateSvcCloseOrdered = source.DateSvcCloseOrdered ,
			target.MonthSvcCloseOrdered = source.MonthSvcCloseOrdered ,
			target.ClosedByPersonId = source.ClosedByPersonId ,			
			target.DateSvcClosed = source.DateSvcClosed ,
			target.DateBillingValidFrom = source.DateBillingValidFrom ,
			target.DateBillingValidTo = source.DateBillingValidTo ,
			target.CreatedByPersonId = source.CreatedByPersonId ,
			target.ModifiedByPersonId = source.ModifiedByPersonId 			

	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ServiceId,ProductId,LichenServiceId,LichenPlanId,ServiceClassId,ServiceStatusId,AccountId,InvoiceServiceGroupId,LocationId,
				ServiceBundleId,Name,IsAttachedToTN,TN,InvoiceLabel, OrderId,OrderTypeId,WasInInitialOrder,
				OrderProjectManagerId, OrderCreatedByPersonId, OrderedById, OrderSalespersonId,
				MonthlyCharge,OneTimeCharge,
				DateSvcCreated,DateSvcModified,DateSvcLiveScheduled,DateSvcLiveActual,
				DateSvcCloseOrdered, MonthSvcCloseOrdered, ClosedByPersonId, DateSvcClosed,
				DateBillingValidFrom,DateBillingValidTo,CreatedByPersonId,ModifiedByPersonId,
				CircuitStatusId )
		VALUES (ServiceId,ProductId,LichenServiceId,LichenPlanId,ServiceClassId,ServiceStatusId,AccountId,InvoiceServiceGroupId,LocationId,
				null,Name,IsAttachedToTN,TN,InvoiceLabel, OrderId,OrderTypeId,WasInInitialOrder,
				OrderProjectManagerId, OrderCreatedByPersonId, OrderedById, OrderSalespersonId,
				MonthlyCharge,OneTimeCharge,
				DateSvcCreated,DateSvcModified,DateSvcLiveScheduled,DateSvcLiveActual,
				DateSvcCloseOrdered, MonthSvcCloseOrdered, ClosedByPersonId, DateSvcClosed,
				DateBillingValidFrom,DateBillingValidTo,CreatedByPersonId,ModifiedByPersonId,
				CircuitStatusId )
	OUTPUT 'oss.ServiceProduct', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing ServoceProduct data';

END
