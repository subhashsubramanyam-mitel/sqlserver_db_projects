
CREATE VIEW [dbo].[V_ARS]
AS

--JO 04272015 per Andrew Lossing created ARS with Calcs
select
a.ID, a.AccountID, a.ARSCount, a.ARSID, a.AtRiskNow, a.CreatedBy, a.CreatedByID, a.CreatedDate, a.DateLost, a.DateSaved, a.EffectiveMRRChangeDate, a.LastModifiedBy, 
                      a.LastModifiedByID, a.LastModifiedDate, a.M5DBAccountId, a.PendingMRRChange, a.RootCausePrimary, a.RootCauseSecondary, a.RootCauseTertiary, a.Status, a.TriggerField, 
                      a.WeeklyUpdate,
cus.NAME as AccountName,
DATEDIFF(dd,getdate(),a.DateLost) as LostAgeInDays,DATEDIFF(hh,getdate(),a.DateLost) as LostAgeInHours,
CASE WHEN a.DateSaved is NULL AND a.DateLost is NULL THEN DATEDIFF(hh,getutcdate(),CreatedDate)
	ELSE CASE WHEN isNULL(a.DateSaved,0)>isNULL(a.DateLost,0) then DATEDIFF(hh,a.DateSaved,CreatedDate)
		ELSE DATEDIFF(hh,a.DateLost,CreatedDate) END
	END as ARSAgeInHours,
CASE WHEN a.DateSaved is NULL AND a.DateLost is NULL THEN DATEDIFF(dd,getutcdate(),a.CreatedDate)
	ELSE CASE WHEN isNULL(a.DateSaved,0)>isNULL(a.DateLost,0) then DATEDIFF(dd,a.DateSaved,a.CreatedDate)
		ELSE DATEDIFF(dd,a.DateLost,a.CreatedDate) END
	END as ARSAgeInDays,
CASE WHEN a.DateSaved=a.DateLost THEN a.DateSaved
	WHEN a.DateSaved > a.DateLost THEN a.DateSaved
	WHEN a.DateLost > a.DateSaved THEN a.DateLost  --required because of NULLs
	WHEN a.DateLost is NULL THEN a.DateSaved
	WHEN a.DateSaved is NULL THEN a.DateLost
		ELSE NULL
	END as CloseDate

from ARS a LEFT OUTER JOIN
CUSTOMERS cus on a.AccountID=cus.SfdcId

GO
GRANT SELECT
    ON OBJECT::[dbo].[V_ARS] TO [TacEngRole]
    AS [dbo];

