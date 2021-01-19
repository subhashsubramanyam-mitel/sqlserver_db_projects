-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-09-14'
-- Description:	Incrementally Update Service Billing Attributes After Monthly Billing
-- Change Log:  
-- =============================================
Create PROCEDURE [oss].[UspUpdateIncrServiceBillingAttributes] 
	-- Add the parameters for the stored procedure here
	@FirstOfBillingmonth datetime = NULL  -- 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing ServiceProduct Attributes data';
	
		
		UPDATE FSP 
			SET 
				MonthSetupInvoiced = 
					CASE WHEN FSP.MonthSetupInvoiced is null THEN LI.MonthSetupInvoiced 
						ELSE FSP.MonthSetupInvoiced END,
				MonthLastInvoiced = 
					CASE WHEN LI.MonthLastInvoiced is null THEN FSP.MonthLastInvoiced
						ELSE LI.MonthLastInvoiced END,
				MonthMRRFirstInvoiced = 
					CASE WHEN FSP.MonthMRRFirstInvoiced is null THEN LI.MonthMRRInvoiced 
						ELSE FSP.MonthMRRFirstInvoiced END,
				MonthMRRLastInvoiced = 
					CASE WHEN LI.MonthMRRInvoiced is null THEN FSP.MonthMRRLastInvoiced
						ELSE LI.MonthMRRInvoiced END ,
				DateMRRInvoicedTo = CASE WHEN LI.DateMRRInvoicedTo is null THEN FSP.DateMRRInvoicedTo
						ELSE LI.DateMRRInvoicedTo END ,
				MonthCreditIssued = CASE WHEN LI.MonthCreditIssued is null THEN FSP.MonthCreditIssued
						ELSE LI.MonthCreditIssued END ,
				DateCreditedFrom = CASE WHEN LI.DateCreditedFrom is null THEN FSP.DateCreditedFrom
						ELSE LI.DateCreditedFrom END ,
				DateCreditedTo = CASE WHEN LI.DateCreditedTo is null THEN FSP.DateCreditedTo
						ELSE LI.DateCreditedTo END 
				
		FROM oss.ServiceProduct FSP
			inner join (
			  SELECT ServiceId, ProductId, 
				MAX(MonthSetupInvoiced) as MonthSetupInvoiced, 
				MAX(MonthLastInvoiced) as MonthLastInvoiced,  
				MAX(MonthMRRInvoiced) as MonthMRRInvoiced, 
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
						(PARTITION BY I.ServiceId, ProductId, ChargeCategory ORDER BY DateGenerated DESC) = 1 
					AND ChargeCategory = 'MRR' 
					THEN I.DateGenerated ELSE null END as MonthMRRInvoiced, 			
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
				where I.DateGenerated between @FirstOfBillingmonth and DateAdd(day, 28, @FirstOfBillingMonth)
				) FOO
			  GROUP BY ServiceId, ProductId	 
			) LI
				on	LI.ServiceId = FSP.ServiceId
					and LI.ProductId = FSP.Productid
			;
	
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing ServiceProduct Attributes data';

END
