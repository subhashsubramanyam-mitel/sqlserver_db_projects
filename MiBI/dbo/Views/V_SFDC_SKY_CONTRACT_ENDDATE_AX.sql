 /*
 CREATE view  [dbo].[V_SFDC_SKY_CONTRACT_ENDDATE_AX] as
 --View for end date sync to AX.  SHows accounts that need end date sync MW 08262015
 select 
a.ShoretelId,  convert(Char(10),a.ContractEndDate, 120) as  ContractEndDate
from 
V_SFDC_SKY_CONTRACT_ENDDATE a inner join
SVLCORPAXDB1.PROD.dbo.CUSTTABLE b on a.ShoretelId  =b.ACCOUNTNUM   collate database_default
Where
--b.STCONTRACTENDDATE <> '1900-01-01 00:00:00.000' and
 convert(Char(10),a.ContractEndDate, 120) <> convert(Char(10),b.STCONTRACTENDDATE, 120)
 */