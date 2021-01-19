-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-25
-- Description:	Sync Service Product Item data
-- Change Log:  2013-02-13, Performance tuning, rewriting without MERGE
-- =============================================
CREATE PROCEDURE [invoice].[UspSyncSPItem] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--DECLARE @lastSync Datetime = '2015-07-01'
	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice Service Product Item data';
	--DECLARE @lastSync Datetime = '2015-02-01'
	DELETE from invoice.SPItem 
		WHERE DateGenerated >= @lastSync;
	-- Maintain a local copy for performance
	DELETE from invoice.billing_InvoiceService
		WHERE DateGenerated >= @lastSync;
	INSERT INTO invoice.billing_InvoiceService
		(Id, DateGenerated, InvoiceLineItemId, ServiceBillingPeriodId, ServiceId, DateModified,DateCreated, ModifiedBy)
	SELECT 
		Id, DateGenerated, InvoiceLineItemId, ServiceBillingPeriodId, ServiceId, DateModified,DateCreated, ModifiedBy
	FROM M5DB.M5DB.dbo.billing_InvoiceService
		where DateGenerated >= @lastSync

--
	INSERT into invoice.SPItem 
		SELECT
			LI.Id as LineItemId, 
			CASE WHEN BC.Id is null THEN 0 ELSE BC.Id END as BillingCategoryId,
			CASE WHEN LI.ProductId is null THEN -1 ELSE LIS.ServiceId END as ServiceId,
			CASE WHEN LI.ProductId is null THEN AP.Id else LI.ProductId END as ProductId,
			LI.InvoiceId,
			dbo.UfnFirstOfMonth(LI.DateGenerated) as DateGenerated,
			LI.LocationId,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodStart) as DatePeriodStart_Local,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodEnd) as DatePeriodEnd_Local,
			CASE WHEN LI.ChargeTypeId = 1 THEN LI.Charge ELSE null END as MonthlyCharge,
			CASE WHEN LI.ChargeTypeId = 2 THEN LI.Charge ELSE null END as OneTimeCharge,
			LI.FootnoteNumber,
			invoice.UfnMonthsBilled(FSP.DateBillingValidFrom, FSP.DateBillingValidTo, 
								dbo.UfnFirstOfMonth(LI.DateGenerated))
				as MonthsBilled,
			NULL -- Invoice Service groupId	
		FROM 
			invoice.billing_InvoiceLineItem LI with(nolock)
			left join enum.BillingCategory BC on BC.Name = LI.Description
			left Join enum.Product AP on AP.Name = LI.Description -- to get ALT Product Name for Usage, Surcharge
			left join invoice.billing_InvoiceService LIS 
				on LIS.InvoiceLineItemId = LI.Id 
				and BC.Id <> 486 -- for this category, the charge is precomputed even though services are pointing
			left join oss.ServiceProduct FSP on FSP.ServiceId = LIS.ServiceId and FSP.ProductId = LI.ProductId
		WHERE
			LI.DateGenerated >= @lastSync and (LIS.DateGenerated is null or LIS.DateGenerated >= @lastSync);

	PRINT convert(varchar,getdate(),14) + N': End syncing Invoice Service Product Item data';

END
