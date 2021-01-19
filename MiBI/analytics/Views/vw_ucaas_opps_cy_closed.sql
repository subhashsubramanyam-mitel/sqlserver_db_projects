







/* REMEMBER TO UPDATE CLOSE DATE TWICE -- IN SELECT AND SUBQUERY FOR DEBOOK		*/



CREATE VIEW [analytics].[vw_ucaas_opps_cy_closed] AS

select 
dbo.OPPORTUNITY.ProductInterest as 'solution_of_interest',
dbo.OPPORTUNITY.TotalContractValue as 'total_contract_value_converted',
dbo.OPPORTUNITY.Product_Specifics__c as 'product_of_interest',
--dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.ProductName as 'product_name',	
dbo.OPPORTUNITY.Name as 'opportunity_name',
dbo.OPPORTUNITY.Stage as 'stage',
case
		when dbo.OPPORTUNITY.AccountName = '' then 'Other'
		when dbo.OPPORTUNITY.AccountName like '%ShoreTel%' then 'Other'
		when dbo.OPPORTUNITY.AccountName like '%Mitel%' then 'Other'
		when dbo.OPPORTUNITY.AccountName like '%test%' then 'Other'
		when dbo.OPPORTUNITY.Name like '%- BD%' then 'Marketing Lead'
		when cust2.NAME is null then 'Direct'
		when cust2.NAME like '%APPSMART%' then 'Master Agent'
		when cust2.NAME like '%APP SMART%' then 'Master Agent'
		when cust2.NAME like '%JENNE%' then 'Master Agent'
		when cust2.NAME like '%INGRAM MICRO%' then 'Master Agent'
		when cust2.NAME like '%ADVANTAGE COMMUNICATIONS GROUP%' then 'Master Agent'
		when cust2.NAME like '%AVANT%' then 'Master Agent'
		when cust2.NAME like '%BUSINESS COMMUNICATIONS MANAGEMENT%' then 'Master Agent'
		when cust2.NAME like '%COMMERCE CONSULTING CORPORATION%' then 'Master Agent'
		when cust2.NAME like '%Converged Network Services Group (CNSG)%' then 'Master Agent'
		when cust2.NAME like '%INTELISYS%' then 'Master Agent'
		when cust2.NAME like '%Intelisys%' then 'Master Agent'
		when cust2.NAME like '%MICROCORP%' then 'Master Agent'
		when cust2.NAME like '%PLANETONE%' then 'Master Agent'
		when cust2.NAME like '%PLANETON%' then 'Master Agent'
		when cust2.NAME like '%SANDLER%' then 'Master Agent'
		when cust2.NAME like '%Sandler%' then 'Master Agent'
		when cust2.NAME like '%TCG%' then 'Master Agent'
		when cust2.NAME like '%TELARUS%' then 'Master Agent'
		when cust2.NAME like '%TELECOM BROKERAGE%' then 'Master Agent'
		when cust2.NAME like '%SCANSOURCE%' then 'Master Agent'
		else 'VAR'
end as 'partner_type',
cust2.NAME as 'partner_account_name',
cust3.NAME as 'sub_agent_account',
dbo.OPPORTUNITY.Type as 'type',
dbo.OPPORTUNITY.SubType as 'sub_type',
users2.Name as 'opportunity_owner',
users2.RoleName as 'owner_role',
--dbo.OPPORTUNITY.EstimatedMRR as 'estimated_mrr',
case
		when dbo.OPPORTUNITY.EstimatedMRR * dbo.OPPORTUNITY.Term <> dbo.OPPORTUNITY.TotalContractValue then dbo.OPPORTUNITY.TotalContractValue/dbo.OPPORTUNITY.Term
		else dbo.OPPORTUNITY.EstimatedMRR
end as 'estimated_mrr', 
dbo.OPPORTUNITY.Term as 'term',
case
		when dbo.SFDC_TERRITORY.Theatre = 'Americas' then 'UCaaS Americas'
		when dbo.SFDC_TERRITORY.Theatre = 'EMEA' then 'UCaaS International'
		when dbo.SFDC_TERRITORY.Theatre = 'APAC' then 'UCaaS International'
		else dbo.SFDC_TERRITORY.Theatre
end as 'forecast_theatre',
dbo.SFDC_TERRITORY.Region as 'region',
dbo.SFDC_TERRITORY.Subregion as 'sub_region',
dbo.SFDC_TERRITORY.TerritoryName as 'territory',
dbo.SFDC_TERRITORY.ISRRegion as 'isr_region',
dbo.OPPORTUNITY.ForecastCategory as 'forecast_category',
dbo.OPPORTUNITY.OpportunityID as 'opportunity_id',
--dbo.TABLEAU_B_SFDC_OPPORTUNITY.NAME as 'blue_name',
dbo.OPPORTUNITY.PrimaryOppId as 'primary_opp_id_orange',
dbo.OPPORTUNITY.OpportunityID as 'secondary_opp_id_orange',
--dbo.TABLEAU_B_SFDC_OPPORTUNITY.ID as 'opp_id_blue',
dbo.OPPORTUNITY.NumOfProfiles as 'num_of_cloud_profiles',
dbo.OPPORTUNITY.AccountName as 'account_name',
case
		when dbo.OPPORTUNITY.Product_Specifics__c like '%MiCloud Connect%' then 'MiCloud Connect'
		when dbo.OPPORTUNITY.ProductInterest = 'MiCloud Connect CX' then 'MiCloud Connect'
		else NULL
end as 'products',
--case
--		when dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.ProductName = 'MiCloud Connect' then 'MiCloud Connect'
--		when dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.ProductName = 'Monthly Recurring Revenue' then 'MiCloud Connect'
--		when dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.ProductName = 'MiCloud Business OPEX' then 'MiCloud Business'
--		when dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.ProductName = 'MiCloud Office OPEX' then 'MiCloud Office'
--		else NULL
--end as 'products',
dbo.OPPORTUNITY.CloseDate as 'close_date',
convert(varchar(3), dbo.OPPORTUNITY.CloseDate, 100) as 'close_month',
dbo.OPPORTUNITY.Created as 'create_date',
users4.Name as 'created_by',
dbo.OPPORTUNITY.LastModified as 'last_modified_date',
users3.Name as 'last_modified_by',
getdate() as 'extract_date'

from dbo.OPPORTUNITY
left join dbo.TABLEAU_B_SFDC_OPPORTUNITY
	on dbo.TABLEAU_B_SFDC_OPPORTUNITY.HeritageId = dbo.OPPORTUNITY.OpportunityID

left join dbo.OPPORTUNITY Opp2
	on dbo.OPPORTUNITY.PrimaryOppId = Opp2.OpportunityID

left join dbo.Users users2
	on Opp2.OwnerID = users2.ID

left join dbo.Users users3
	on dbo.OPPORTUNITY.LastModifiedById = users3.ID

left join dbo.Users users4
	on dbo.OPPORTUNITY.CreatedById = users4.ID

left join dbo.SFDC_TERRITORY
	on Opp2.ShoreTelTerritory = dbo.SFDC_TERRITORY.SfdcId

left join dbo.CUSTOMERS cust2
	on dbo.OPPORTUNITY.LeadPartner = cust2.SfdcId

left join dbo.CUSTOMERS cust3
	on dbo.OPPORTUNITY.SubAgentId = cust3.SfdcId

--left join dbo.TABLEAU_B_SFDC_OPP_PRODUCTS
	--on dbo.TABLEAU_B_SFDC_OPPORTUNITY.ID = dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.OpportunityId


where	dbo.OPPORTUNITY.CloseDate >= '2021-01-01 00:00:00'				-- UPDATE THIS DATE
		--and dbo.OPPORTUNITY.IsClosed = 'true'
		and dbo.OPPORTUNITY.EstimatedMRR > 0
		and dbo.OPPORTUNITY.isSecondary = 'true'
		and Opp2.RecordType not in ('Cloud_Account_Management')
		and Opp2.Name not like '% SHV%'
		and Opp2.Name not like '%-SHV%'
		and Opp2.Name not like '%- SHV%'		
		and Opp2.Name not like '% SHV%'		
		and dbo.OPPORTUNITY.Stage = 'Closed Won'
		and (dbo.OPPORTUNITY.SubType is null or dbo.OPPORTUNITY.SubType not in ('Cross-Sell','Flex CC and/or SIP','Migrate Call Conductor to MiCloud Connect','Migrate MiCB v1.0 to MiCloud Connect','Migrate MiCB v2.0 to MiCloud Connect','Migrate SHV to MiCloud Connect'))
		and dbo.OPPORTUNITY.Type in ('New Business - Initial Sale','New Business-Initial Sale','Existing Customer - Add on Sale')
		and (dbo.OPPORTUNITY.ProductInterest in ('Cloud Service','Cloud Service - Connect','Cloud Service - Contact Center','MiCloud Connect CX','UCaaS - Other')
		or dbo.OPPORTUNITY.ProductInterest like '%Cloud Service - Connect%')
		and dbo.OPPORTUNITY.ForecastCategory = 'Closed'
		and dbo.OPPORTUNITY.Name not like '%- Demo -%'
		and dbo.OPPORTUNITY.Name not like '%-Demo -%'
		and dbo.OPPORTUNITY.Name not like '%- DEMO -%'
		and dbo.OPPORTUNITY.Name not like '%-DEMO -%'
		and dbo.OPPORTUNITY.Name not like '%- Connect Demo -%'
		and dbo.OPPORTUNITY.Name not like '%- Connect DEMO -%'
		--and dbo.OPPORTUNITY.Name not like '%-CSM%'
		--and dbo.OPPORTUNITY.Name not like '%- CSM%'
		--and dbo.OPPORTUNITY.Name not like '% CSM%'
		and dbo.SFDC_TERRITORY.Region in ('USA','Canada','UK','ANZ') --and dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.ProductName in ('MiCloud Connect','Monthly Recurring Revenue'))
		--or (dbo.SFDC_TERRITORY.Region in ('UK','ANZ') and dbo.TABLEAU_B_SFDC_OPP_PRODUCTS.ProductName in ('MiCloud Connect', 'Monthly Recurring Revenue')))
		and dbo.OPPORTUNITY.ForecastCategory <> 'Omitted'
		and dbo.SFDC_TERRITORY.Region is not NULL
		or ((dbo.OPPORTUNITY.Type = 'Moves, Splits, Changes'
			and dbo.OPPORTUNITY.CloseDate >= '2021-01-01 00:00:00'		-- UPDATE THIS DATE
			and dbo.OPPORTUNITY.SubType = 'Debook'
			and dbo.OPPORTUNITY.RecordType = 'Secondary'
			and dbo.OPPORTUNITY.Stage = 'Closed Won'))
;

