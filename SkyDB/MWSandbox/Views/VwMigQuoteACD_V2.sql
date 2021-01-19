/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View MWSandbox.VwMigQuoteACD_V2 as
-- MW 02262018 From SSC data instead of Boss
select
		 aa.AccountId
		,aa.AccountName

		,l.[Name] as LocationName
		,l.Address + ', '+	l.Address2 + ', '+ l.City + ', '+	l.ZipCode as Address		
		,373 as ConnectProductId  
		,'Connect CLOUD Contact Center - Agent Essentials' as ProductName 
		, sum(a.Agents) as Qty
		,0 as MRR
FROM
		(
		SELECT 
			   [username] as tn
  
			  , sum( agent  ) as Agents
			  , sum(supervisor)  as Supers
 
		  FROM [SkyTeamSandbox].[sccUserDetail]
		  where Active = 1 and isnumeric ([username]) = 1 and supervisor = 0
		  group by username
		) a inner join
		[$(FinanceBI)].provision.Tn t on a.tn = t.Id  and isnumeric( AccountId) = 1 inner join
		[$(FinanceBI)].company.Location l on t.LocationId = l.Id inner join
		MWSandbox.MigrationCustList aa on t.AccountId = aa.AccountId  
		--where aa.AccountId= 10626
	group by 		 aa.AccountId
		,aa.AccountName
		,t.LocationId
		,l.[Name]  
		,l.Address + ', '+	l.Address2 + ', '+ l.City + ', '+	l.ZipCode
UNION ALL
--Supers
select
		 aa.AccountId
		,aa.AccountName

		,l.[Name] as LocationName
		,l.Address + ', '+	l.Address2 + ', '+ l.City + ', '+	l.ZipCode as Address		
		,373 as ConnectProductId  
		,'Connect CLOUD Contact Center - Supervisor' as ProductName 
		, sum(a.Supers) as Qty
		, 0 as MRR
FROM
		(
		SELECT 
			   [username] as tn
  
			  , sum( agent  ) as Agents
			  , sum(supervisor)  as Supers
 
		  FROM [SkyTeamSandbox].[sccUserDetail]
		  where Active = 1 and isnumeric ([username]) = 1 and supervisor > 0
		  group by username
		) a inner join
		[$(FinanceBI)].provision.Tn t on a.tn = t.Id  and isnumeric( AccountId) = 1 inner join
		[$(FinanceBI)].company.Location l on t.LocationId = l.Id inner join
		MWSandbox.MigrationCustList aa on t.AccountId = aa.AccountId  
		--where aa.AccountId= 10626
	group by 		 aa.AccountId
		,aa.AccountName
		,t.LocationId
		,l.[Name]  
		,l.Address + ', '+	l.Address2 + ', '+ l.City + ', '+	l.ZipCode
 

