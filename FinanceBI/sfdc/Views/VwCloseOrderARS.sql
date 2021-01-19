




 CREATE view [sfdc].[VwCloseOrderARS] as
-- MW 20200924  Close Order ARS. linked to Boss Close Order for MRR delta / Churn
with CloseOrders as
(
select 
	 Id as OrderId
	,CaseNumber
	,AccountId
	,DateBillingStopped
	,DateCreated
	,Row_number() over (partition by CaseNumber order by DateCreated desc) rn
from oss.[Order] 
where OrderTypeId = 4 and  --close orders
 ISNUMERIC(CaseNumber) = 1 and CaseNumber <>0
 
) ,   x as 
(
select
	a.OrderId, 
	a.AccountId,
	a.CaseNumber,
	b.RootCausePrimary	as ARS_RootCausePrimary,
	b.RootCauseSecondary as ARS_RootCauseSecondary,
	b.RootCauseTertiary	as ARS_RootCauseTertiary,
	b.Status as ARS_Status,
	b.RelatedProduct as ARS_RelatedProduct
   ,b.Case_ChurnReasonPrimary
   ,b.Case_ChurnReasonSecondary
   ,b.Case_RelatedProduct
   ,a.DateBillingStopped as Order_DateBillingStopped
   ,a.DateCreated as Order_CreateDate
	 ,Row_number() over (partition by a.AccountId order by a.DateCreated desc) rn
from
	CloseOrders a inner join
	[sfdc].[VwARSClose] b on a.CaseNumber = b.CaseNumber and a.rn = 1
)

select * from x where rn =1 

