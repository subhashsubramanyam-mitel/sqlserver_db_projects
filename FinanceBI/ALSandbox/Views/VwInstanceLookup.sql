


CREATE VIEW ALSandbox.VwInstanceLookup 
AS
SELECT 
	SP.AccountId,  
	SP.LocationId,
	SP.ServiceID,	
	SP.TN,
	SP.[MonthlyCharge]			as MRR,
	case when prod.prodsubcategory = 'Managed Profiles' then 1 else null end as [Profiles],
	
	L.ConnectivityType			as [Loc Connectivitytype],

	acct.MonthsInService		as [Age (months)],	
	acct.[Ac Name],
	ldvs.cluster_name			as [Instance],
	acct.[Platform]				as [Platform],
	acct.CCClusterName			as [CC Instance],
	acct.CCPlatformName			as [CC Platform],

	prod.[Prod Name],

	T.Region,

	substring(ldvs.ldvs_hostname,12,1) as [LDVS],
	ldvs.switch_hostname as [Switch]


FROM  oss.ServiceProduct					as SP
left join company.VwLocation				as L on L.[Loc Id] = SP.LocationID
left join company.VwAccount					as acct on acct.[Ac Id] = SP.[AccountId] 
LEFT JOIN [sfdc].[vwTerritory]	as T on T.SfdcId = acct.SfdcTerritoryId 
left join enum.VwProduct					as prod on prod.[Prod Id] = SP.ProductId
left join
	(select
		cluster_name
		,ldvs_hostname
		,switch_hostname
		,substring(tn,len(tn)-9,10) as [tn2]
	from  ldvs.tenant_tn_ldvs
	) as ldvs 
		on ldvs.tn2 = SP.tn

-- other tables left over from tarak's svc prod query
--left join provision.VwTn		as T on T.Id = SP.TN
--left join company.VwAccount A on A.[Ac Id] = L.AccountId
--inner join enum.ServiceClass SC on SC.Id = SP.ServiceClassId
--left join enum.Product P on P.Id = SP.ProductId
--left join expinvoice.IncrIACP IA on IA.ServiceId = SP.ServiceId --and IA.ProdServiceClassId = P.ServiceClassId
--inner join    enum.CurrencyCode CC on CC.Id = SP.CurrencyId
--inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and today.thisdate >= EX.DateFrom and today.thisdate < EX.DateTo
--inner join (select dbo.UfnLastBilledMonth() LastBilledMonth) Const on 1=1

where SP.ProductId is not null and SP.servicestatusid = 1
	and acct.[Platform] = 'COSMO' and SP.tn is not null

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
UNION ALL

SELECT 
	SP.AccountId,  
	SP.LocationId,
	SP.ServiceID,	
	SP.TN,
	SP.[MonthlyCharge]			as MRR,
	case when prod.prodsubcategory = 'Managed Profiles' then 1 else null end as [Profiles],
	
	L.ConnectivityType			as [Loc Connectivitytype],

	acct.MonthsInService		as [Age (months)],	
	acct.[Ac Name],
	acct.Cluster				as [Instance],
	acct.[Platform]				as [Platform],
	acct.CCClusterName			as [CC Instance],
	acct.CCPlatformName			as [CC Platform],

	prod.[Prod Name],

	T.Region,

	NULL as [LDVS],
	NULL as [Switch]


FROM  oss.ServiceProduct		as SP

left join company.VwLocation	as L on L.[Loc Id] = SP.LocationID
left join company.VwAccount		as acct on acct.[Ac Id] = SP.[AccountId] 
LEFT JOIN [sfdc].[vwTerritory] as T on T.SfdcId = acct.SfdcTerritoryId 
left join enum.VwProduct		as prod on prod.[Prod Id] = SP.ProductId

-- other tables left over from tarak's svc prod query
--left join provision.VwTn		as T on T.Id = SP.TN
--left join company.VwAccount A on A.[Ac Id] = L.AccountId
--inner join enum.ServiceClass SC on SC.Id = SP.ServiceClassId
--left join enum.Product P on P.Id = SP.ProductId
--left join expinvoice.IncrIACP IA on IA.ServiceId = SP.ServiceId --and IA.ProdServiceClassId = P.ServiceClassId
--inner join    enum.CurrencyCode CC on CC.Id = SP.CurrencyId
--inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and today.thisdate >= EX.DateFrom and today.thisdate < EX.DateTo
--inner join (select dbo.UfnLastBilledMonth() LastBilledMonth) Const on 1=1

where SP.ProductId is not null and SP.servicestatusid = 1
		AND (acct.[Platform] != 'COSMO' or SP.tn is null or acct.[platform] is null)