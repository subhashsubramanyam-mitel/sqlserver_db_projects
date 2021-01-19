

CREATE view [commission].[VwPartnerCommissionBrief] as
select 
	
	invoiceMonth,
	--cast(DatePeriodStart as Date) DatePeriodStart,
	--cast(DatePeriodEnd as Date) DatePeriodEnd,
	PartnerID,
	Partner,
	Customer,
	Product,
	NetBilled,
	SalesComp

from Commission.VwPartnerCommission PC




