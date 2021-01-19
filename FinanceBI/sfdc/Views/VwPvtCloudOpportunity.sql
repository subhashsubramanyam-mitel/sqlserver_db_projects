
CREATE view [sfdc].[VwPvtCloudOpportunity] as
select
O.EstimatedMRR [Amount Won]
 ,'PrivateCloud' as 'Bookings Source'
 ,cast (O.[CloseDate] as Date) [Date Closed]
 --extra columns for details
 ,LP.NAME [Lead Partner]
,O.[OpportunityId]
,REPLACE(REPLACE(O.Name, CHAR(10), ''), CHAR(9), '') collate SQL_Latin1_General_CP1_CI_AS [Opportunity Name]
 FROM [sfdc].[Opportunity2] O
  left join sfdc.Account2 A on A.SfdcId = O.AccountID
  left join sfdc.Account2  LP on LP.SfdcId = O.LeadPartner
  where 
  --AT&T Ariba
  O.[LeadPartner]='001C000000rPVJxIAO'
  and O.Created between  '2012-07-01' and '2020-07-01'
  and coalesce(O.CloseDate, '2020-07-01') between  '2012-07-01' and '2020-07-01'
  --OC2
  and O.RecordType <> 'Secondary'
  and O.[Type] <> 'Moves, Splits, Changes'
  and 
  O.EstimatedMRR > 0
  and (Stage like '%Won%') and Stage <> 'Closed Won- MSA'
    and (OwnerRole is null or OwnerRole  <> 'Terminated Users')
