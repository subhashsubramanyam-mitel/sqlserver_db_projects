CREATE View tableau.VwUnconfirmedProfiles as
--MW 08292019  Shows comparison of profiles from closed opps from SFDC to profiles on Boss Account
select  
	  opp.AccountName
	 ,a.AnticipatedTotalSeats as Profiles_BOSS
	 ,opp.OppProfiles  Profiles_Opportunity
	 ,a.SvcCluster as Instance
	 ,opp.OpportunityNumber
	 ,opp.CloseDate
FROM

(
SELECT        
	 c.M5DBAccountID as AccountId
	,o.OpportunityNumber 
	,convert( float ,o.NumOfProfiles) as OppProfiles
	,c.NAME as AccountName
	,o.CloseDate

FROM            
	[$(MiBI)].dbo.OPPORTUNITY o INNER JOIN
    [$(MiBI)].dbo.CUSTOMERS c ON o.AccountID = c.SfdcId and isnumeric(c.M5DBAccountID) = 1
where o.Stage ='Closed Won' and o.RecordType = 'Standard' and SubType <> 'Cross-Sell'
) opp left outer join
/*	(select 
	 a.AccountId
	,isnull(a.SvcCluster,aa.Cluster) as SvcCluster, 

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

group by a.AccountId, isnull(a.SvcCluster,aa.Cluster))*/


	(
	select 
		 a.AccountId
		 ,aa.Cluster as SvcCluster
		,sum(b.Quantity) as AnticipatedTotalSeats
	from 
	[company].[VwAccount] aa inner join
	sales.Contract a on aa.[Ac Id] = a.AccountId and a.ContractTypeId in (1,2,9) inner join
	sales.ContractLineItem b on a.Id = b.ContractId  
	where b.ProductId IN -- Only Profiles/Seats
	(	 108
		,351
		,352
		,353
		,354
		,402
		,403
	)
	group by a.AccountId,aa.Cluster 
	)
  a  on opp.AccountId = a.AccountId