-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-03-15
-- Description:	Sync Invoice Line Item data
-- Change Log:  2013-02-13, Performance tuning, rewriting without MERGE

-- =============================================
create PROCEDURE invoice.UspSyncLineItem 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);
							
	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice Line Item data';
	
	DELETE from Invoice.LineItem 
		WHERE DateGenerated >= @lastSync;

	-- maintain local copy for performance
	DELETE from Invoice.billing_InvoiceLineItem 
		WHERE DateGenerated >= @lastSync;
			
	INSERT into Invoice.billing_InvoiceLineItem
			(Id, DateGenerated, InvoiceId, LocationId, ProductId, ServicePriceId, Description,
			 DatePeriodStart, DatePeriodEnd, ChargeTypeId, Charge, Quantity, FootnoteNumber,
			 LichenBillingGroupPlanId, DateModified, DateCreated,ModifiedBy, TmpLineItemId, LineItemTypeId,
			 LichenLineItemId, InvoiceServiceGroupId, PricePlanPriceId)
		SELECT 
			Id, DateGenerated, InvoiceId, LocationId, ProductId, ServicePriceId, Description,
			 DatePeriodStart, DatePeriodEnd, ChargeTypeId, Charge, Quantity, FootnoteNumber,
			 LichenBillingGroupPlanId, DateModified, DateCreated,ModifiedBy, TmpLineItemId, LineItemTypeId,
			 LichenLineItemId, InvoiceServiceGroupId, PricePlanPriceId
		FROM M5DB.M5DB.dbo.billing_InvoiceLineItem 
		WHERE DateGenerated >= @lastSync

	INSERT into  Invoice.LineItem  
		SELECT
			LI.Id as LineItemId, 
			CASE WHEN BC.Id is null THEN 0 ELSE BC.Id END as BillingCategoryId,
			CASE WHEN LI.ProductId is null THEN AP.Id else LI.ProductId END as ProductId,
			LI.InvoiceId,
			dbo.UfnFirstOfMonth(LI.DateGenerated) as DateGenerated,
			LI.LocationId,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodStart) as DatePeriodStart_Local,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodEnd) as DatePeriodEnd_Local,
			CASE WHEN LI.ChargeTypeId = 1 THEN LI.Charge ELSE null END as MonthlyCharge,
			CASE WHEN LI.ChargeTypeId = 2 THEN LI.Charge ELSE null END as OneTimeCharge,
			LI.FootnoteNumber,
			LI.Quantity,
			null -- InvoiceServiceGroupId
		FROM 
			invoice.billing_InvoiceLineItem LI with(nolock)
			left join enum.BillingCategory BC on BC.Name = LI.Description
			left Join enum.Product AP on AP.Name = LI.Description -- to get ALT Product Name for Usage, Surcharge
		WHERE
			LI.DateGenerated >= @lastSync; 

	PRINT convert(varchar,getdate(),14) + N': End syncing Invoice Line Item data';

END
