-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-01
-- Description:	Sync Billing Results for this Month (and subsequent months if any)
-- =============================================
CREATE PROCEDURE [invoice].[UspLoadMonthlyIACPProd]
	@invMonth Date
AS
BEGIN
delete from invoice.MonthlyIACP where InvoiceMonth >= @invMonth;

insert into invoice.MonthlyIACP 
	select * from M5DB_Prod.Billing.dbo.MonthlyIncrAnalysis where InvoiceMonth >= @invMonth

END
