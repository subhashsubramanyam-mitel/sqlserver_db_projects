




CREATE View [Tableau].[VwInstanceUsageAccounts] as
-- MW 07162018 View for current instance usage for Capacity Planning.
select 
	a.SvcCluster, 
	count(distinct AccountId) as Accounts
from
	oss.VwServiceProduct_EX a (nolock)   inner join
	enum.ServiceStatus b (nolock) on a.ServiceStatusId = b.Id
where a.ProductId IN -- Only Profiles/Seats
	(	 108
		,351
		,352
		,353
		,354
		,402
		,403
	) and b.Name in ( 'Active' , 'BillingStopped')
--and a.AccountId NOT IN (
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
group by a.SvcCluster 
UNION ALL
select 
	a.SvcCluster, 
	count(distinct AccountId) as Accounts
from
	AU_FinanceBI.FinanceBI.oss.VwServiceProduct_EX a (nolock)   inner join
	AU_FinanceBI.FinanceBI.enum.ServiceStatus b (nolock) on a.ServiceStatusId = b.Id
where a.ProductId IN -- Only Profiles/Seats
	(	 108
		,351
		,352
		,353
		,354
		,402
		,403
	)  and b.Name in ( 'Active' , 'BillingStopped')
--and a.AccountId not in

-- (
-- SELECT  
--	  [Ac Id] as Id
 
--  FROM 
--	 AU_FinanceBI.FinanceBI.[company].[VwAccount]  
--where (
--[Ac Name] like '%A02%')
--)

group by a.SvcCluster
UNION ALL
select 
	a.SvcCluster, 
	count(distinct AccountId) as Accounts
from
	EU_FinanceBI.FinanceBI.oss.VwServiceProduct_EX a (nolock)   inner join
	EU_FinanceBI.FinanceBI.enum.ServiceStatus b (nolock) on a.ServiceStatusId = b.Id
	where a.ProductId IN -- Only Profiles/Seats
	(	 108
		,351
		,352
		,353
		,354
		,402
		,403
	)  and b.Name in ( 'Active' , 'BillingStopped')
group by a.SvcCluster




