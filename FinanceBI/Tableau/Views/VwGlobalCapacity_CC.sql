




 


CREATE View [Tableau].[VwGlobalCapacity_CC] as
-- MW 03152018 view for Evodio in Tab Server

SELECT    
 
	 'US' AS Region
	,[Ac Name]
	,[IsBillable]
 	,[Platform]
 
	,[Prod Name]
 
	,DateSvcLiveActual
 
	,Cluster
	 
	,ss.Name as ServiceStatus
 
	,VwServiceProduct_EX.[ProductId]
 
  
	, [VwAccount].CCClusterName
	, [VwAccount].CCPlatformName
 
 
	, 'US' +'-' + convert(varchar(10),[VwAccount].[Ac Id]) as AccountId
 
 

 
 FROM --oss.VwServiceProduct_EX
      -- MW 05212019  changed to materialized view.  this is created from tableau.initPipeline which is called from Tableau connection
		  tableau.mVwServiceProduct_EX VwServiceProduct_EX
left join enum.ServiceStatus ss on VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN [company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
LEFT JOIN [enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
 
/*

select * from oss.VwOrder where OrderId = 1249763



select * from tableau.VwContractLookup where ContractNumber = '12345' and AccountId = 23130 and rn = 1

(select 
	AccountId, 
	StartDate as ContractStartDate 
	,ContractCreateDate
 from (
select CTH.AccountId 
     -- ,DateDiff(month, CTD.StartDate, CTD.EndDate)+1 TermMonths
     ,CTD.[StartDate]
	 ,CTD.DateCreated as ContractCreateDate
   --   ,CTD.[EndDate]
	  --,C.ContractLength
--,ACT.Name ContractType
 from 
	        company.ContractTermDetail CTD
inner join  company.ContractTermHeader CTH on CTH.Id = CTD.AccountContractHeaderId 
inner join  enum.AccountContractType ACT on ACT.Id = CTD.ContractTypeId
--left join [EU_FinanceBI].sales.Contract C on C.Id = CTD.SalesContractId 
inner join (select   Id,      EndDate , row_number() over  (Partition by AccountContractHeaderId order by EndDate desc) rn
				from  company.ContractTermDetail CTD2
) CTDM on CTDM.Id = CTD.Id and CTDM.rn = 1
) foo ) con on [VwAccount].[Ac Id] = con.AccountId
*/


 
 

UNION ALL
SELECT  
 
	 'AU' AS Region
 	,[Ac Name]
	,[IsBillable]
 	,[Platform]
 
	,[Prod Name]
 
	,DateSvcLiveActual
 
	,Cluster
	 
	,ss.Name as ServiceStatus
 
	,VwServiceProduct_EX.[ProductId]
 
  
	, [VwAccount].CCClusterName
	, [VwAccount].CCPlatformName
		, 'AU' +'-' + convert(varchar(10),[VwAccount].[Ac Id]) as AccountId

FROM AU_FinanceBI.oss.VwServiceProduct_EX
left join AU_FinanceBI.enum.ServiceStatus ss on VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN AU_FinanceBI.[company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
LEFT JOIN AU_FinanceBI.[enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
 

/*  select * from AU_FinanceBI.company.VwContractDetail where OpportunityNumber = 1169340

(select 
	AccountId, 
	StartDate as ContractStartDate 
	,ContractCreateDate
 from (
select CTH.AccountId 
     -- ,DateDiff(month, CTD.StartDate, CTD.EndDate)+1 TermMonths
     ,CTD.[StartDate]
	 ,CTD.DateCreated as ContractCreateDate
   --   ,CTD.[EndDate]
	  --,C.ContractLength
--,ACT.Name ContractType
 from 
	       [AU_FinanceBI].company.ContractTermDetail CTD
inner join [AU_FinanceBI].company.ContractTermHeader CTH on CTH.Id = CTD.AccountContractHeaderId 
inner join [AU_FinanceBI].enum.AccountContractType ACT on ACT.Id = CTD.ContractTypeId
--left join [EU_FinanceBI].sales.Contract C on C.Id = CTD.SalesContractId 
inner join (select   Id,      EndDate , row_number() over  (Partition by AccountContractHeaderId order by EndDate desc) rn
				from [AU_FinanceBI].company.ContractTermDetail CTD2
) CTDM on CTDM.Id = CTD.Id and CTDM.rn = 1
) foo ) con on [VwAccount].[Ac Id] = con.AccountId
*/

UNION ALL


SELECT  
 
	 'UK' AS Region
 	,[Ac Name]
	,[IsBillable]
 	,[Platform]
 
	,[Prod Name]
 
	,DateSvcLiveActual
 
	,Cluster
	 
	,ss.Name as ServiceStatus
 
	,VwServiceProduct_EX.[ProductId]
 
  
	, [VwAccount].CCClusterName
	, [VwAccount].CCPlatformName

 	, 'UK' +'-' + convert(varchar(10),[VwAccount].[Ac Id]) as AccountId

FROM EU_FinanceBI.oss.VwServiceProduct_EX
left join EU_FinanceBI.enum.ServiceStatus ss on VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN EU_FinanceBI.[company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
LEFT JOIN EU_FinanceBI.[enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
 

/* (select 
	AccountId, 
	StartDate as ContractStartDate 
	,ContractCreateDate
 from (
select CTH.AccountId 
     -- ,DateDiff(month, CTD.StartDate, CTD.EndDate)+1 TermMonths
     ,CTD.[StartDate]
	 ,CTD.DateCreated as ContractCreateDate
   --   ,CTD.[EndDate]
	  --,C.ContractLength
--,ACT.Name ContractType
 from 
	       [EU_FinanceBI].company.ContractTermDetail CTD
inner join [EU_FinanceBI].company.ContractTermHeader CTH on CTH.Id = CTD.AccountContractHeaderId 
inner join [EU_FinanceBI].enum.AccountContractType ACT on ACT.Id = CTD.ContractTypeId
--left join [EU_FinanceBI].sales.Contract C on C.Id = CTD.SalesContractId 
inner join (select   Id,      EndDate , row_number() over  (Partition by AccountContractHeaderId order by EndDate desc) rn
				from [EU_FinanceBI].company.ContractTermDetail CTD2
) CTDM on CTDM.Id = CTD.Id and CTDM.rn = 1
) foo ) con on [VwAccount].[Ac Id] = con.AccountId
*/


-- select top 100 * from AU_FinanceBI.oss.[Order]









