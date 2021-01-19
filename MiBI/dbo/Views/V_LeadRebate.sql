
CREATE VIEW [dbo].[V_LeadRebate]
AS

SELECT
ImpactNumber,
CASE WHEN a.SubType IN ('IVAR','VAR') THEN
	CASE WHEN b.AssocPartnerChampLevel='Authorized' and count(b.SfdcId)>='5' and count(b.SfdcId)<'15' THEN '1'
	WHEN b.AssocPartnerChampLevel='Authorized' and count(b.SfdcId)>='15' THEN '2'
	WHEN b.AssocPartnerChampLevel='Silver' and count(b.SfdcId)>='10' and count(b.SfdcId)<'30' THEN '1'
	WHEN b.AssocPartnerChampLevel='Silver' and count(b.SfdcId)>='30' THEN '2'
	WHEN b.AssocPartnerChampLevel='Gold' and count(b.SfdcId)>='15' and count(b.SfdcId)<'40' THEN '1'
	WHEN b.AssocPartnerChampLevel='Gold' and count(b.SfdcId)>='40' THEN '2'
	WHEN b.AssocPartnerChampLevel='Platinum' and count(b.SfdcId)>='30' and count(b.SfdcId)<'60' THEN '1'
	WHEN b.AssocPartnerChampLevel='Platinum' and count(b.SfdcId)>='60' THEN '2'
	ELSE '0' END

WHEN a.SubType IN ('DMR','Service Provider') THEN
	CASE WHEN b.AssocPartnerChampLevel='Authorized' and count(b.SfdcId)>='30' and count(b.SfdcId)<'80' THEN '1'
	WHEN b.AssocPartnerChampLevel='Authorized' and count(b.SfdcId)>='80' THEN '2'
	WHEN b.AssocPartnerChampLevel='Silver' and count(b.SfdcId)>='40' and count(b.SfdcId)<'110' THEN '1'
	WHEN b.AssocPartnerChampLevel='Silver' and count(b.SfdcId)>='110' THEN '2'
	WHEN b.AssocPartnerChampLevel='Gold' and count(b.SfdcId)>='50' and count(b.SfdcId)<'150' THEN '1'
	WHEN b.AssocPartnerChampLevel='Gold' and count(b.SfdcId)>='150' THEN '2'
	WHEN b.AssocPartnerChampLevel='Platinum' and count(b.SfdcId)>='80' and count(b.SfdcId)<'175' THEN '1'
	WHEN b.AssocPartnerChampLevel='Platinum' and count(b.SfdcId)>='175' THEN '2'
	ELSE '0' END
ELSE '0' END AS LeadRebateAmt

FROM RESELLER a LEFT OUTER JOIN
LEAD b on a.ImpactNumber=b.PartnerSTID

Where (a.SubType IN ('IVAR','VAR') AND LeadSource IN ('Partner Registration','QMS Registration'))
	OR
	(a.SubType IN ('DMR','Service Provider') AND LeadSource IN ('Partner Registration','QMS Registration','Sales Registration'))
--PartnerSTID='50914'
AND ImpactNumber is NOT NULL AND IsNumeric(ImpactNumber)=1

Group by ImpactNumber,SubType,AssocPartnerChampLevel