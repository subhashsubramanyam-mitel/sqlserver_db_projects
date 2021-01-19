
--JO 05272015 per Sree/Brandon 

CREATE VIEW [dbo].[V_SrDefInterface]
AS
select ID,CaseID as SrID,DefectNumber,Defect,'CaseDefect' as AssocType,CreatedDate,LastModifiedDate from CaseDefect
--Where CaseID='500C000000fe8fWIAQ'
--Where CaseNumber='00314487'

UNION ALL
select a.ID, a.RelatedCaseID as SrID, c.EngEngageNum as DefectNumber,b.DefectID as Defect,'MRTCase' as AssocType,a.CreatedDate,a.LastModifiedDate 
from MRTCase a INNER JOIN
MRT b on a.RelatedMRTID=b.ID LEFT OUTER JOIN
DefectManagement c on b.DefectID=c.ID
--Where a.ID='a1OC0000002xrpvMAA'

UNION ALL
select ID,RelatedCaseID as SrID,EngEngageNum as DefectNumber,ID as Defect,'DefectManagement' as AssocType,CreatedDate,LastModifiedDate from DefectManagement
Where RelatedCaseID is not NULL
--Where RelatedCaseID='500C000000fe8fWIAQ'

--order by DefectNumber



GO
GRANT SELECT
    ON OBJECT::[dbo].[V_SrDefInterface] TO [TacEngRole]
    AS [dbo];

