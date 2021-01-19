







CREATE View [Tableau].[VwCCInstanceUsage] as
-- MW 10122018 View for current CC instance usage for Capacity Planning.
select 
	isnull(a.SvcCluster,aa.Cluster) as SvcCluster
	,aa.CCClusterName, 
	SUM(CASE WHEN b.Name = 'Active' then 1 else 0 END) as ActiveSeats,
	SUM(CASE WHEN b.Name = 'Pending' then 1 else 0 END)  as PendingNotBuiltSeats,
	SUM(CASE WHEN b.Name = 'Provisioning' then 1 else 0 END) as PendingBuiltSeats,
	SUM(CASE WHEN b.Name IN ('Provisioning', 'Active', 'Pending')  then 1
												else 0 END) as Total
from
	oss.VwServiceProduct_EX a (nolock)   inner join
	[company].[VwAccount] aa
        ON a.AccountId = aa.[Ac Id] inner join
	enum.ServiceStatus b (nolock) on a.ServiceStatusId = b.Id
where a.ProductId IN -- Only Profiles/Seats
	(	
	375 --Connect CLOUD Contact Center - Agent Advanced
	,373-- Connect CLOUD Contact Center - Agent Essentials
	,374 --Connect CLOUD Contact Center - Agent Standard
	,24  --ACD Seats
	,274 --ACD Seats SCC Agent
	,275 --ACD Seats SCC Supervisor
	) and  aa.CCClusterName is not null

group by isnull(a.SvcCluster,aa.Cluster)  , aa.CCClusterName

/* wait for product Ids
UNION ALL
select 
	isnull(a.SvcCluster,aa.Cluster) as SvcCluster,  
	 , aa.CCClusterName
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
	375 --Connect CLOUD Contact Center - Agent Advanced
	,373-- Connect CLOUD Contact Center - Agent Essentials
	,374 --Connect CLOUD Contact Center - Agent Standard
	,24  --ACD Seats
	,274 --ACD Seats SCC Agent
	,275 --ACD Seats SCC Supervisor
	)
group by isnull(a.SvcCluster,aa.Cluster)  , aa.CCClusterName
UNION ALL
select 
	isnull(a.SvcCluster,aa.Cluster) as SvcCluster, 
	 , aa.CCClusterName  
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
group by isnull(a.SvcCluster,aa.Cluster)  , aa.CCClusterName

*/







