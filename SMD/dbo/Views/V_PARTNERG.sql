-- MW 09242014 Partner Grouping based on  COE Account
CREATE view [dbo].[V_PARTNERG] as 
select 
	a.ImpactNumber as PartnerId,
	ISNULL(b.ImpactNumber, a.ImpactNumber) as PartnerGId,
	ISNULL(b.AccountName, a.AccountName) as PartnerG
from 
SFDC_PARTNERS a left outer join
SFDC_PARTNERS b on a.CoeAccount = b.SfdcId
