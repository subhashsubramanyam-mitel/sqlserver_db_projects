


CREATE view [sfdc].[VwARSClose] as
-- MW 20200924  Close Order ARS. linked to Boss Close Order for MRR delta / Churn
select * from [$(MiBI)].dbo.V_CHURN_ARS_CLOSEORDER;
