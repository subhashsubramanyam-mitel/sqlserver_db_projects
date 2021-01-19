



-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2017-09-29
-- Description:	Partner Commission for specific PC Month
-- Change Log: 
--        2019-06-03 Added Commission Month
--		  2019-06-28 Added PortalAccountId
--		  2020-11-02 Added PaymentPlan
-- =============================================
CREATE FUNCTION [commission].[UfnPartnerCommissionUID] 
(	
	@PCMonth  Date -- Partner Commission Month
)
RETURNS TABLE 
AS
RETURN 
(
select 
	concat('C', format(PC.invoiceMonth, 'yyyyMM'), '-',convert(varchar(15),PC.commissionId)) UID,
	'Cloud Commissions' CommissionType -- Normal
	,PC.Region PortalRegion -->
	,invoiceMonth
	,cast(DatePeriodStart as Date) DatePeriodStart
	,cast(DatePeriodEnd as Date) DatePeriodEnd
	,PC.SubAgentId  -->
	,SubAgent
	,PC.RepName
	,CreditingPartnerId PartnerID
	,CreditingPartner		Partner
	,clientname		Customer
	,[Description]   Product
	,null Notes
	,PC.LocationId PortalLocationId  -->
	,PC.AccountID PortaAccountId  -->
	,PC.Address  -->
	,PC.City  -->
	,PC.ZipCode  -->
	,CASE WHEN C.PartnerCurrencyCode is null THEN 'USD' else C.PartnerCurrencyCode end PartnerCurrencyCode
	,CASE WHEN C.PartnerCurrencyCode is null THEN Round(CommissionableBillingsAmount,8)
		 else Round([CommissionableBillingsAmount LC],8) end NetBilled_PC
	,CASE WHEN C.PartnerCurrencyCode is null THEN Round(PartnerCommissionAmount,8)
		 else Round([PartnerCommissionAmount LC],8) end SalesComp_PC
	,Round(CommissionableBillingsAmount,8)	NetBilled
	,Round(PartnerCommissionAmount,8)			SalesComp
	,CASE WHEN PC.CommissionableBillingsAmount > 0 THEN 
		(100* PartnerCommissionAmount/CommissionableBillingsAmount) ELSE 0.0 END SalesCompRate
	,T.Region 
	,T.Subregion
	,PC.lichenlocationid LichenLocationId  -->
	,PC.LichenAccountid ClienLichenAccountId  -->
	,PC.PaymentPlan
from Commission.History_PartnerCommission PC
left join Commission.PartnerCurrency C on C.PartnerId = PC.CreditingPartnerId
left join [Global].VwAccountMap AM on AM.M5dbAccountId = PC.AccountID and AM.Region = PC.Region
left join sfdc.vwTerritory T on T.SfdcId = AM.SfdcTerritoryId
where PC.CreditingPartner is not null 
and PC.PartnerCommissionAmount <> 0.0
and PC.PCMonth = @PCMonth

union all

select 
	concat('A', format(HA.invoiceMonth, 'yyyyMM'), '-',convert(varchar(15),HA.Id)) UID,
	'Adjustments' CommissionType -- Ajustment
	,HA.Region PortalRegion -->
      ,DateAdd(month, -1, [PCMonth]) InvoiceMonth
	  ,cast ([PCMonth] as date) DatePeriodStart
	  ,cast (dateadd(day, -1, dateadd(month, 1, [PCMonth])) as date) DatePeriodEnd  
	  ,SubAgentId
	  ,[SubAgent]
	  ,[RepName]
	  ,[CreditingPartnerID] PartnerID
      ,[CreditingPartner] Partner
	  ,HA.ClientName Customer
	  ,HA.Type Product
	  ,HA.Notes
	 ,null PortalLocationId  -->
	 ,HA.AccountID PortaAccountId  -->
	  ,HA.Address Adddress
	  ,HA.City City
	  ,HA.ZipCode ZipCode
	,CASE WHEN C.PartnerCurrencyCode is null THEN 'USD' else C.PartnerCurrencyCode end PartnerCurrencyCode
	,CASE WHEN C.PartnerCurrencyCode is null THEN Round([NetBilled],8)
		 else Round([NetBilled_LC],8) end NetBilled_PC
	,CASE WHEN C.PartnerCurrencyCode is null THEN Round(SalesComm,8)
		 else Round([SalesComm_LC],8) end SalesComp_PC
      ,Round([NetBilled],8) NetBilled
      ,Round([SalesComm],8) SalesComp
	  , CASE WHEN HA.[NetBilled]>0 THEN (100* HA.[SalesComm]/HA.[NetBilled]) Else 0.0 END SalesCompRate
  	  , T.Region
	  , T.Subregion
	  ,null LichenLocationId
	  ,HA.LichenAccountId ClientLichenAccountid
	  ,HA.PaymentPlan
 FROM [commission].[History_Adjustment] HA
left join Commission.PartnerCurrency C on C.PartnerId = HA.CreditingPartnerId
 left join [Global].VwAccountMap AM on AM.M5dbAccountId = HA.AccountID and AM.Region = HA.Region
 left join sfdc.vwTerritory T on T.SfdcId = AM.SfdcTerritoryId
 where HA.[PCMonth] = @PCMonth
)


