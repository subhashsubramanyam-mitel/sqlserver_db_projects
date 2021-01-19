

-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-01-20
-- Description:	Sync Invoice Service Product Item data
-- Change Log:  2013-02-13, Performance tuning, rewriting without MERGE
-- =============================================
CREATE PROCEDURE [expinvoice].[UspSyncSPItemProd] 
	-- Add the parameters for the stored procedure here
	@syncDate datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice Service Product Item data';

	DELETE from expinvoice.SPItem 
		WHERE DateGenerated < DateAdd(month, -1, @syncDate); -- delete older than one month
	
	DELETE from expinvoice.SPItem 
		WHERE DateGenerated >= @syncDate;
		
	Declare @RunDate Varchar(12) = Convert(varchar(10), @SyncDate, 120);
	
	Declare @query Varchar(8000) = '
		INSERT into expinvoice.SPItem 
		SELECT 
			LI.Id as LineItemId, 
			CASE WHEN BC.Id is null THEN 0 ELSE BC.Id END as BillingCategoryId,
			CASE WHEN LI.ProductId is null THEN -1 ELSE LI.ServiceId END as ServiceId,
			CASE WHEN LI.ProductId is null THEN AP.Id else LI.ProductId END as ProductId,
			LI.InvoiceId,
			LI.DateGenerated,
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
		FROM ( 
			select LI.Id, LI.Description, LI.ProductId, LIS.ServiceId, LI.InvoiceId,
				LIS.DateGenerated, LI.LocationId, LI.DatePeriodStart, LI.DatePeriodEnd,
				LI.ChargeTypeId, LI.Charge, LI.FootnoteNumber
			from	mock.billing_InvoiceLineItem LI with(nolock)
			inner join mock.billing_InvoiceService LIS 
				on LIS.InvoiceLineItemId = LI.Id and LIS.DateGenerated >= '''
				+ @RunDate + 
			''' 
			where LI.DateGenerated >= '''+@RunDate +
			'''
			) LI
			left join oss.ServiceProduct FSP on FSP.ServiceId = LI.ServiceId and 
				FSP.ProductId = LI.ProductId
			left join enum.BillingCategory BC on BC.Name = LI.Description
			left Join enum.Product AP on AP.Name = LI.Description -- to get ALT Product Name for Usage, Surcharge
		WHERE
		 BC.id <> 486 -- for this category, the charge is precomputed even though services are pointing
		 and LI.LocationId is not null
		 ';
		--print @query;
		EXEC (@query);
		 
		PRINT convert(varchar,getdate(),14) + N': End syncing Invoice Service Product Item data';

END


