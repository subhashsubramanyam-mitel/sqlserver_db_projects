














CREATE  view [dbo].[V_SFDC_ORDERS_ALL] as
--Orders for SFDC ORDER OBJECT LOAD MW 03182015
select  --top 10
OrderDate,
SalesOrder,
OptyId,
-- set non-existant accounts to a catch all account
-- needs a periodic update process
isnull(b.ImpactNumber,'77777') as PartnerId,
-- 
 --'001C000001NB5YfIAL'  as CustomerSfdcId,
 ISNULL(CustomerSfdcId, '001C000001NB5YfIAL' ) as CustomerSfdcId,  --default shoretel customer
OrderTotal,
ReqShipDate,
SecondaryOppId  ,
-- for jitterbit load
'Draft' as Status,
'01sC00000003Srq' as PriceBookId,
PONumber,
OrderType,
CustBuild,
--used in order creator orch to try to attach to real customer
CASE WHEN isnumeric(rtrim(a.CustomerId)) = 1 then replace(a.CustomerId, '.','') else 'NO' END AS CustomerId,
OrderCreateStatus ,
a.CustomerName
from
SFDC_OPTY_TRK a left outer join
SFDC_CUSTOMERS b on a.PartnerId = b.ImpactNumber collate database_default
--where   isnull(OrderCreateStatus,'N') = 'N' and
-- assuming this is not needed order load should come AFTER customer match or be based on Status-  CustomerSfdcId is not null  
-- FOR OC2
-- and OrderDate >= convert(Char(10), '07-01-2014',101) 
--AND OrderDate <  convert(Char(10), '04-01-2015',101)
--and SalesOrder = 'SO-858454'
 

-- truncate table SFDC_OPTY_TRK
-- truncate table SFDC_AX_BILLING_TRK
-- truncate table SFDC_POS_BILLING_TRK













