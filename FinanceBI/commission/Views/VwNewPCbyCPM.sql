






Create view [commission].[VwNewPCbyCPM] as
select 
	InvoiceMonth
	,max(PartnerId) PartnerId
	,Partner
	,CommissionType
	,Customer
	,Product
	,max(PartnerCurrencyCode) PartnerCurrencyCode
	,Sum(NetBilled_PC) NetBilled_PC
	,Sum(SalesComp_PC) SalesComp_PC
	,Sum(NetBilled) NetBilled
	,Sum(SalesComp) SalesComp
	,null Notes
	from commission.VwNewPC 
group by  InvoiceMonth, Partner, CommissionType,Customer, Product

