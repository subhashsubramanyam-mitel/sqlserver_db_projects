

/****** Script0 for SelectTopNRows command from SSMS  ******/



CREATE view [Tableau].[VwCustomerProfile_Connect] as
-- MW 11242020  Customer View for Gowri. Var E Project
with a as ( 

SELECT     --  top 100 
		a.[Ac Id] as AccountId, 
		a.[Ac Name], 
		a.[Ac Number], 

		a.DateFirstServiceLive, 
		a.[Ac ActiveMRR], 
		a.NumProfiles, 
		a.NumLocationsWithSeats, 
		a.MonthsInService,
		a.[Ac Team] as AccountTeam,
		b.PartnerName,
		a.Cluster as Instance,
		case when a.IsMCSSEnabled = 1 then 'Yes' Else 'No' end as SelfStart

FROM            company.VwAccount (nolock) a left outer join
				tableau.mVwSFDCCustInfo (nolock) b on a.[Ac Id] = b.AccountId and isnumeric(  b.AccountId ) =1
WHERE        (Platform = 'COSMO')	
		and [Ac Status] = 'Active'
		and IsBillable = 1
		and [Ac ActiveMRR] >0
)


-- Contract Data
, con AS 
(
SELECT H.[AccountId]
 
      ,D.[TermMonths]
      ,D.[StartDate]
      ,D.[EndDate]
 
      --,D.[ModifiedBy] AS DetailModifiedBy
	  ,T.Name AS ContractType
	--  , CASE
	--		  WHEN SC.ContractTypeId  = 1	THEN 'New Customer'
	--		  WHEN SC.ContractTypeId =2	THEN 'Add On Location'
	--		  WHEN SC.ContractTypeId =3	THEN 'Move'
	--		  WHEN SC.ContractTypeId =4	THEN 'Pricing Reconcile'
	--		  WHEN SC.ContractTypeId =5	THEN 'GT Customer'
	--		  WHEN SC.ContractTypeId =6	THEN 'CallFinity'
	--		  WHEN SC.ContractTypeId =7	THEN 'Add On Feature'
	--		  WHEN SC.ContractTypeId =8	THEN 'Manual Renewal'
	--		  WHEN SC.ContractTypeId =9	THEN 'Migration'
	--END as SalesContractType

	  ,ROW_NUMBER()
		OVER (
			PARTITION BY H.AccountId
			ORDER BY CASE WHEN T.Name = 'Automatic Renewal'
								AND StartDate > GETDATE() THEN 2
						  ELSE 1
						  END ASC 
				,EndDate DESC
				) AS rn
FROM company.ContractTermHeader H (nolock) 
INNER JOIN company.ContractTermDetail D (nolock) 
	ON H.Id = D.AccountContractHeaderId
INNER JOIN enum.AccountContractType T (nolock) 
	ON T.Id = D.ContractTypeId
LEFT JOIN sales.[Contract] SC (nolock) 
	ON SC.Id = D.SalesContractId
		--AND SC.AccountId = H.AccountId
WHERE SC.ContractStatusId IN (1, NULL) -- Confirmed or NULL
--ORDER BY H.AccountId
)

 

,circuits as
(
select  a.AccountId, p.Name  as Circuit,
row_number() over (partition by a.AccountId order by a.ServiceId desc) rn
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in
(
233,
235,
11,
10,
9)
)


-- Archiving
, ar as
(
select  a.AccountId, Count(*)  as Archiving 
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in 
	(
	349	,
	350	,
	360	,
	361	,
	362	,
	363	,
	364	
	)
group by a.AccountId
)


 
 -- CC

 ,cc as 
 
(
select  distinct a.AccountId, 'Yes' as ContactCenter
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
369	,
372	,
373	,
374	,
375	,
376,	
377	
)
)


, im as 
 
(
select  distinct a.AccountId, 'Yes' as InstantMessaging
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
458
)
)

, sms as
(
select  distinct a.AccountId, 'Yes' as SMS
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
238,348
)
)

, mob as (
select  distinct a.AccountId, 'Yes' as Mobility
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
255,299,346
)
)

, collab as (
select  distinct a.AccountId, 'Yes' as Collaboration
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
345,362,364
)
)

, scribe as (
select  distinct a.AccountId, 'Yes' as Scribe
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
116,343
)
)

, efax as (
select  distinct a.AccountId, 'Yes' as Fax
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
 	
18	,
332	,
344	,
359	
)
)

, cr as (
select  distinct a.AccountId, 'Yes' as CallRecording
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in (  	
 	
127	,
191	,
347	,
358	,
361	,
363	,
596 ,
597 
)
)
,tw as (
 select  distinct a.AccountId, 'Yes' as TeamWork
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in ( 
 	
412	,
601	

))

,rent as (
 select  distinct a.AccountId, 'Yes' as HWRentals
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.Product p  (nolock) on a.ProductId = p.Id
where  ServiceStatusId = 1 -- Active
and p.Id in ( 
 	
55	,
66	,
157	,
184	,
185	,
186	,
189	,
193	,
194	,
195	,
196	,
197	,
198	,
199	,
200	,
201	,
202	,
212	,
254	,
256	,
257	,
258	,
259	,
291	,
298	,
304	,
307	,
308	,
309	,
310	,
311	,
324	,
325	,
326	,
327	,
336	,
338	,
370	
))
------
------
------
------
------
select
		 a.*
		,con.ContractType
		,con.TermMonths as ContractTerm
		,con.EndDate as ContractEndDate
		,circuits.Circuit
		,ar.Archiving
		,cc.ContactCenter
		,im.InstantMessaging
		,sms.SMS
		,mob.Mobility
		,collab.Collaboration
		,scribe.Scribe
		,efax.Fax
		,cr.CallRecording
		,tw.TeamWork
		,rent.HWRentals

from
						 a 
		left outer join  con on a.AccountId = con.AccountId and con.rn = 1
		left outer join  circuits on a.AccountId = circuits.AccountId  and circuits.rn = 1
		left outer join  ar on a.AccountId = ar.AccountId
		left outer join  cc on a.AccountId = cc.AccountId
		left outer join  im on a.AccountId = im.AccountId
		left outer join  sms on a.AccountId = sms.AccountId
		left outer join  mob on a.AccountId = mob.AccountId
		left outer join  collab on a.AccountId = collab.AccountId
		left outer join  scribe on a.AccountId = scribe.AccountId
		left outer join  efax on a.AccountId = efax.AccountId
		left outer join  cr on a.AccountId = cr.AccountId
		left outer join  tw on a.AccountId = tw.AccountId
		left outer join  rent on a.AccountId = rent.AccountId
