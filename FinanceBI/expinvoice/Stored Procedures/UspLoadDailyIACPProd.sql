

-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-01
-- Description:	Sync Billing Results for Next Month
-- =============================================
CREATE PROCEDURE [expinvoice].[UspLoadDailyIACPProd]
	@rundate date -- 
AS
BEGIN
	truncate table expinvoice.IncrIACP;
	insert into expinvoice.IncrIACP 
	select * from M5DB_Prod.Billing.dbo.IncrAnalysis where InvoiceDay = @rundate

END


