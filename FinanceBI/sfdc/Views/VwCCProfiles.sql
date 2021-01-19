
Create view sfdc.VwCCProfiles as
-- MW 04022020 view to update Megasilo Customers Table with accurate counts of CC profiles for each account
SELECT 
       convert(varchar(15), [AccountId]) as AccountId, 
	   count(*) as CCProfiles
  FROM [oss].[ServiceProduct] (nolock)
where ProductId in 
(
		 24
		,125
		,179
		,274
		,275
		,372
		,373
		,374
		,375
		,414
		,415
		,416
		,417
		,418
		,533
		,535

--	AU	372	MiCloud Connect Contact Center - Supervisor
--	AU	373	MiCloud Connect Contact Center - Agent Essentials
--	AU	374	MiCloud Connect Contact Center - Agent Premier
--	AU	375	MiCloud Connect Contact Center - Agent Elite
--	AU	414	MiCloud Connect CC Agent -Remote
--	AU	415	MiCloud Connect CC Supervisor-Remote
--	AU	416	MiCloud Connect CC Reporting-Remote
--	AU	417	MiCloud Connect CC-In Person
--	AU	418	MiCloud Connect CC-In Person-Add Day
--	EU	392	MiCloud Connect Contact Center - Supervisor
--	EU	393	MiCloud Connect Contact Center - Agent Essentials
--	EU	394	MiCloud Connect Contact Center - Agent Premier
--	EU	395	MiCloud Connect Contact Center - Agent Elite
--	EU	437	MiCloud Connect CC Agent -Remote
--	EU	438	MiCloud Connect CC Supervisor-Remote
--	EU	439	MiCloud Connect CC Reporting-Remote
--	EU	440	MiCloud Connect CC-In Person
) and ServiceStatusId = 1 -- Active
group by AccountId
union all
SELECT 
        AccountId, 
	   count(*) as CCProfiles
  FROM [Tableau].[mVwGlobalPipeline_AU] (nolock)
where ProductId in 
(
     372	 
 	,373 
    ,374	 
 	,375	 
 	,414	 
 	,415	 
 	,416	 
 	,417	 
 	,418
) and ServiceStatus ='Active'
group by AccountId
union all
SELECT 
        AccountId, 
	   count(*) as CCProfiles
  FROM [Tableau].[mVwGlobalPipeline_EU] (nolock)
where ProductId in 
(
 392	--MiCloud Connect Contact Center - Supervisor
,393	--MiCloud Connect Contact Center - Agent Essentials
,394	--MiCloud Connect Contact Center - Agent Premier
,395	--MiCloud Connect Contact Center - Agent Elite
,437	--MiCloud Connect CC Agent -Remote
,438	--MiCloud Connect CC Supervisor-Remote
,439	--MiCloud Connect CC Reporting-Rem

) and ServiceStatus ='Active'
group by AccountId