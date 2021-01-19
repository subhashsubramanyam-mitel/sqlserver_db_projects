










CREATE View [dbo].[V_TABLEAU_SFDC_CUST_INFO] as
-- MW 12102019  Customer Data view for Boss Pipeline in Tableau
select 
  a.SfdcId
 ,a.M5DBAccountID as AccountId
 ,b.NAME as PartnerName
 ,a.CSD_MA
		 ,CASE WHEN 
			(CASE 
			WHEN isnumeric(a.DbNumOfEmployees) = 1 then cast(a.DbNumOfEmployees as int)
			ELSE 0 END
			) < isnull(a.NodeEmployeeCount,0) then a.NodeEmployeeCount 
			WHEN 
			(CASE 
			WHEN isnumeric(a.DbNumOfEmployees) = 1 then cast(a.DbNumOfEmployees as int)
			ELSE 0 END
			) > isnull(a.NodeEmployeeCount,0) then 
				(CASE 
			WHEN isnumeric(a.DbNumOfEmployees) = 1 then cast(a.DbNumOfEmployees as int)
			ELSE 0 END
			)
			ELSE 0 END as Employees
	,a.CSM
	,c.NAME as PartnerName_Onsite
	,a.AccountTeam
	,a.BOSS_Support_Partner__c
	,a.MiCloud_Connect_Business_Model__c
	,a.PartnerDisplayName__c
	,a.PartnerSupportEmailAddress__c
	,a.PartnerSupportInformation__c
	,a.PartnerSupportPhoneNumber__c
	,a.PartnerSupportWebPage__c
	,a.Support_Partner_Enabled__c
	,b.SAPNumber as PartnerOfRecordCloudSAPNumber
	,row_Number() over (partition by a.M5DBAccountID order by a.Created  desc) rn
from 
	CUSTOMERS a (nolock) left outer join
	CUSTOMERS b (nolock) on a.PartnerOfRecordCloud = b.SfdcId left outer join
	CUSTOMERS c (nolock) on a.PartnerSfdcId = c.SfdcId 
where  a.M5DBAccountID  is not Null
 
