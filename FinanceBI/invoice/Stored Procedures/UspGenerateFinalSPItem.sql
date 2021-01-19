-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-04-10
-- Description:	Generate final SP items from mergd SP item
-- Change Log:
-- =============================================
CREATE PROCEDURE [invoice].[UspGenerateFinalSPItem] 
	-- Add the parameters for the stored procedure here
	@lastSyncUTC datetime = NULL  -- 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin creating ServiceProductInvoiceItem data';
	
	INSERT INTO invoice.FinalSPItem
	SELECT *,
		ROW_NUMBER() over (PARTITION BY ServiceId, ProductId, ChargeCategoryId ORDER BY ServiceMonth ASC) 
			as CCRankAsc, 
		ROW_NUMBER() over (PARTITION BY ServiceId, ProductId, ChargeCategoryId ORDER BY ServiceMonth DESC)
			as CCRankDesc 
	FROM (
		SELECT  
			MIN(LocationId) LocationID, 
			ServiceId, ProductId, InvoiceId, 
			MAX(BillingCategoryId) BillingCategoryId,
			CASE WHEN BillingCategoryGroupName = 'OneTime' THEN 1 ELSE 3 END ChargeCategoryId, -- in postProcessing, separate out Prorates
			null as MonthlySubCategoryId, -- to be updated in postProcessing
			dbo.UfnFirstOfMonth(DatePeriodStart) ServiceMonth,
			MIN(DateGenerated) InvoiceMonth, 
			null as Charge, --to be updated in postProcessing
			MAX(OneTimeCharge) as OneTimeCharge,
			round(SUM(
				CASE WHEN OriginalPeriodLength > 1.0 and BillingCategoryGroupName = 'Monthly' THEN 
					invoice.UFnFractionalMonthsInPeriod(DatePeriodStart, DatePeriodEnd)*
								MonthlyCharge/OriginalPeriodLength
					ELSE 
						MonthlyCharge
					END),2) as MonthlyCharge,
			null as MRRDeltaForNextServiceMonth, -- to be updated in postProcessing
			MAX(MonthsBilled) as MonthsBilled,
			count(1) as LineItemCount
		FROM (
				SELECT 
					LocationId, ServiceId, ProductId, InvoiceId,
					CASE WHEN BC.GroupName in ('Credit', 'Monthly') THEN 'Monthly' ELSE BC.GroupName END as BillingCategoryGroupName,
					CASE WHEN BC.GroupName = 'Credit' THEN 0 Else BillingCategoryId END as BillingCategoryId, -- Credit will be merged into MRR
					
					CASE WHEN I.DatePeriodStart_Local > MR.Month THEN I.DatePeriodStart_Local ELSE MR.Month END as DatePeriodStart,
					CASE WHEN I.DatePeriodEnd_Local < MR.DateNextMonthStart THEN I.DatePeriodEnd_Local ELSE MR.DateNextMonthStart END as DatePeriodEnd,
					DateGenerated, 
					invoice.UFnFractionalMonthsInPeriod(DatePeriodStart_Local, DatePeriodEnd_Local) as OriginalPeriodLength,
					OneTimeCharge,
					MonthlyCharge,
					MonthsBilled
				FROM VwMergedSPItem I 
				inner join company.Location L on L.Id = I.LocationId
				inner join enum.VwMonthRange MR 
					on I.DatePeriodStart_Local < MR.DateNextMonthStart
					  and I.DatePeriodEnd_Local >= MR.DateNextMonthStart
				inner join enum.BillingCategory BC on BC.Id=I.BillingCategoryId
				WHERE
					 I.ServiceId <> -1
				) SI
		GROUP BY --LocationId, 
		ServiceId, ProductId, InvoiceId, BillingCategoryGroupName, dbo.UfnFirstOfMonth(DatePeriodStart)
	) FOO
	;	
	PRINT convert(varchar,getdate(),14) + N': End creating ServiceProductInvoiceItem data';

END
