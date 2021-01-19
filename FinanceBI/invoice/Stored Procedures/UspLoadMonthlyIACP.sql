-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-01
-- Description:	Sync Billing Results for this Month (and subsequent months if any)
-- =============================================
create PROCEDURE invoice.UspLoadMonthlyIACP
	@invMonth Date
AS
BEGIN
delete from invoice.MonthlyIACP where InvoiceMonth >= @invMonth;

insert into invoice.MonthlyIACP 
	select * from M5DB.Billing.dbo.MonthlyIncrAnalysis where InvoiceMonth >= @invMonth

END
