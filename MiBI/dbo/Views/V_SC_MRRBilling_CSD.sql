
CREATE VIEW [dbo].[V_SC_MRRBilling_CSD]
AS

SELECT     
r.ImpactNumber as LPImpactNumber,
rr.ImpactNumber as RPImpactNumber,
rrr.ImpactNumber as CSDMAImpactNumber,
o.LeadPartner,
o.CloseDate, 
--JO 09032016 per Multicurrency
CASE WHEN o.CurrencyIsoCode !='USD' then ISNULL(CONVERT(Decimal(16,2),EstimatedMRR*p.Plan_Rate),0)
ELSE isNULL(EstimatedMRR,'0') END as EstimatedMRR

FROM         OPPORTUNITY o left outer join
RESELLER r on o.LeadPartner=r.SfdcId left outer join
RESELLER rr on o.ReferringPartner=rr.SfdcId left outer join
RESELLER rrr on r.CSDMA=rrr.SfdcId left outer join
[$(SMD)].dbo.Plan_Rate p on o.CurrencyIsoCode=p.Currency COLLATE DATABASE_DEFAULT
Where o.Type !='Moves, Splits, Changes'
AND o.Stage  IN ('Closed Won','Closed Won- Account Managers')
AND o.EstimatedMRR>0
AND o.RecordType IN ('Standard','Cloud_Account_Management')
--AND p.FiscalYear=(select YEAR (DATEADD(month, +6, GETDATE())))  --JO 10202016 without this MRR will be multiplied
AND p.FiscalYear='2017'
--order by 2

