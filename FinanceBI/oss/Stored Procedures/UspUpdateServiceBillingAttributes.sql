-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-04-10
-- Description:	Sync Service Billing Attributes
-- Change Log:   2013-03-05, Tarak, Add MonthLastInvoiced
-- =============================================
create PROCEDURE oss.UspUpdateServiceBillingAttributes 
	-- Add the parameters for the stored procedure here
	@lastSyncUTC datetime = NULL  -- 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing ServiceProduct Attributes data';
	
		
		UPDATE oss.ServiceProduct 
			SET 
				MonthSetupInvoiced = LI.MonthSetupInvoiced ,
				MonthLastInvoiced = Li.MonthLastInvoiced,
				MonthMRRFirstInvoiced = LI.MonthMRRFirstInvoiced ,
				MonthMRRLastInvoiced = LI.MonthMRRLastInvoiced ,
				DateMRRInvoicedTo = LI.DateMRRInvoicedTo ,
				MonthCreditIssued = LI.MonthCreditIssued ,
				DateCreditedFrom = LI.DateCreditedFrom ,
				DateCreditedTo = LI.DateCreditedTo 
				
		FROM oss.ServiceProduct FSP
			inner join (
			  SELECT ServiceId, ProductId, 
				MAX(MonthSetupInvoiced) as MonthSetupInvoiced, 
				MAX(MonthLastInvoiced) as MonthLastInvoiced,  
				MAX(MonthMRRFirstInvoiced) as MonthMRRFirstInvoiced, 
				MAX(MonthMRRLastInvoiced) as MonthMRRLastInvoiced,
				MAX(DateMRRInvoicedTo) as DateMRRInvoicedTo,
				MAX(MonthCreditIssued) as MonthCreditIssued, 
				MAX(DateCreditedFrom) as DateCreditedFrom, 
				MAX(DateCreditedTo) as DateCreditedTo 
			  FROM (
				SELECT I.ServiceId, I.ProductId, 
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId, ChargeCategory ORDER BY DateGenerated ASC) = 1 
					AND ChargeCategory = 'Installs' 
					THEN I.DateGenerated ELSE null END as MonthSetupInvoiced,
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId, ChargeCategory ORDER BY DateGenerated ASC) = 1 
					AND ChargeCategory <> 'Credit' 
					THEN I.DateGenerated ELSE null END as MonthLastInvoiced,  -- need at least one non-credit charge
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId, ChargeCategory ORDER BY DateGenerated ASC) = 1 
					AND ChargeCategory = 'MRR' 
					THEN I.DateGenerated ELSE null END as MonthMRRFirstInvoiced, 			
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId, ChargeCategory ORDER BY DateGenerated DESC) = 1 
					AND ChargeCategory = 'MRR' 
					THEN I.DateGenerated ELSE null END as MonthMRRLastInvoiced, 
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId, ChargeCategory ORDER BY DatePeriodEnd_Local DESC) = 1 
					AND ChargeCategory = 'MRR' 
					THEN I.DatePeriodEnd_Local ELSE null END as DateMRRInvoicedTo, 
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId ORDER BY DateGenerated DESC, ChargeCategory DESC) = 1  -- 'Credit' being the only in DateGenerated
					AND ChargeCategory = 'Credit' 
					THEN I.DateGenerated ELSE null END as MonthCreditIssued, 
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId ORDER BY DateGenerated DESC, ChargeCategory DESC) = 1 
					AND ChargeCategory = 'Credit' 
					THEN I.DatePeriodStart_Local ELSE null END as DateCreditedFrom, 
				CASE WHEN ROW_NUMBER() over 
						(PARTITION BY I.ServiceId, ProductId ORDER BY DateGenerated DESC, ChargeCategory DESC) = 1 
					AND ChargeCategory = 'Credit' 
					THEN I.DatePeriodEnd_Local ELSE null END as DateCreditedTo 

				FROM invoice.VwSPItem I 
				) FOO
			  GROUP BY ServiceId, ProductId	 
			) LI
				on	LI.ServiceId = FSP.ServiceId
					and LI.ProductId = FSP.Productid
			;
	
		UPDATE oss.ServiceProduct	
			SET 
				DataIssueId = 0  -- clear all first
		;			
		UPDATE oss.ServiceProduct	
			SET 
				DataIssueId = 1
			FROM
				oss.ServiceProduct SP
			inner join (
				SELECT S.Id as ServiceId FROM M5DB.M5DB.dbo.service_Service S
				inner join (
					SELECT ServicePriceId, COUNT(1) num FROM (
						SELECT distinct ServicePriceId, LocationId from M5DB.M5DB.dbo.service_Service
						) foo
					GROUP BY ServicePriceId
					HAVING count(1) > 1
					) bar on bar.ServicePriceId = S.ServicePriceId
				) SS on SS.ServiceId = SP.ServiceId
	
	PRINT convert(varchar,getdate(),14) + N': End syncing ServiceProduct Attributes data';

END
