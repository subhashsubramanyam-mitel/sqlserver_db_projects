
-- =============================================
-- JO 03062015 Callidus delete current month to date for reload
-- JO 06012015 On 1st and 2nd of each month delete previous month.
-- ============================================= 

CREATE PROCEDURE   [dbo].[CleanCallidusSalesDaily] AS

--Only on 1st and 2nd of each month delete previous month
if  (select day(getdate()))  IN ('1','2')
BEGIN
delete from CallidusSalesComp
Where InvoiceDate >= DATEADD(mm,-1,DATEADD(mm,DATEDIFF(mm,0,GETDATE()),0)) AND InvoiceDate < DATEADD(mm,DATEDIFF(mm,0,GETDATE()),0)
END

ELSE
delete from CallidusSalesComp
Where InvoiceDate>=DATEADD(mm,DATEDIFF(mm,0,GETDATE()),0) and InvoiceDate<CONVERT(varchar(10),getdate()-1,23)

