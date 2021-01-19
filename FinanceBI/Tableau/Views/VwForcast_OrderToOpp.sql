

















 CREATE view [Tableau].[VwForcast_OrderToOpp] as
 -- MW 04222019 placeholder for forcast
select 
	  'US' as Source
	 ,a.OrderId
	 ,b.OpportunityNumber
	 ,b.Stage
	 ,b.CloseDate
	 ,Case when b.ForecastCategory = 'Best Case' then 'Upside' ELse b.ForecastCategory End as ForecastCategory
	 ,b.Product_Specifics__c as [Platform]
	 ,b.EstimatedMRR as MRR
	 ,b.RecordType 

	 , CASE 
		when b.Stage = 'Closed Won' and OrderId is not null then 'Closed Won'
		when b.Stage = 'Closed Won' and OrderId is null and b.Product_Specifics__c like '%Connect%' -- Only Boss Opps
					then 'Won - Pending BOSS Entry'
		when b.Stage <> 'Closed Won' and b.ForecastCategory = 'Commit' then 'Committed'
		when b.Stage <> 'Closed Won' and b.ForecastCategory = 'Best Case' then 'Upside'
	  Else 'N/A' END as ForecastCategory_Report
	, CASE 
		WHEN  b.Stage =  'Closed Won'  then  b.EstimatedMRR
		WHEN  b.Stage <> 'Closed Won' and b.ForecastCategory = 'Commit' then .9*(b.EstimatedMRR )
		WHEN  b.Stage <> 'Closed Won' and Month(b.CloseDate) >   Month(getdate()) then .4*(b.EstimatedMRR )
		WHEN  b.Stage <> 'Closed Won' and Month(b.CloseDate) =   Month(getdate()) then 
				CASE
					--WHEN  b.ForecastCategory = 'Best Case' and (datepart(day, datediff(day, 0, getdate() )/7 * 7)/7 + 1) = 1 then .4*(b.EstimatedMRR )
					--WHEN  b.ForecastCategory = 'Best Case' and  (datepart(day, datediff(day, 0, getdate())/7 * 7)/7 + 1) = 2 then .3*(b.EstimatedMRR )
					--WHEN  b.ForecastCategory = 'Best Case' and (datepart(day, datediff(day, 0, getdate())/7 * 7)/7 + 1) = 3 then .1*(b.EstimatedMRR )
					--WHEN  b.ForecastCategory = 'Best Case' and (datepart(day, datediff(day, 0, getdate())/7 * 7)/7 + 1) = 4 then .1*(b.EstimatedMRR )
					WHEN  b.ForecastCategory = 'Best Case' and (DATEPART(wk, GETDATE()) - DATEPART(wk,CAST(CONCAT(MONTH(GETDATE()), '/1/', YEAR(GETDATE())) AS DATETIME)) + 1) = 1 then .4*(b.EstimatedMRR )
					WHEN  b.ForecastCategory = 'Best Case' and  (DATEPART(wk, GETDATE()) - DATEPART(wk,CAST(CONCAT(MONTH(GETDATE()), '/1/', YEAR(GETDATE())) AS DATETIME)) + 1) = 2 then .3*(b.EstimatedMRR )
					WHEN  b.ForecastCategory = 'Best Case' and (DATEPART(wk, GETDATE()) - DATEPART(wk,CAST(CONCAT(MONTH(GETDATE()), '/1/', YEAR(GETDATE())) AS DATETIME)) + 1) = 3 then .1*(b.EstimatedMRR )
					WHEN  b.ForecastCategory = 'Best Case' and (DATEPART(wk, GETDATE()) - DATEPART(wk,CAST(CONCAT(MONTH(GETDATE()), '/1/', YEAR(GETDATE())) AS DATETIME)) + 1) = 4 then .1*(b.EstimatedMRR )				
				END
		ELSE  0 end as ForecastAmount
		,b.SubType
		,b.OpportunityTheater
		,u.Name as OwnerName
		,b.ProductInterest
		,b.AccountName
		,b.Created as CreatedDate
		,b.NumOfProfiles as [CloudProfiles]
		-- 
		,Case when  
		p.ProductName IN (
										 'IaaS'
										,'MiCloud CC Engage OPEX'
										,'MiCloud Contact Center Live OPEX'
										,'MiCloud Contact Center OPEX'
										,'MiCloud Engage Contact Center'
										,'MiCloud Enterprise OPEX'
										,'MiCloud Flex'
										,'MiCloud Flex WorldCloud'
										,'MiCloud Hospitality OPEX'
										,'MiCloud UCaaS OPEX'
										,'World Cloud - MiCloud Enterprise OPEX'
						)  then 'MiCloud Flex' Else 
			p.ProductName END as ProductFromBlue
		--,p.ProductName   as ProductFromBlue
		,b.Name as OpportunityName
		,b.DealSize
		,b.NumOfProfiles as [Number of End Points/Seats]
		,b.Type as OpportunityType
		 ,c.M5DBAccountID as [M5DB Account ID]
		 ,b.OpportunityId
		 ,cs.Name as ContractStatus
		 ,b.OpportunityRegion
		 -- MW 10302019 Taskfeed fields
		 ,tf.TF_ProjectNumber as TaskfeedProjectNumber
		 ,tf.TaskfeedprojectManager as TaskfeedPM
		 ,tf.TaskfeedprojectManagerEmail as TaskfeedPMEmail
		 ,tf.TaskfeedprojectManagerPhone as TaskfeedPMPhone

		-- ,tf.TaskfeedPMManager
		 ,ast.Staffing_OrderAssigneeManager as TaskfeedPMManager
		 ,b.SelfStart
		 ,aa.IsMCSSEnabled
		 ,od.OrderDate
		 ,b.OppLocations
		--Staffing
		 ,ast.Staffing_OrderAssignee
		 ,ast.Staffing_OrderAssigneeManager
		 ,ast.Staffing_OrderAssigneeGroup
		 ,ast.Staffing_OrderAssigneeCenter
		 ,ast.Staffing_OrderAssigneeRegion
		 ,ast.Staffing_OrderAssigneePOD

		 ,pp.NAME as PartnerName
		 ,pp.SAPNumber as PartnerId

		 ,b.SubAgentName_Text as SubAgentName
		 ,b.PartnerRep as PartnerContact
		 ,b.OpportunitySource
		 ,b.LeadCategory
		 ,b.ConsolodatedReportPartner
		 , CASE WHEN isnull(sso.SelfStart,0) = 1 then 'Yes' Else 'No' END as [Has SelfStart Product?]

		 ,c.CSM    as [Customer Success Manager]
		 ,b.WelcomeContact      as  [Opportunity Welcome Contact]
		 ,b.NCAM 	        as [Opportunity NCAM]
		 ,b.AgentCAM      as [Opportunity CAM]
		 ,b.CommTAM   as [Opportunity C-TAM]
		 ,b.AdvancedISRId    as [Opportunity ISR]
		 ,b.ShoreTelTerritory    as [Opportunity Territory]
		 ,ins.ProductName as [Install Service Type]
		 ,ins.NRRTotal as [Install Service Type Charge Total]
		 ,ins.NRRList as  [Install Service Type Charge List]
		 ,ins.NRRSales as [Install Service Type Charge Sales]


	,b.Contract_Signed_By__c
	,b.Eligible_Support_Partner__c
	,b.OneView_Subtype__c
	--,b.SelfStart
	,b.VE__c

-- i think these are partner fields...MW 10072020
	,pp.BOSS_Support_Partner__c
	,pp.MiCloud_Connect_Business_Model__c

	,b.ProposalPromotionApplied

	,b.Proposal

	,b.EstimatedNRR as NRR

	,aaa.Number as AccountNumber


from
				 [$(MiBI)].dbo.OPPORTUNITY b 
left outer join [$(MiBI)].dbo.V_SFDC_OPP_INSTALL_SERVICES ins on b.OpportunityID = ins.OpportunityId
left outer join  [$(MiBI)].dbo.CUSTOMERS pp on b.LeadPartner =	pp.SfdcId 			  
left outer join [$(MiBI)].dbo.CUSTOMERS c on b.AccountId = 		c.SfdcId
left outer join company.AccountAttr aa on Case when isnumeric(c.M5dbAccountID) = 0 then null else c.M5dbAccountID END = aa.AccountId --and ISNUMERIC(	c.M5dbAccountID) = 1	   
 left outer join company.Account aaa on aa.AccountId = aaa.Id 
 left outer join 
				 (-- only first order
				select ContractNumber, --AccountId, 
				Min(OrderId) as OrderId  from
				oss.VwOrder 
				group by ContractNumber
		union all
	select ContractNumber, --AccountId, 
	Min(OrderId) as OrderId  from
	 [EU_FinanceBI].oss.VwOrder 
	group by ContractNumber
		union all
	select ContractNumber, --AccountId, 
	Min(OrderId) as OrderId  from
	 [AU_FinanceBI].oss.VwOrder 
	group by ContractNumber
				--, AccountId
				) a on b.OpportunityNumber = a.ContractNumber collate database_default
--OrderDate
 left outer join 
				 (-- only first order
				select ContractNumber, DateCreated as OrderDate  from
				oss.VwOrder 
		union all
	select ContractNumber, DateCreated as OrderDate  from
	 [EU_FinanceBI].oss.VwOrder 
 
		union all
select ContractNumber, DateCreated as OrderDate  from
	 [AU_FinanceBI].oss.VwOrder 
 
				--, AccountId
				) od on b.OpportunityNumber = od.ContractNumber collate database_default
				  
 left outer join (select ContractNumber, ContractStatusId from  sales.Contract where ContractStatusId <> 3  /*and ContractTypeId in (1,9) */  union all
                 select ContractNumber, ContractStatusId from [AU_FinanceBI].sales.Contract  where ContractStatusId <> 3 /*and ContractTypeId in (1,9) */ union all
				 select ContractNumber, ContractStatusId from [EU_FinanceBI].sales.Contract 	 where ContractStatusId <> 3  --and ContractTypeId in (1,9) 		
				 )s  on b.OpportunityNumber = s.ContractNumber  collate database_default 
 left outer join enum.sales_ContractStatus cs on s.ContractStatusId = cs.Id
 left outer join [$(MiBI)].dbo.Users u  on b.OwnerID = u.ID
 left outer join
 --This needs to go away after BTS
				 (
			 select
			OpportunityId, ProductName
			from
			(
 			select o2.OpportunityID as OpportunityId, p.ProductName , row_number() over (partition by  o2.OpportunityID order by p.MRRConverted desc) rn
			from 
			--[$(MiBI)].dbo.TABLEAU_B_SFDC_OPPORTUNITY bo
			(select Id as OpportunityId,HeritageId from [$(MiBI)].dbo.B_SFDC_OPPORTUNITY where HeritageId  <> '') bo
			inner join [$(MiBI)].dbo.OPPORTUNITY o on bo.HeritageId = o.OpportunityID
			inner join [$(MiBI)].dbo.OPPORTUNITY o2 on o.PrimaryOppId = o2.OpportunityID
			inner join [$(MiBI)].dbo.TABLEAU_B_SFDC_OPP_PRODUCTS p on bo.OpportunityId = p.OpportunityId
			where p.ProductName in ('MiCloud Connect','MiCloud Business OPEX','MiCloud Office OPEX'
										,'IaaS'
										,'MiCloud CC Engage OPEX'
										,'MiCloud Contact Center Live OPEX'
										,'MiCloud Contact Center OPEX'
										,'MiCloud Engage Contact Center'
										,'MiCloud Enterprise OPEX'
										,'MiCloud Flex'
										,'MiCloud Flex WorldCloud'
										,'MiCloud Hospitality OPEX'
										,'MiCloud UCaaS OPEX'
										,'World Cloud - MiCloud Enterprise OPEX'
									)
			) a where rn = 1
			 ) p on b.OpportunityID = p.OpportunityId left outer join
			--[$(MiBI)].dbo.V_TABLEAU_TASKFEED_INFO tf on b.OpportunityID = tf.OpportunityId and tf.rn=1
			tableau.mVwTaskfeedInfo  tf on b.OpportunityID = tf.OpportunityId and tf.rn=1
			-- MW 01272020
			left join Tableau.ActivationsStaffing ast on tf.TaskFeedProjectManager = ast.Staffing_OrderPM_BOSS collate database_default
			left join [$(MiBI)].dbo.V_SFDC_SELFSTART_OPPS sso on  b.OpportunityID = sso.OpportunityId
where 
		b.CloseDate >= '2020-01-01' 
	 

 
