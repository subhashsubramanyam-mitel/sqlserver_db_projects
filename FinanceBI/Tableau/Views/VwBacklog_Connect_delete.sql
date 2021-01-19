






 CREATE View [Tableau].[VwBacklog_Connect_delete] as
-- MW 03122019 For Consolodated dashboard.

SELECT    
 
	 'US' AS Region
	--,[Ac Name]
	--,[IsBillable]
	--,[Ac Team]
	,CASE WHEN [Platform] = 'Call Conductor' then 'SKY' else 'Connect' END AS [Platform]
	--,[OneTimeCharge]
	--,[OneTimeCharge_LC]
	,SUM([MonthlyCharge]) as MonthlyCharge
	--,[MonthlyCharge_LC]
	--,[Prod Category]
	--,[ProdSubCategory]
	--,[Prod Name]
	--,[Prod ShortName]
	--,[Class RootName]
	--,[Class Group]
	--,[Revenue Component]
	--,[IsCrossSellProduct]
	,DateSvcLiveScheduled as ForecastDate
	--,DateSvcLiveActual
	,OrderStatus
	,ot.Name as OrderType
	,otm.Name as MasterOrderType
	,BillingStage
	--,Cluster
	--,pm.FirstName, pm.LastName
	--,o.OrderId
	--,o.DateTimeCreated as OrderDate
	--,CASE WHEN [enum].[VwProduct].[Prod Category] = 'Profiles' and oi.OrderItemType = 'New Service' then oi.Quantity else 0 end as SeatCount
	--,oi.DateBillingStart
 
	--,VwServiceProduct_EX.ServiceId
	--,VwServiceProduct_EX.DateSvcCreated
	--,l.[Loc Name]
	,ss.Name as ServiceStatus
	--,cb.FullName as OrderCreatedBy
	--,VwServiceProduct_EX.[ProductId]
	--,pm.FirstName + ' ' +pm.LastName as [Order PM]
	--,str(datediff (day,  DateSvcCreated, getdate()))  as [AvgLife Days]
	-- MW 12062018  Adds for Kelly
	--,opp.[Date Closed] as OppCloseDate
	--,con.StartDate as ContractStartDate
	--,con.DateCreated as ContractCreateDate
	--,opp.OpportunityNumber
	--, Case when O.OrderStatus = 'Void' then O.DateModified else null End as VoidDate

 
 FROM oss.VwServiceProduct_EX
left join enum.ServiceStatus ss on VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN [company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
--LEFT JOIN [enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
LEFT Join oss.VwOrder O on oss.VwServiceProduct_EX.OrderId = O.OrderId 
Left join enum.OrderType ot on o.OrderTypeId =  ot.Id
Left join enum.OrderType otm on o.MasterOrderTypeId =  otm.Id
--Left join people.VwPerson pm on VwServiceProduct_EX.OrderProjectManagerId = pm.Id
--Left join people.VwPerson cb on VwServiceProduct_EX.CreatedByPersonId = cb.Id
--left join oss.VwOrderItemDetail_EX oi on o.OrderId = oi.OrderId   AND
-- 										 VwServiceProduct_EX.ServiceId = oi.ServiceId
--left join company.VwLocation l on VwServiceProduct_EX.LocationId = l.[Loc Id]
-- MW 12062018  Adds for Kelly
--left join sfdc.VwOpportunity opp on  O.ContractNumber = opp.OpportunityNumber  collate database_default
--left join  company.VwContractDetail con on O.SalesContractId = con.SalesContractId
WHERE
		[IsBillable] = 1 -- Account
	and ot.Name in  ('Initial', 'Linked Add')  and isnull(otm.Name, '') <> 'Migration'
	and BillingStage in ('Forecasted', 'Unscheduled')
	and OrderStatus <> 'Duplicate'
	and year(DateSvcLiveScheduled) = 2019
GROUP BY
CASE WHEN [Platform] = 'Call Conductor' then 'SKY' else 'Connect' END
	,DateSvcLiveScheduled 
	,OrderStatus
	,ot.Name  
	,otm.Name 
	,BillingStage
	,ss.Name
 

UNION ALL
SELECT  
 
	 'AU' AS Region
 
	--,[Ac Name]
	--,[IsBillable]
	--,[Ac Team]
	,CASE WHEN [Platform] = 'Call Conductor' then 'SKY' else 'Connect' END AS [Platform]
	--,[OneTimeCharge]
	--,[OneTimeCharge_LC]
	,SUM([MonthlyCharge]) as MonthlyCharge
	--,[MonthlyCharge_LC]
	--,[Prod Category]
	--,[ProdSubCategory]
	--,[Prod Name]
	--,[Prod ShortName]
	--,[Class RootName]
	--,[Class Group]
	--,[Revenue Component]
	--,[IsCrossSellProduct]
	,DateSvcLiveScheduled as ForecastDate
	--,DateSvcLiveActual
	,O.OrderStatus
	,ot.Name as OrderType
	,otm.Name as MasterOrderType
	,BillingStage
	--,Cluster
	--,pm.FirstName, pm.LastName
	--,o.OrderId
	--,o.DateTimeCreated as OrderDate
	--,CASE WHEN [enum].[VwProduct].[Prod Category] = 'Profiles' and oi.OrderItemType = 'New Service' then oi.Quantity else 0 end as SeatCount
	--,oi.DateBillingStart
 
	--,VwServiceProduct_EX.ServiceId
	--,VwServiceProduct_EX.DateSvcCreated
	--,l.[Loc Name]
	,ss.Name as ServiceStatus
	--,cb.FullName as OrderCreatedBy
	--,VwServiceProduct_EX.[ProductId]
	--,pm.FirstName + ' ' +pm.LastName as [Order PM]
	--,str(datediff (day,  DateSvcCreated, getdate()))  as [AvgLife Days]
	-- MW 12062018  Adds for Kelly
	--,opp.[Date Closed] as OppCloseDate
	--,con.StartDate as ContractStartDate
	--,con.DateCreated as ContractCreateDate
	--,opp.OpportunityNumber
	--, Case when O.OrderStatus = 'Void' then O.DateModified else null End as VoidDate


FROM AU_FinanceBI.oss.VwServiceProduct_EX
left join AU_FinanceBI.enum.ServiceStatus ss on VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN AU_FinanceBI.[company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
--LEFT JOIN AU_FinanceBI.[enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
LEFT Join AU_FinanceBI.oss.VwOrder O on  VwServiceProduct_EX.OrderId = O.OrderId 

LEFT Join AU_FinanceBI.oss.[VwOrder] O2 on  O.MasterOrderId = O2.OrderId 

Left join AU_FinanceBI.enum.OrderType ot on o.OrderTypeId =  ot.Id
Left join AU_FinanceBI.enum.OrderType otm on O2.OrderTypeId =  otm.Id
--Left join AU_FinanceBI.people.VwPerson pm on VwServiceProduct_EX.OrderProjectManagerId = pm.Id
--left join AU_FinanceBI.oss.VwOrderItemDetail oi on o.OrderId = oi.OrderId   AND
-- 																     VwServiceProduct_EX.ServiceId = oi.ServiceId
--Left join AU_FinanceBI.people.VwPerson cb on VwServiceProduct_EX.CreatedByPersonId = cb.Id
--left join AU_FinanceBI.company.VwLocation l on VwServiceProduct_EX.LocationId = l.[Loc Id]
--left join sfdc.VwOpportunity opp on  O.ContractNumber = opp.OpportunityNumber  collate database_default
--left join  company.VwContractDetail con on O.SalesContractId = con.SalesContractId

/*(select 
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
GROUP BY
CASE WHEN [Platform] = 'Call Conductor' then 'SKY' else 'Connect' END
	,DateSvcLiveScheduled  
	,O.OrderStatus
	,ot.Name  
	,otm.Name  
	,BillingStage
	,ss.Name

UNION ALL


SELECT  
 
	 'UK' AS Region
 
	--,[Ac Name]
	--,[IsBillable]
	--,[Ac Team]
	,CASE WHEN [Platform] = 'Call Conductor' then 'SKY' else 'Connect' END AS [Platform]
	--,[OneTimeCharge]
	--,[OneTimeCharge_LC]
	,SUM([MonthlyCharge]) as MonthlyCharge
	--,[MonthlyCharge_LC]
	--,[Prod Category]
	--,[ProdSubCategory]
	--,[Prod Name]
	--,[Prod ShortName]
	--,[Class RootName]
	--,[Class Group]
	--,[Revenue Component]
	--,[IsCrossSellProduct]
	,DateSvcLiveScheduled as ForecastDate
	--,DateSvcLiveActual
	,O.OrderStatus
	,ot.Name as OrderType
	,otm.Name as MasterOrderType
	,BillingStage
	--,Cluster
	--,pm.FirstName, pm.LastName
	--,o.OrderId
	--,o.DateTimeCreated as OrderDate
	--,CASE WHEN [enum].[VwProduct].[Prod Category] = 'Profiles' and oi.OrderItemType = 'New Service' then oi.Quantity else 0 end as SeatCount
	--,oi.DateBillingStart
 
	--,VwServiceProduct_EX.ServiceId
	--,VwServiceProduct_EX.DateSvcCreated
	--,l.[Loc Name]
	,ss.Name as ServiceStatus
	--,cb.FullName as OrderCreatedBy
	--,VwServiceProduct_EX.[ProductId]
	--,pm.FirstName + ' ' +pm.LastName as [Order PM]
	--,str(datediff (day,  DateSvcCreated, getdate()))  as [AvgLife Days]
	-- MW 12062018  Adds for Kelly
	--,opp.[Date Closed] as OppCloseDate
	--,con.StartDate as ContractStartDate
	--,con.DateCreated as ContractCreateDate
	--,opp.OpportunityNumber
	--, Case when O.OrderStatus = 'Void' then O.DateModified else null End as VoidDate


FROM EU_FinanceBI.oss.VwServiceProduct_EX
left join EU_FinanceBI.enum.ServiceStatus ss on VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN EU_FinanceBI.[company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
--LEFT JOIN EU_FinanceBI.[enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
LEFT Join EU_FinanceBI.oss.VwOrder O on  VwServiceProduct_EX.OrderId = O.OrderId 

 LEFT Join AU_FinanceBI.oss.[VwOrder] O2 on  O.MasterOrderId = O2.OrderId 

Left join EU_FinanceBI.enum.OrderType ot on o.OrderTypeId =  ot.Id
Left join EU_FinanceBI.enum.OrderType otm on O2.OrderTypeId =  otm.Id
--Left join EU_FinanceBI.people.VwPerson pm on VwServiceProduct_EX.OrderProjectManagerId = pm.Id
--left join EU_FinanceBI.oss.VwOrderItemDetail oi on o.OrderId = oi.OrderId  AND
-- 																     VwServiceProduct_EX.ServiceId = oi.ServiceId
--Left join EU_FinanceBI.people.VwPerson cb on VwServiceProduct_EX.CreatedByPersonId = cb.Id
--left join EU_FinanceBI.company.VwLocation l on VwServiceProduct_EX.LocationId = l.[Loc Id]
--left join sfdc.VwOpportunity opp on  O.ContractNumber = opp.OpportunityNumber collate database_default
--left join company.VwContractDetail con on O.SalesContractId = con.SalesContractId

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
GROUP BY
CASE WHEN [Platform] = 'Call Conductor' then 'SKY' else 'Connect' END
	,DateSvcLiveScheduled  
	,O.OrderStatus
	,ot.Name  
	,otm.Name 
	,BillingStage
	,ss.Name


-- select top 100 * from AU_FinanceBI.oss.[Order]










