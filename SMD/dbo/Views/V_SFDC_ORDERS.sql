
















CREATE  view [dbo].[V_SFDC_ORDERS] as
--Orders for SFDC ORDER OBJECT LOAD MW 03182015
select  --top 10
OrderDate,
SalesOrder,
OptyId,
-- set non-existant accounts to a catch all account
-- needs a periodic update process
isnull(b.ImpactNumber,'10000') as PartnerId,
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
CustomerName,
--Lower(CustomerName) as LowerCustomerName,
QNumber
from
SFDC_OPTY_TRK a left outer join
SFDC_CUSTOMERS b on a.PartnerId = b.ImpactNumber collate database_default
where   isnull(OrderCreateStatus,'N') = 'N'  
--and a.PartnerId <> '50662'
-- assuming this is not needed order load should come AFTER customer match or be based on Status-  CustomerSfdcId is not null  
-- FOR OC2
-- Getting rid of this, date restriction is in loader. --MW 05192015
		--and OrderDate >= convert(Char(10), '01-01-2015',101) 
--AND OrderDate <  convert(Char(10), '04-01-2015',101)
--and SalesOrder = 'SO-858454'
 

-- truncate table SFDC_OPTY_TRK
-- truncate table SFDC_AX_BILLING_TRK
-- truncate table SFDC_POS_BILLING_TRK















