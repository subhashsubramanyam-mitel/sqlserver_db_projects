









CREATE view [commission].[VwPartnerCommission] as

select 
	'Cloud Commissions' CommissionType, -- Normal
	invoiceMonth,
	cast(DatePeriodStart as Date) DatePeriodStart,
	cast(DatePeriodEnd as Date) DatePeriodEnd,
	PC.RepId SubAgentId,
	SubAgent,
	PC.RepName,
	CreditingPartnerId PartnerID,
	CreditingPartner		Partner,
	clientname		Customer,
	[Description]   Product,
	null Notes,
	--L.Id PortalLocationId,
	PC.lichenlocationid LichenLocationId,
	A.LichenAccountid ClienLichenAccountId,
	L.Address,
	L.City,
	L.ZipCode,
	Round(CommissionableBillingsAmount,8)	NetBilled,
	Round(PartnerCommissionAmount,8)			SalesComp,
	CASE WHEN PC.CommissionableBillingsAmount > 0 THEN (100* PartnerCommissionAmount/CommissionableBillingsAmount) ELSE 0.0 END SalesCompRate
	,T.Region 
	,T.Subregion
	,L.Id PortalLocationId

from Commission.History_PartnerCommission PC
left join Company.Location L on L.lichenlocationId = PC.lichenlocationid
left join Company.VwAccount A on A.[Ac Id] = L.AccountId 
left join sfdc.vwTerritory T on T.SfdcId = A.SfdcTerritoryId
left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
where PC.CreditingPartner is not null 
and PC.PartnerCommissionAmount <> 0.0
and PC.CommissionMonth > Intvl.TransitionMonth AND PC.CommissionMonth >= Intvl.Begin25Month

union all

select 
	'Cloud Commissions' CommissionType, -- Normal
	invoiceMonth,
	cast(DatePeriodStart as Date) DatePeriodStart,
	cast(DatePeriodEnd as Date) DatePeriodEnd,
	PC.RepId SubAgentId,
	SubAgent,
	PC.RepName,
	CreditingPartnerId PartnerID,
	CreditingPartner		Partner,
	clientname		Customer,
	[Description]   Product,
	null Notes,
	--L.Id PortalLocationId,
	PC.lichenlocationid LichenLocationId,
	A.LichenAccountid ClienLichenAccountId,
	L.Address,
	L.City,
	L.ZipCode,
	Round(CommissionableBillingsAmount,8)	NetBilled,
	Round(PartnerCommissionAmount,8)			SalesComp,
	CASE WHEN PC.CommissionableBillingsAmount > 0 THEN (100* PartnerCommissionAmount/CommissionableBillingsAmount) ELSE 0.0 END SalesCompRate
	,T.Region 
	,T.Subregion
	,L.Id PortalLocationId
from Commission.History_PartnerCommission_RPM PC
left join Company.Location L on L.lichenlocationId = PC.lichenlocationid
left join Company.VwAccount A on A.[Ac Id] = L.AccountId 
left join sfdc.vwTerritory T on T.SfdcId = A.SfdcTerritoryId
left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
where PC.CreditingPartner is not null 
and PC.PartnerCommissionAmount <> 0.0
and PC.CommissionMonth <= TransitionMonth and PC.CommissionMonth >= Begin25Month

union all

select 
	'Adjustments' CommissionType, -- Ajustment
      DateAdd(month, -1, [PCMonth]) InvoiceMonth
	  ,cast ([PCMonth] as date) DatePeriodStart
	  ,cast (dateadd(day, -1, dateadd(month, 1, [PCMonth])) as date) DatePeriodEnd  
	  ,[RepId] SubAgentId
	  ,[SubAgent]
	  ,[RepName]
	  ,[CreditingPartnerID] PartnerID
      ,[CreditingPartner] Partner
	  ,HA.ClientName Customer
	  ,HA.Type Product
	  ,HA.Notes
	  --,null PortalLocationId
	  ,null LichenLocationId
	  ,HA.LichenAccountId ClientLichenAccountid
	  ,HA.Address Adddress
	  ,HA.City City
	  ,HA.ZipCode ZipCode
      ,Round([NetBilled],8) NetBilled
      --,[Gross Comm] SalesComp
      ,Round([SalesComm],8) SalesComp
	  , CASE WHEN HA.[NetBilled]>0 THEN (100* HA.[SalesComm]/HA.[NetBilled]) Else 0.0 END SalesCompRate
  	  , null
	  , null
	  , null
  FROM [commission].[History_Adjustment] HA
 left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
 where HA.[PCMonth] > TransitionMonth and HA.[PCMonth] >= Begin25Month

union all

select 
	'Adjustments' CommissionType, -- Ajustment
      DateAdd(month, -1, [PC Month]) InvoiceMonth
	  ,cast ([PC Month] as date) DatePeriodStart
	  ,cast (dateadd(day, -1, dateadd(month, 1, [PC Month])) as date) DatePeriodEnd  
	  ,[RepId] SubAgentId
	  ,[SubAgent]
	  ,[RepName]
	  ,[Crediting Partner ID] PartnerID
      ,[Crediting Partner] Partner
	  ,null Customer
	  ,HA.Type Product
	  ,HA.Notes
	  --,null PortalLocationId
	  ,null LichenLocationId
	  ,null ClientLichenAccountid
	  ,null Adddress
	  ,null City
	  ,null ZipCode
      ,Round([Net Billed],8) NetBilled
      --,[Gross Comm] SalesComp
      ,Round([Sales Comm],8) SalesComp
	  , CASE WHEN HA.[Net Billed]>0 THEN (100* HA.[Sales Comm]/HA.[Net Billed]) Else 0.0 END SalesCompRate
	  , null
	  , null
	  , null
  FROM [commission].[History_Adjustment_RPM] HA
 left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
  where HA.[PC Month] <= TransitionMonth and HA.[PC Month] >= Begin25Month










