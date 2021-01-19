
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2019-05-22
-- Description:	Partner Commission for specific PC Month with modified group by clause
-- Change Log: 
--        2019-06-03 Added Commission Month
--		  2019-06-28 Added PortalAccountId
--		  2020-11-02 Added PaymentPlan
-- =============================================
CREATE FUNCTION [commission].[UfnPartnerCommissionCompact] (
	@PCMonth DATE -- Partner Commission Month and Portal Region
	)
RETURNS TABLE
AS
RETURN (
		SELECT InvoiceMonth
			,max(PartnerId) PartnerId
			,Partner
			,CommissionType
			,Customer
			,Product
			,[DatePeriodStart]
			,[DatePeriodEnd]
			,[SubAgentId]
			,[SubAgent]
			,[RepName]
			,[Notes]
			,[PortalRegion]
			,[PortalLocationId]
			,[PortalAccountId]
			,[Address]
			,[City]
			,[ZipCode]
			,[SalesCompRate]
			,[LichenLocationId]
			,[ClienLichenAccountId]
			,count(1) Quantity
			,max(PartnerCurrencyCode) PartnerCurrencyCode
			,Sum(convert(DECIMAL(19, 4), NetBilled_PC)) NetBilled_PC
			,Sum(convert(DECIMAL(19, 4), SalesComp_PC)) SalesComp_PC
			,Sum(convert(DECIMAL(19, 4), NetBilled)) NetBilled
			,Sum(convert(DECIMAL(19, 4), SalesComp)) SalesComp
			,@PCMonth CommissionMonth
			,[PaymentPlan]
		FROM commission.mVwPartnerCommissionUID PC
		WHERE PC.invoiceMonth = DateAdd(month, - 1, @PCMonth)
		GROUP BY InvoiceMonth
			,Partner
			,CommissionType
			,Customer
			,Product
			,[CommissionType]
			,[DatePeriodStart]
			,[DatePeriodEnd]
			,[SubAgentId]
			,[SubAgent]
			,[RepName]
			,[Notes]
			,[PortalRegion]
			,[PortalLocationId]
			,[PortalAccountId]
			,[Address]
			,[City]
			,[ZipCode]
			,[PartnerCurrencyCode]
			,[SalesCompRate]
			,[LichenLocationId]
			,[ClienLichenAccountId]
			,[PaymentPlan]
		)
