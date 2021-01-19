



  CREATE View [dbo].[V_TRANSITION_CASES] as
  -- for transition to support datasource
select a.CaseNumber, a.AccountName,   a.Description, a.CreatedDate, a.CreatedBy
,a.CaseReason, a.SubReason, a.Priority, a.ClosedDate,
b.Name as ContactName, b.Email as ContactEmail, c.AccountTeam, b.PersonId, a.Resolution
,a.CaseOwner
, a.CaseOwnerRole
,a.RootCause
-- MW 09162020 Brought in location
-- I mispelled it
,Case when isnumeric(a.RelatedLoctionId) = 1 then a.RelatedLoctionId else null end  as RelatedLocationId
from
 Cases  a (nolock)  inner join
	(select SfdcId,  PersonId, FName + ' ' + LName as Name, Email from CONTACTS (nolock) where isnumeric(PersonId) = 1 and len(PersonId) < 10) b on a.ContactID = b.SfdcId inner join
  CUSTOMERS c (nolock) on  a.AccountID = c.SfdcId
  where a.CreatedDate >= '2019-07-01'
