


-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2017-09-29
-- Description:	Partner Commission by Customer, Product, Month
-- =============================================
CREATE FUNCTION [commission].[UfnPartnerCommissionByCustomerProductMonth] 
(	
	@PCMonth  Date -- Partner Commission Month
)
RETURNS TABLE 
AS
RETURN 
(
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
		from commission.mVwPartnerCommissionUID PC
		where PC.invoiceMonth = DateAdd(month, -1, @PCMonth )
	group by  InvoiceMonth, Partner, CommissionType,Customer, Product
)


