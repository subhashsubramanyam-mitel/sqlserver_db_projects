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
--  Change Log:  Sep 09, 2015, Tarak, Optimize
--  Change Log:  Nov 04, 2015, Tarak, add InFirstContract
-- =============================================
CREATE PROCEDURE [oss].[UspSyncServiceProductNEW] 
	-- Add the parameters for the stored procedure here
	@lastSyncUTC datetime = NULL  -- 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing ServiceProduct NEW data';

	Declare @SyncTIme Varchar(12) = Convert(varchar(10), DateAdd(day, 0, @lastSyncUTC), 120); -- 0 day safety window
	DECLARE @SS varchar(8000) = '
	MERGE oss.ServiceProduct as target
	USING (
		SELECT * FROM OpenQuery([M5DB],
	''select * from Billing.dbo.UfnServicesToBeSynced(''''' + @SyncTime + ''''')'')
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
			target.ModifiedByPersonId = source.ModifiedByPersonId,
			target.InFirstContract = source.InFirstContract,
			target.DateSvcVoided = source.DateSvcVoided,
			target.DateSvcSetToActive = source.DateSvcSetToActive,
			target.SvcClusterId = source.ServiceClusterId,
			target.CurrencyId = source.CurrencyId,
			target.MasterOrderTypeId = source.MasterOrderTypeId 			

	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ServiceId,ProductId,LichenServiceId,LichenPlanId,ServiceClassId,ServiceStatusId,AccountId,InvoiceServiceGroupId,LocationId,
				Name,IsAttachedToTN,TN,InvoiceLabel, OrderId,OrderTypeId,WasInInitialOrder,
				OrderProjectManagerId, OrderCreatedByPersonId, OrderedById, OrderSalespersonId,
				MonthlyCharge,OneTimeCharge,
				DateSvcCreated,DateSvcModified,DateSvcLiveScheduled,DateSvcLiveActual,
				DateSvcCloseOrdered, MonthSvcCloseOrdered, ClosedByPersonId, DateSvcClosed,
				DateBillingValidFrom,DateBillingValidTo,CreatedByPersonId,ModifiedByPersonId,
				CircuitStatusId, InFirstContract, DateSvcVoided, DateSvcSetToActive, SvcClusterId, CurrencyId,MasterOrderTypeId )
		VALUES (ServiceId,ProductId,LichenServiceId,LichenPlanId,ServiceClassId,ServiceStatusId,AccountId,InvoiceServiceGroupId,LocationId,
				Name,IsAttachedToTN,TN,InvoiceLabel, OrderId,OrderTypeId,WasInInitialOrder,
				OrderProjectManagerId, OrderCreatedByPersonId, OrderedById, OrderSalespersonId,
				MonthlyCharge,OneTimeCharge,
				DateSvcCreated,DateSvcModified,DateSvcLiveScheduled,DateSvcLiveActual,
				DateSvcCloseOrdered, MonthSvcCloseOrdered, ClosedByPersonId, DateSvcClosed,
				DateBillingValidFrom,DateBillingValidTo,CreatedByPersonId,ModifiedByPersonId,
				CircuitStatusId, InFirstContract, DateSvcVoided, DateSvcSetToActive, ServiceClusterId, CurrencyId,MasterOrderTypeId )
	OUTPUT''oss.ServiceProduct'', $action INTO SyncChanges;
	';
	--print @SS;
	EXEC (@SS);

	PRINT convert(varchar,getdate(),14) + N': End syncing ServoceProduct NEW data';

END
