






CREATE View [sfdc].[VwSkyCase] as
SELECT  
      SC.ID [SfdcId]
      ,SC.[AccountName]
      ,SC.[CaseNumber]
      ,SC.[CaseOwnerRole]
      ,SC.CaseReason [Reason]
      ,1 [NumberOfCases]
      ,SC.AccountID AccountId
      ,SC.CreatedDate [SfdcCreateDate]
      ,SC.LastModifiedDate [SfdcModifiedDate]
      ,Coalesce(A.Id, AN.Id) M5dbAccountId
      ,[CaseOrigin]
	  ,CASE WHEN coalesce(AccountName,'')='' and coalesce(AccountId,'') = '' and coalesce(CaseOwnerRole,'') = '' and
				coalesce(CaseReason,'')='' and coalesce(CaseOrigin,'') = '' 
			THEN 0 else 1 END IsBlank
	  ,CASE WHEN Coalesce(A.Id, AN.Id) is not null THEN 1 else 0 END HasAccount
	  ,CASE WHEN CaseReason = 'Outage' THEN CaseReason 
			WHEN CaseReason = 'Add Service' THEN CaseReason
			ELSE 'Other' 
			END as CaseType
	  ,CASE WHEN CaseOrigin in ('Nagios', 'Outage Email') and CaseOwnerRole like '%NOC%' THEN 'NOC'
			WHEN CaseOwnerRole like '%NOC%' THEN 'Support/NOC'
			ELSE 'Support'
			END Category

  FROM [sfdc].Cases SC
    left join (select * from Sfdc.Account2 where ISNUMERIC(M5DBAccountID) = 1) SA on SA.SfdcId = SC.AccountID
	left join company.Account A on A.Id = cast (SA.M5DBAccountID as numeric) 
	left join (select A.*, ROW_NUMBER() over (partition by A.Name order by Id desc) ranknum
				from company.Account A) AN 
					on AN.Name = SC.AccountName collate SQL_Latin1_General_CP1_CI_AS
					and ranknum=1
	where 	
	coalesce(SA.CustomerType,SC.CustomerType)  collate SQL_Latin1_General_CP1_CI_AS like '%cloud%' -- in ('CLOUD', 'Legacy Cloud') 
	and SC.Status collate SQL_Latin1_General_CP1_CI_AS not in ('Duplicate', 'Spam', 'Void')
	and (SC.CaseOwnerRole collate SQL_Latin1_General_CP1_CI_AS like '%NOC%' or SC.CaseOwnerRole like '%Support%')





