









 CREATE   View [MWSandbox].[VwSkyCustomerInfo] as 
-- MW 11212017 Account Info for Santana
-- All Sky
SELECT 
	 aaa.LichenAccountId
	--isnull(aaaa.CustomerNum, 0) as CustomerNum
	 ,a.AccountId
	,a.AccountName
	,aa.ActiveMRR
	,b.ContractType
	,b.DaysSinceStart
	,b.StartDate
	,b.DaysUtilEnd
	,b.EndDate
	,c.AtRisk as AtRisk_SFDC
	,d.Sites
	,aa.NumProfiles
	,n.BilledProfiles
	,o.Mobility
	,CASE WHEN isnull(e.Profiles,0) = 0 then 'NO' else 'YES' end as HasNonStandardExt
	--,CASE WHEN isnull(f.Profiles,0) = 0 then 'NO' else 'YES' end as ExtStartsWith0Or9
	,ISNULL(f.Profiles,0) as ExtStartsWith0Or9
	,ISNULL(f.ProfilesStartWith0,0) as ProfilesStartWith0
	,ISNULL(f.ProfilesStartWith9,0) as ProfilesStartWith9
	,CASE WHEN isnull(g.NumberOfSCCs,0) = 0 then 'NO' else 'YES' end as HasSCC
	,h.CRM
	,isnull(i.Interested, 'NO') as InterestedAccount
	,aaa.OutDialDigit
	-- Batch
	/* CASE WHEN 
	((	(b.DaysUtilEnd >90 AND b.DaysSinceStart >90) AND
		d.Sites <=3 AND
		aa.NumProfiles <= 100 AND
		isnull(e.Profiles,0) = 0  AND
		h.CRM is null) OR i.Interested = 'YES')
		THEN '1' else 'TBD' END as BatchNumber
	*/
	,q.BatchHist as BatchNumber
	,j.ExtLength
	,j.PageGroupsgt25
	,j.Cisco7937
	,j.RingGroupsgt16
	,j.BargeGroups
	,isnull(k.NumRentalPhones,0) as NumRentalPhones
	,isnull(l.Grandstream	,0) Grandstream
,isnull(l.CiscoSPA	,0)CiscoSPA112
,isnull(l.CiscoATA	,0)CiscoATA
,isnull(l.PolycomSoundStation,0)	PolycomSoundStation
,isnull(l.LinkSysSPA,0)	LinkSysSPA
,isnull(l.Other,0)	Other
,CASE WHEN m.AccountId is null then 'NO' ELSE 'YES' end as ReportingAPI,
 p.[Trigger]	as  ARS_Trigger,
 p.RootCausePrimary	as ARS_RootCausePrimary,
 p.RootCauseSecondary	as ARS_RootCauseSecondary,
 p.RootCauseTertiary	as ARS_RootCauseTertiary,
 p.Status	as ARS_Status
 ,c.CustomerType
 ,aa.CreditHoldType
 ,c.PartnerName
 ,c.PartnerSfdcId
 ,c.PartnerM5DBAccountId_SFDC
 ,aaa.PartnerId as PartnerId_BOSS

  FROM
	 -- [MWSandbox].[SkyAccountList] a left outer join
	 (	Select 
			[Ac Id] as AccountId,
			[Ac Name] as AccountName
		from 
		[$(FinanceBI)].company.VwAccount
		where Platform = 'Call Conductor' and  IsActive = 1 and IsBillable = 1
	 )							a left outer join
	  [$(FinanceBI)].company.Account aaa on a.AccountId = aaa.Id left outer join
	  [$(FinanceBI)].company.AccountAttr aa on a.AccountId = aa.AccountId left outer join
	  --MWSandbox.VwBossIdLookup aaaa on a.AccountId = aaaa.AccountId left outer join
	  [MWSandbox].VwContractInfo b on a.AccountId = b.AccountId left outer join
	  MWSandbox.VwSfdc c on a.AccountId = c.AccountId    and  Isnumeric( a.AccountId ) = 1 left outer join
	  MWSandbox.VwSites d on a.AccountId = d.AccountId left outer join
	  MWSandbox.Vw4Or5Digit e on a.AccountId= e.AccountId left outer join
	  MWSandbox.VwExtStartsWith09 f on a.AccountId = f.AccountId left outer join
	  MWSandbox.VwSCC g on a.AccountId = g.AccountId left outer join
	  MWSandbox.CrmUsage h on a.AccountId =h.AccountId left outer join
	  /*  for SFDC:

				  insert into MWSandbox.CrmUsage    
				  select  distinct b.AccountId , 'Salesforce' as CRM
				  from 
				  MWSandbox.ProfileCRM_Standard a inner join
				  [$(FinanceBI)].provision.VwProfile b on a.TN = b.Tn
				  where b.AccountId not in (select AccountId from MWSandbox.CrmUsage)
	  */
	  MWSandbox.InterestedAccounts i on a.AccountId = i.AccountId  left outer join
	  MWSandbox.VwElvisData j on aaa.Id = j.AccountId left outer join
	  MWSandbox.VwNumRentalPhones k on a.AccountId = k.AccountId
	    left outer join MWSandbox.VwDeviceInfo  l on a.AccountId = l.AccountId left outer join
	 MWSandbox.VwReportingAPIAccounts m on a.AccountId = m.AccountId left outer join
	 [MWSandbox].[VwProfilesBilled] n on a.AccountId = n.AccountId left outer join
	 [MWSandbox].[VwSkyMobService] o on  a.AccountId = o.AccountId left outer join
	 MWSandbox.VwSfdcARS p on  a.AccountId = p.AccountId left outer join
	 --MW 04272018 Show batch
	 [Santana].[MigrationQueue_Sky] q on a.AccountId = q.AccountId
Where b.ContractType <> 'Month-to-Month'
UNION ALL
SELECT 
	aaa.LichenAccountId
--	,isnull(aaaa.CustomerNum,  0) as CustomerNum
	, a.AccountId
	,a.AccountName
	,aa.ActiveMRR
	,b.ContractType
	,b.DaysSinceStart
	,b.StartDate
	,b.DaysUtilEnd
	,b.EndDate
	,c.AtRisk as AtRisk_SFDC
	,d.Sites
	,aa.NumProfiles
	,n.BilledProfiles
	,o.Mobility
	,CASE WHEN isnull(e.Profiles,0) = 0 then 'NO' else 'YES' end as HasNonStandardExt
	--,CASE WHEN isnull(f.Profiles,0) = 0 then 'NO' else 'YES' end as ExtStartsWith0Or9
	,ISNULL(f.Profiles,0) as ExtStartsWith0Or9
		,ISNULL(f.ProfilesStartWith0,0) as ProfilesStartWith0
	,ISNULL(f.ProfilesStartWith9,0) as ProfilesStartWith9
	,CASE WHEN isnull(g.NumberOfSCCs,0) = 0 then 'NO' else 'YES' end as HasSCC
	,h.CRM
	,isnull(i.Interested, 'NO') as InterestedAccount
	,aaa.OutDialDigit
	  -- Batch
	 /* CASE WHEN 
	--	--(b.DaysUtilEnd >90 AND b.DaysSinceStart >90) AND
		((d.Sites <=3 AND
		aa.NumProfiles <= 100 AND
		isnull(e.Profiles,0) = 0 
		  AND
		h.CRM is null) OR i.Interested = 'YES')
		THEN '1' else 'TBD' END as BatchNumber
		*/
	,q.BatchHist as BatchNumber
			,j.ExtLength
	,j.PageGroupsgt25
	,j.Cisco7937
	,j.RingGroupsgt16
	,BargeGroups
	,isnull(k.NumRentalPhones,0) as NumRentalPhones
	,isnull(l.Grandstream	,0) Grandstream
,isnull(l.CiscoSPA	,0)CiscoSPA112
,isnull(l.CiscoATA	,0)CiscoATA
,isnull(l.PolycomSoundStation,0)	PolycomSoundStation
,isnull(l.LinkSysSPA,0)	LinkSysSPA
,isnull(l.Other,0)	Other
,CASE WHEN m.AccountId is null then 'NO' ELSE 'YES' end as ReportingAPI,
 p.[Trigger]	as  ARS_Trigger,
 p.RootCausePrimary	as ARS_RootCausePrimary,
 p.RootCauseSecondary	as ARS_RootCauseSecondary,
 p.RootCauseTertiary	as ARS_RootCauseTertiary,
 p.Status	as ARS_Status
 ,c.CustomerType
 ,aa.CreditHoldType
 ,c.PartnerName
 ,c.PartnerSfdcId
 ,c.PartnerM5DBAccountId_SFDC
 ,aaa.PartnerId as PartnerId_BOSS

  FROM
	 -- [MWSandbox].[SkyAccountList] a left outer join
	 (	Select 
			[Ac Id] as AccountId,
			[Ac Name] as AccountName
		from 
		[$(FinanceBI)].company.VwAccount
		where Platform = 'Call Conductor' and  IsActive = 1 and IsBillable = 1
	 )							a left outer join
	  [$(FinanceBI)].company.Account aaa on a.AccountId = aaa.Id left outer join
	  [$(FinanceBI)].company.AccountAttr aa on a.AccountId = aa.AccountId left outer join
	  --MWSandbox.VwBossIdLookup aaaa on a.AccountId = aaaa.AccountId left outer join
	  [MWSandbox].VwContractInfo b on a.AccountId = b.AccountId left outer join
	  MWSandbox.VwSfdc c on a.AccountId = c.AccountId  and  Isnumeric( a.AccountId ) = 1 left outer join
	  MWSandbox.VwSites d on a.AccountId = d.AccountId left outer join
	  MWSandbox.Vw4Or5Digit e on a.AccountId= e.AccountId left outer join
	  MWSandbox.VwExtStartsWith09 f on a.AccountId = f.AccountId left outer join
	  MWSandbox.VwSCC g on a.AccountId = g.AccountId  left outer join
	  MWSandbox.CrmUsage h on a.AccountId =h.AccountId  left outer join
	  MWSandbox.InterestedAccounts i on a.AccountId = i.AccountId left outer join
	  MWSandbox.VwElvisData j on aaa.Id = j.AccountId  left outer join
	  MWSandbox.VwNumRentalPhones k on a.AccountId = k.AccountId 
   left outer join MWSandbox.VwDeviceInfo  l on a.AccountId = l.AccountId left outer join
	 MWSandbox.VwReportingAPIAccounts m on a.AccountId = m.AccountId 	  
	  left outer join
	 [MWSandbox].[VwProfilesBilled] n on a.AccountId = n.AccountId  left outer join
	 [MWSandbox].[VwSkyMobService] o on  a.AccountId = o.AccountId  left outer join
	 MWSandbox.VwSfdcARS p on  a.AccountId = p.AccountId  left outer join
	 --MW 04272018 Show batch
	 [Santana].[MigrationQueue_Sky] q on a.AccountId = q.AccountId
Where b.ContractType = 'Month-to-Month'
 

 /*
 Drop table  MWSandbox.MigrationCustList
select * INTO MWSandbox.MigrationCustList  from
MWSandbox.VwSkyCustomerInfo
 */












