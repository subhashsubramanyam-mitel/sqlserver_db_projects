













CREATE view [Santana].[VwSalesReport_Excel] as
-- MW 06152020 for Sales Report for Migrations

with SalesDiscoveryReport as 
(
SELECT 
	   vwuserdetail.accountid,
       vwuserdetail.accountname,
       vwuserdetail.profiletn,
       vwuserdetail.firstname,
       vwuserdetail.lastname,
       vwuserdetail.username,
       vwuserdetail.businessemail,
       vwuserdetail.locationname,
       vwuserdetail.address,       
	   t.obcid,
       vwuserdetail.profiletype,
       vwuserdetail.extension,
	   vwuserdetail.mobility,
       vwuserdetail.fax,
       vwuserdetail.scribe,
      -- vwuserdetail.callrecording,
       vwuserdetail.conferencing,
       vwuserdetail.grandstream,
       vwuserdetail.ciscospa,
       vwuserdetail.ciscoata,
       vwuserdetail.polycomsoundstation,
       vwuserdetail.linksysspa,
       vwuserdetail.otherdevice,
       vwuserdetail.crm,
       t.[calling restrictions],
       t.[vm to email notification setting],
       t.[alert notification address],
       t.[sound file],
       t.[sound file address],
       t.[delete after wav?],
       t.[shared vm access],
       t.[is call screening enabled?],
       t.[call screening rule],
       t.[call routing - always],
       t.[always fwd],
       t.[call routing - num of rings],
       t.[call routing - no answer],
       t.[no answer fwd],
       t.[shared lines],
       t.[speed dials],
       t.[vm zero out setting],
       t.[replace personal vm],
	   cc.isCCAgent,
	   cc.isCCSupervisor   
	   ,t.CallRecordingType  

	   ,p.[Suggested Connect Profile]
	   ,h.[Suggested Connect Hardware]
	   ,t.aliases 

 

FROM   dbo.SKYUSERDETAIL vwuserdetail
       LEFT OUTER JOIN santana.VWTNCONFIGDETAIL t
                    ON vwuserdetail.profiletn = t.tn 
	LEFT outer join  CCAgentInfo cc on vwuserdetail.ProfileTN = cc.Tn
	left outer join santana.mVwSalesReport_SuggestedHW h on vwuserdetail.ProfileTN = h.Tn
	left outer join santana.mVwSalesReport_SuggestedProfiles p on vwuserdetail.ProfileTN = p.Tn
)


SELECT 
	   accountid,
	  -- accountid as  [Account ID],
	   locationname  as  [Location],
       profiletn as  [Phone Number],
       extension as  [Sky Extension],

	   '' as [Suggested Connect Extension],


       firstname as  [First Name],
       lastname as  [Last Name],
       profiletype as  [Sky Profile],
       CASE WHEN mobility = 'NO' Then null else mobility END as  [Mobility],    
	  -- callrecording as  [Call Recording Enabled],
       CallRecordingType as  [Call Recording On Demand or Always On],
       CASE WHEN scribe  = 'NO' Then null else scribe END as  [Scribe],

       CASE 
		WHEN ciscoata = 'YES' then 'Cisco ATA'
		WHEN grandstream = 'YES' then 'Grandstream'
		WHEN ciscospa = 'YES' then 'Cisco SPA'
		WHEN linksysspa = 'YES' then 'Linksys SPA'
       ELSE '' END  as  [ATA Analog Telephone Adaptor],
      Case WHEN  [shared vm access] = 'None' then '' Else  [shared vm access] END as  [Shared Voicemail],
      CASE WHEN [is call screening enabled?] = 'Disabled' then '' else [is call screening enabled?]  END  as  [Call Screening],
      

	   Case when isCCAgent = 1 then 'YES' ELSE null END  as  [Contact Center Agent],
       Case when isCCSupervisor= 1 then 'YES' ELSE null END  as  [Contact Center Supervisor],	   

	  -- CRM as [Salesforce Integration],
	   NULL as CRM 



	   -- MW 07272020 Call Recording is “Always On”, then the “Suggested Connect Profile” = Elite
	   ,CASE WHEN CallRecordingType = 'Always On' then 'MiCloud Connect Elite' ELSE 
	   [Suggested Connect Profile]	END AS [Suggested Connect Profile],
	   --NULL AS  [Suggested Connect Extension],	

	   [Suggested Connect Hardware]	,
	   NULL AS [Suggested Power Supply],
	   NULL AS Notes,

	    [always fwd]  as  [Always Forward] 

			   	    , CASE WHEN (len( [shared lines]) - len(replace( [shared lines],'|','')) +
         len( [speed dials]) - len(replace( [speed dials],'|','')) ) >7 then 'YES' ELSE '' 
		 END  as  [Side Car for Phone Buttons]  --If total of Speed Dials and Shared Lines > 7, then put Y in that column
       ,aliases as Aliases
--
FROM   SalesDiscoveryReport

 

GO
GRANT SELECT
    ON OBJECT::[Santana].[VwSalesReport_Excel] TO [app_Sky_ro]
    AS [dbo];

