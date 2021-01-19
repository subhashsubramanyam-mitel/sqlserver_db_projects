

CREATE View [dbo].[V_TABLEAU_CASEINFO] as
-- MW 03052019  additional fields for CaseMilestone in Tableau
SELECT        b.ID AS CaseId, b.CaseNumber, b.CustomerPlatform, b.ClosedDate AS CaseCloseDate, Users.Name AS CaseOwnerName, Users.RoleName AS CaseOwnerRole, b.Status, b.Priority
,b.Theater as Theatre
FROM            Cases AS b WITH (nolock) INNER JOIN
                         Users WITH (nolock) ON b.OwnerId = Users.ID
WHERE        (YEAR(b.CreatedDate) >= 2017)
