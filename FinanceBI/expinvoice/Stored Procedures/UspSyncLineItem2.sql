
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-03-15
-- Description:	Sync Invoice Line Item data
-- Change Log:  2013-02-13, Performance tuning, rewriting without MERGE

-- =============================================
CREATE PROCEDURE [expinvoice].[UspSyncLineItem2] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

				
						
	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice Line Item data';
	
	DELETE from expinvoice.LineItem 
		WHERE DateGenerated >= @lastSync;
		

	INSERT into expinvoice.LineItem 
		SELECT
			LI.Id as LineItemId, 
			CASE WHEN BC.Id is null THEN 0 ELSE BC.Id END as BillingCategoryId,
			CASE WHEN LI.ProductId is null THEN AP.Id else LI.ProductId END as ProductId,
			LI.InvoiceId,
			LI.DateGenerated,
			LI.LocationId,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodStart) as DatePeriodStart_Local,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodEnd) as DatePeriodEnd_Local,
			CASE WHEN LI.ChargeTypeId = 1 THEN LI.Charge ELSE null END as MonthlyCharge,
			CASE WHEN LI.ChargeTypeId = 2 THEN LI.Charge ELSE null END as OneTimeCharge,
			LI.FootnoteNumber,
			LI.Quantity,
			null -- InvoiceServiceGroupId
		FROM 
			mock.billing_InvoiceLineItem LI with(nolock)
			left join enum.BillingCategory BC on BC.Name = LI.Description
			left Join enum.Product AP on AP.Name = LI.Description -- to get ALT Product Name for Usage, Surcharge
		WHERE
			LI.DateGenerated >= @lastSync -- NOUTC
			and Li.locationId is not null
			; 

	PRINT convert(varchar,getdate(),14) + N': End syncing Invoice Line Item data';

END

