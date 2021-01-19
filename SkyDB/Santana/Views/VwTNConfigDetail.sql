











 CREATE view [Santana].[VwTNConfigDetail] as
 -- MW 05072020  View for Additional Data
 /*
 -- Load table from new source:
   --Clean Data
  --  Santana.additionalUserData_cleaned 
  select  
	   [cluster]
      ,[subscriber_id]
      ,cast([subscriber] as bigint) as tn
      ,[cos_name]
      ,[speed_line_config]
      ,[zero_out_component]
      ,[feature_screen]
      ,[feature_screen_script]
      ,[feature_cf_uncond]
      ,[feature_cf_noans]
      ,[feature_cf_noans_numrings]
      ,[email_notification]
      ,[email_wav]
      ,[dont_keep_vm]
      ,[vm_subscriber_ids]
      ,[att_id]
	  ,email_notification_addr
	  ,email_wav_addr
	  ,shared_line_config
	  ,cf_uncond_addr
	  ,cf_noans_addr
	  ,outbound_callerid_addr
	  ,hcr_record_all
	  ,hcr_control
  into     Santana.additionalUserData_cleaned_5 from
  (
  select 
  * ,
  row_number() over (partition by subscriber order by cluster desc) rn 
  from     [SkyTeamSandbox].[additionalUserData]
  ) a
  where rn =1 and    isnumeric(subscriber) = 1
 */


 select
	 tn 
	,replace(cos_name, 'COS:','') as [Calling Restrictions]
	,CASE WHEN email_notification = '0' then 'No notification' ELSE 'Send (email) notification' END as [VM to Email Notification Setting]
	,email_notification_addr as [Alert Notification Address]	
	,CASE WHEN email_wav = '0' then 'No' Else 'Yes' End as [Sound File]
	,email_wav_addr as  [Sound File Address]	

	,CASE WHEN dont_keep_vm = '0' then 'Keep VM' else 'Dont Keep VM' END as [Delete after wav?]


	,vm_subscriber_ids as [Shared VM Access]
	,case when feature_screen = '0' then 'Disabled' else 'Enabled' END as [Is Call Screening Enabled?]
	,feature_screen_script as [Call Screening Rule]	
	,case 
		when feature_cf_uncond = '0' then 'Ring my phone'
		when feature_cf_uncond = '1' then 'Forward the call'
		when feature_cf_uncond = '2' then 'Send to voicemail'
		when feature_cf_uncond = '3' then 'Forward call and voicemail'
	 END as [Call Routing - Always]
	--,null as [Call Routing Settings]
	,case when   feature_cf_uncond in ( '1', '3') then  cf_uncond_addr else '' end as [Always FWD]

	,feature_cf_noans_numrings as [Call Routing - Num of Rings]
	,case
		when feature_cf_noans = '0' then 'Keep ringing'
		when feature_cf_noans = '1' then 'Forward the call'
		when feature_cf_noans = '2' then 'Send to voicemail'
	 END as [Call Routing - No Answer]
	
	,cf_noans_addr as [No Answer FWD]

		,shared_line_config as [Shared Lines]
	--,<no idea what this feature is> as [>Replace Personal VM ]
	,replace(speed_line_config,'*', 'SD') as [Speed Dials]
	,CASE WHEN zero_out_component = '0' then 'Use Partition Default' 
		  WHEN zero_out_component is null then 'None Listed' ELSE zero_out_component
		END as [VM Zero Out Setting]
	,CASE 
		WHEN att_id = '0' then 'Disabled, do not replace VM'
		WHEN att_id = '-1' then 'None Listed' ELSE att_id
		END as [Replace Personal VM]

,outbound_callerid_addr as OBCID
,CASE 
		WHEN hcr_record_all <> 'None' then 'Always On' 
		WHEN hcr_control <> 'None' then 'On Demand' 
ELSE '' End as CallRecordingType
,aliases
FROM
	Santana.additionalUserData_cleaned_8

/*



*/



GO
GRANT SELECT
    ON OBJECT::[Santana].[VwTNConfigDetail] TO [SkyImp]
    AS [dbo];

