/****** Script for SelectTopNRows command from SSMS  ******/


Create view hana.VwBossCustomers as
-- MW 12022020 For Customer Master Integration into Global Boss Billings Tableau datasource
with c as ( 
select *
	,row_number() over (partition by GlobalAccountId order by [Customer Number] desc) rn
from
(
SELECT  
 
    'US-' + cast ([BOSS US ID] as varchar(10)) as GlobalAccountId 
      -- [BOSS AU ID]
      --,[BOSS EU ID]
      --,[BOSS US ID]
      , *
  FROM  [hana].[mVwCustomerMaster]
where cast([BOSS US ID] as varchar(10)) <> ''
UNION ALL
SELECT  
 
    'EU-' + cast ([BOSS EU ID] as varchar(10)) as GlobalAccountId 
      -- [BOSS AU ID]
      --,[BOSS EU ID]
      --,[BOSS US ID]
      , *
  FROM  [hana].[mVwCustomerMaster]
where cast([BOSS EU ID] as varchar(10)) <> ''
UNION ALL
SELECT  
 
    'AU-' + cast ([BOSS AU ID] as varchar(10)) as GlobalAccountId 
      -- [BOSS AU ID]
      --,[BOSS EU ID]
      --,[BOSS US ID]
      , *
  FROM  [hana].[mVwCustomerMaster]
where cast([BOSS AU ID] as varchar(10)) <> ''
) a
)

select * from c where rn =1
