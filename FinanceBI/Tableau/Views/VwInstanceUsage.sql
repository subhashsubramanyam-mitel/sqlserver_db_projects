






CREATE View [Tableau].[VwInstanceUsage] as
-- MW 07102018 View for current instance usage for Capacity Planning.
select 
	isnull(a.SvcCluster,aa.Cluster) as SvcCluster, 
	SUM(CASE WHEN b.Name = 'Active' then 1 else 0 END) as ActiveSeats,
	SUM(CASE WHEN b.Name = 'Pending' then 1 else 0 END)  as PendingNotBuiltSeats,
	SUM(CASE WHEN b.Name = 'Provisioning' then 1 else 0 END) as PendingBuiltSeats,
	SUM(CASE WHEN b.Name IN ('Provisioning', 'Active', 'Pending')  then 1
												else 0 END) as AnticipatedTotalSeats
from
	oss.VwServiceProduct_EX a (nolock)   inner join
	[company].[VwAccount] aa
        ON a.AccountId = aa.[Ac Id] inner join
	enum.ServiceStatus b (nolock) on a.ServiceStatusId = b.Id
where a.ProductId IN -- Only Profiles/Seats
	(	 108
		,351
		,352
		,353
		,354
		,402
		,403
	)
--and [Ac Id] NOT IN (
--SELECT  
--	  [Ac Id] as Id
--  FROM 
--	 [company].[VwAccount]  
--where (
--[Ac Name] like '%N05%' OR 
--[Ac Name] like '%N08%' OR 
--[Ac Name] like '%N09%' OR 
--[Ac Name] like '%N10%' OR 
--[Ac Name] like '%N14%' OR 
--[Ac Name] like '%N11%' OR 
--[Ac Name] like '%N15%' OR 
--[Ac Name] like '%N16%' OR 
--[Ac Name] like '%N17%' OR 
--[Ac Name] like '%N18%' OR 
--[Ac Name] like '%N19%' OR 
--[Ac Name] like '%N20%' OR 
--[Ac Name] like '%N21%' OR 
--[Ac Name] like '%N22%' OR 
--[Ac Name] like '%N26%' OR
--[Ac Name] like  '%ECC Internal Users%' )

--)

group by isnull(a.SvcCluster,aa.Cluster)
UNION ALL
select 
	isnull(a.SvcCluster,aa.Cluster) as SvcCluster,  
	SUM(CASE WHEN b.Name = 'Active' then 1 else 0 END) as ActiveSeats,
	SUM(CASE WHEN b.Name = 'Pending' then 1 else 0 END)  as PendingNotBuiltSeats,
	SUM(CASE WHEN b.Name = 'Provisioning' then 1 else 0 END) as PendingBuiltSeats,
	SUM(CASE WHEN b.Name IN ('Provisioning', 'Active', 'Pending')  then 1
												else 0 END) as AnticipatedTotalSeats
from
	AU_FinanceBI.FinanceBI.oss.VwServiceProduct_EX a (nolock)   inner join
	AU_FinanceBI.FinanceBI.[company].[VwAccount] aa
        ON a.AccountId = aa.[Ac Id] inner join
	AU_FinanceBI.FinanceBI.enum.ServiceStatus b (nolock) on a.ServiceStatusId = b.Id
where a.ProductId IN -- Only Profiles/Seats
	(	
	 108
	,402
	,403
	,353
	,351
	,352
	,354
	)
--	and [Ac Id] NOT IN (
-- SELECT  
--	  [Ac Id] as Id
 
--  FROM 
--	 AU_FinanceBI.FinanceBI.[company].[VwAccount]  
--where (
--[Ac Name] like '%A02%')
--)

group by isnull(a.SvcCluster,aa.Cluster)
UNION ALL
select 
	isnull(a.SvcCluster,aa.Cluster) as SvcCluster,   
	SUM(CASE WHEN b.Name = 'Active' then 1 else 0 END) as ActiveSeats,
	SUM(CASE WHEN b.Name = 'Pending' then 1 else 0 END)  as PendingNotBuiltSeats,
	SUM(CASE WHEN b.Name = 'Provisioning' then 1 else 0 END) as PendingBuiltSeats,
	SUM(CASE WHEN b.Name IN ('Provisioning', 'Active', 'Pending')  then 1
												else 0 END) as AnticipatedTotalSeats
from
	EU_FinanceBI.FinanceBI.oss.VwServiceProduct_EX a (nolock)   inner join
	EU_FinanceBI.FinanceBI.[company].[VwAccount] aa
        ON a.AccountId = aa.[Ac Id] inner join
	EU_FinanceBI.FinanceBI.enum.ServiceStatus b (nolock) on a.ServiceStatusId = b.Id
	where a.ProductId IN -- Only Profiles/Seats
	(	--different prod ids than us for same product!!!!!!!!!!!!!!
	 108
	,422
	,423
	,433
	,351
	,352
	,357
	)
group by isnull(a.SvcCluster,aa.Cluster)






