
CREATE view [dbo].[V_CHURN_ARS_CLOSEORDER] as
--Synced over to bidb for MRR Delta/Churn reporting 20200924
select 
	 a.CaseNumber
	,b.RootCausePrimary	
	,b.RootCauseSecondary	
	,b.RootCauseTertiary	
	,b.Status	 	
	,b.RelatedProduct
	,a.Churn_Reason_Primary__c	as   Case_ChurnReasonPrimary
	,a.Churn_Reason_Secondary__c  as Case_ChurnReasonSecondary
	,a.Related_Product__c   as Case_RelatedProduct
from 
	Cases (nolock) a left outer join
	ARS (nolock) b on a.AtRiskSituationID = b.ID
where a.CreatedDate >= '01-01-2020'
