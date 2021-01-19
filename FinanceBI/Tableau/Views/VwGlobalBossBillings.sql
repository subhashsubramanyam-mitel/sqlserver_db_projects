






















 CREATE view [Tableau].[VwGlobalBossBillings] as
-- MW 03132018 MW test view for tableau
SELECT

-- ACCOUNT INFO: [company].[VwAccount]
	 [Ac Id]
	,[Ac Name]
	,[LichenAccountId]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	,[AccountManagerId]
	,'UK' AS Region

-- INVOICE INFO: [invoice].[VwLineItem]
	,[LineItemId]
	,[InvoiceId]
	,[DateGenerated]
	,[LocationId]
	,[Charge]
	,[ChargeCategory]
	,[OneTimeCharge]
	,[MonthlyCharge]
	,[Prorates]
	,[MRR]
	,[Usage]
	,[Credits]
	,[Regulatory]
	,[Surcharge]
	,[Unclassified]
	,[Tax]
	,[Quantity]

-- PRODUCT INFO: [enum].[VwProduct]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	,[Prod Id]
	,'UK-' + rtrim(str([Prod Id])) as [Prod Id (Unique)]
	,[Class RootName]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,c.Name as Country

-- Currency
   ,CurrencyCode
   ,Charge_LC
   ,OneTimeCharge_LC
   ,MonthlyCharge_LC

-- Contract
	,con.ContractDaysSinceStart
	,con.ContractDaysUtilEnd
	,con.ContractEndDate
	,con.ContractStartDate
	,con.ContractLength
	,con.ContractType

-- MW 06252019 for Ben
	, [VwAccount].SMRClusterName
	, [VwAccount].SMRPlatformName
	, Cluster
	--, [Platform]
	, [VwAccount].CCClusterName
	, [VwAccount].CCPlatformName

	,'EU-' +Convert(Char(15), l.InvoiceGroupId) as InvoiceGroupId
	,[VwAccount].DateFirstInvoiced
	,CASE
			WHEN [VwAccount].NumProfiles is null THEN null
			WHEN [VwAccount].NumProfiles = 0 THEN '0'
			WHEN [VwAccount].NumProfiles <= 50 then '1-50'
			WHEN [VwAccount].NumProfiles <= 250 then '51-250'
			WHEN [VwAccount].NumProfiles <= 500 then '251-500'
			WHEN [VwAccount].NumProfiles <= 2500 then '501-2500'
	ELSE '2501+' END as				SeatSizeSegment

,p.PartnerName
,p.PartnerName_Onsite

,'0' as IsMCSSEnabled

,p.PartnerOfRecordCloudSAPNumber collate database_default as [Partner SAP Number]

,'EU-' + ltrim(rtrim(str([Ac Id]) )) as  GlobalAccountId

FROM [EU_FinanceBI].[invoice].[VwLineItem_EX]

LEFT JOIN [EU_FinanceBI].[company].[VwAccount]
ON [VwLineItem_EX].[AccountId] = [VwAccount].[Ac Id]

LEFT JOIN [EU_FinanceBI].[enum].[VwProduct]
ON [VwLineItem_EX].[ProductId] = [VwProduct].[Prod Id]
LEFT JOIN [EU_FinanceBI].company.Location l on 
[VwLineItem_EX].LocationId = l.Id
LEFT JOIN [EU_FinanceBI].enum.Country c on l.CountryId = c.Id 
LEFT JOIN (
  select 
  [AccountId]
  ,StartDate as ContractStartDate, str(datediff (day, StartDate, getdate())) as ContractDaysSinceStart
 ,[EndDate] as ContractEndDate, str(datediff (day,  getdate() , EndDate)) as ContractDaysUtilEnd
 ,[ContractType]
 ,STR(ContractLength) as ContractLength
 from
 (
 select * from (
select CTH.AccountId 
     -- ,DateDiff(month, CTD.StartDate, CTD.EndDate)+1 TermMonths
      ,CTD.[StartDate]
      ,CTD.[EndDate]
	  ,C.ContractLength

,ACT.Name ContractType
 from [EU_FinanceBI].company.ContractTermDetail CTD
inner join [EU_FinanceBI].company.ContractTermHeader CTH on CTH.Id = CTD.AccountContractHeaderId 
inner join [EU_FinanceBI].enum.AccountContractType ACT on ACT.Id = CTD.ContractTypeId
left join [EU_FinanceBI].sales.Contract C on C.Id = CTD.SalesContractId 
inner join (select   Id,      EndDate , row_number() over  (Partition by AccountContractHeaderId order by EndDate desc) rn
				from [EU_FinanceBI].company.ContractTermDetail CTD2
				-- MW 09112020 check deleted
				where isDeleted = 0
) CTDM on CTDM.Id = CTD.Id and CTDM.rn = 1
) foo
 ) x
 ) con on [VwLineItem_EX].[AccountId] = con.AccountId
LEFT JOIN tableau.mVwSFDCCustInfo p on 'EU-' + str([VwAccount].[Ac Id]) = p.AccountId

UNION ALL

SELECT

-- ACCOUNT INFO: [company].[VwAccount]
	 [Ac Id]
	,[Ac Name]
	,[LichenAccountId]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	,[AccountManagerId]
	,'AU' AS Region

-- INVOICE INFO: [invoice].[VwLineItem]
	,[LineItemId]
	,[InvoiceId]
	,[DateGenerated]
	,[LocationId]
	,[Charge]
	,[ChargeCategory]
	,[OneTimeCharge]
	,[MonthlyCharge]
	,[Prorates]
	,[MRR]
	,[Usage]
	,[Credits]
	,[Regulatory]
	,[Surcharge]
	,[Unclassified]
	,[Tax]
	,[Quantity]

-- PRODUCT INFO: [enum].[VwProduct]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	,[Prod Id]
	,'AU-' + rtrim(str([Prod Id]))  as [Prod Id (Unique)]
	,[Class RootName]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,c.Name as Country
	

-- Currency
   ,CurrencyCode
   ,Charge_LC
   ,OneTimeCharge_LC
   ,MonthlyCharge_LC


-- Contract
	,con.ContractDaysSinceStart
	,con.ContractDaysUtilEnd
	,con.ContractEndDate
	,con.ContractStartDate
	,con.ContractLength
	,con.ContractType
	-- MW 06252019 for Ben
	, [VwAccount].SMRClusterName
	, [VwAccount].SMRPlatformName
	, Cluster
	--, [Platform]
	, [VwAccount].CCClusterName
	, [VwAccount].CCPlatformName
	,'AU-' +Convert(Char(15), l.InvoiceGroupId) as InvoiceGroupId
	,[VwAccount].DateFirstInvoiced
	   	,CASE
			WHEN [VwAccount].NumProfiles is null THEN null
			WHEN [VwAccount].NumProfiles = 0 THEN '0'
			WHEN [VwAccount].NumProfiles <= 50 then '1-50'
			WHEN [VwAccount].NumProfiles <= 250 then '51-250'
			WHEN [VwAccount].NumProfiles <= 500 then '251-500'
			WHEN [VwAccount].NumProfiles <= 2500 then '501-2500'
	ELSE '2501+' END as				SeatSizeSegment

,p.PartnerName
,p.PartnerName_Onsite

,'0' as IsMCSSEnabled

,p.PartnerOfRecordCloudSAPNumber collate database_default as [Partner SAP Number]

,'AU-' + ltrim(rtrim(str([Ac Id])) ) as  GlobalAccountId

FROM [AU_FinanceBI].[invoice].[VwLineItem_EX]

LEFT JOIN [AU_FinanceBI].[company].[VwAccount]
ON [VwLineItem_EX].[AccountId] = [VwAccount].[Ac Id]

LEFT JOIN [AU_FinanceBI].[enum].[VwProduct]
ON [VwLineItem_EX].[ProductId] = [VwProduct].[Prod Id]
LEFT JOIN [AU_FinanceBI].company.Location l on 
[VwLineItem_EX].LocationId = l.Id
LEFT JOIN [AU_FinanceBI].enum.Country c on l.CountryId = c.Id
LEFT JOIN  (
  select 
  [AccountId]
  ,StartDate as ContractStartDate, str(datediff (day, StartDate, getdate())) as ContractDaysSinceStart
 ,[EndDate] as ContractEndDate, str(datediff (day,  getdate() , EndDate)) as ContractDaysUtilEnd
 ,[ContractType]
 ,STR(ContractLength) as ContractLength
 from
 (
 select * from (
select CTH.AccountId 
     -- ,DateDiff(month, CTD.StartDate, CTD.EndDate)+1 TermMonths
      ,CTD.[StartDate]
      ,CTD.[EndDate]
	  ,C.ContractLength

,ACT.Name ContractType
 from [AU_FinanceBI].company.ContractTermDetail CTD
inner join [AU_FinanceBI].company.ContractTermHeader CTH on CTH.Id = CTD.AccountContractHeaderId 
inner join [AU_FinanceBI].enum.AccountContractType ACT on ACT.Id = CTD.ContractTypeId
left join [AU_FinanceBI].sales.Contract C on C.Id = CTD.SalesContractId 
inner join (select   Id,      EndDate , row_number() over  (Partition by AccountContractHeaderId order by EndDate desc) rn
				from [AU_FinanceBI].company.ContractTermDetail CTD2
								-- MW 09112020 check deleted
				where isDeleted = 0
) CTDM on CTDM.Id = CTD.Id and CTDM.rn = 1
) foo
 ) x ) con  on [VwLineItem_EX].[AccountId] = con.AccountId
LEFT JOIN tableau.mVwSFDCCustInfo p on 'AU-' + str([VwAccount].[Ac Id]) = p.AccountId

Union All

SELECT   

-- ACCOUNT INFO: [company].[VwAccount]
	 [Ac Id]
	,[Ac Name]
	,[LichenAccountId]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	,[AccountManagerId]
	,'US' AS Region

-- INVOICE INFO: [invoice].[VwLineItem]
	,[LineItemId]
	,[InvoiceId]
	,[DateGenerated]
	,[LocationId]
	,[Charge]
	,[ChargeCategory]
	,[OneTimeCharge]
	,[MonthlyCharge]
	,[Prorates]
	,[MRR]
	,[Usage]
	,[Credits]
	,[Regulatory]
	,[Surcharge]
	,[Unclassified]
	,[Tax]
	,[Quantity]

-- PRODUCT INFO: [enum].[VwProduct]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	,[Prod Id]
	,'US-' + rtrim(str([Prod Id]))  as [Prod Id (Unique)]
	,[Class RootName]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,c.Name as Country

-- Currency
   ,CurrencyCode
   ,Charge_LC
   ,OneTimeCharge_LC
   ,MonthlyCharge_LC

-- Contract
	,con.ContractDaysSinceStart
	,con.ContractDaysUtilEnd
	,con.ContractEndDate
	,con.ContractStartDate
	,con.ContractLength
	,con.ContractType
	-- MW 06252019 for Ben
	, [VwAccount].SMRClusterName
	, [VwAccount].SMRPlatformName
	, Cluster
--	, [Platform]
	, [VwAccount].CCClusterName
	, [VwAccount].CCPlatformName
	, Convert(Char(15), l.InvoiceGroupId) as InvoiceGroupId
	,[VwAccount].DateFirstInvoiced
		,CASE
			WHEN [VwAccount].NumProfiles is null THEN null
			WHEN [VwAccount].NumProfiles = 0 THEN '0'
			WHEN [VwAccount].NumProfiles <= 50 then '1-50'
			WHEN [VwAccount].NumProfiles <= 250 then '51-250'
			WHEN [VwAccount].NumProfiles <= 500 then '251-500'
			WHEN [VwAccount].NumProfiles <= 2500 then '501-2500'
	ELSE '2501+' END as				SeatSizeSegment

,p.PartnerName 
,p.PartnerName_Onsite

,cast([VwAccount].IsMCSSEnabled  as VarChar(1)) as IsMCSSEnabled

,p.PartnerOfRecordCloudSAPNumber collate database_default as [Partner SAP Number]

,'US-' + ltrim( rtrim(str([Ac Id]))) as  GlobalAccountId

FROM [invoice].[VwLineItem_EX]

LEFT JOIN [company].[VwAccount]
ON [VwLineItem_EX].[AccountId] = [VwAccount].[Ac Id]

LEFT JOIN [enum].[VwProduct]
ON [VwLineItem_EX].[ProductId] = [VwProduct].[Prod Id]
LEFT JOIN  company.Location l on 
[VwLineItem_EX].LocationId = l.Id
LEFT JOIN  enum.Country c on l.CountryId = c.Id
LEFT JOIN ( 
		select 
		  [AccountId]
		  ,StartDate as ContractStartDate, str(datediff (day, StartDate, getdate())) as ContractDaysSinceStart
		 ,[EndDate] as ContractEndDate, str(datediff (day,  getdate() , EndDate)) as ContractDaysUtilEnd
		 ,[ContractType]
		 ,STR(ContractLength) as ContractLength

		 from
		 (
		 select * from (
		select CTH.AccountId 
			 -- ,DateDiff(month, CTD.StartDate, CTD.EndDate)+1 TermMonths
			  ,CTD.[StartDate]
			  ,CTD.[EndDate]
			  ,C.ContractLength

		,ACT.Name ContractType
		 from company.ContractTermDetail CTD
		inner join company.ContractTermHeader CTH on CTH.Id = CTD.AccountContractHeaderId 
		inner join enum.AccountContractType ACT on ACT.Id = CTD.ContractTypeId
		left join sales.Contract C on C.Id = CTD.SalesContractId 
		inner join (select   Id,      EndDate , row_number() over  (Partition by AccountContractHeaderId order by EndDate desc) rn
						from company.ContractTermDetail CTD2
										-- MW 09112020 check deleted
				where isDeleted = 0
		) CTDM on CTDM.Id = CTD.Id and CTDM.rn = 1
		) foo
 ) x ) con on [VwLineItem_EX].[AccountId] = con.AccountId

 --MW 06232020 Bring in Partner
 LEFT JOIN tableau.mVwSFDCCustInfo p on [VwAccount].[Ac Id] = p.AccountId and isnumeric(p.AccountId) = 1

where year([invoice].[VwLineItem_EX].[DateGenerated]) >=2016






