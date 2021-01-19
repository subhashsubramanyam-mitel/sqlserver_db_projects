
CREATE VIEW [dbo].[V_SC_MRRBilling_Test]
AS

SELECT     
r.ImpactNumber,
o.LeadPartner,
o.CloseDate, 
isNULL(EstimatedMRR,'0') as EstimatedMRR_OLD,
CASE WHEN p.Currency !='USD' then ISNULL(CONVERT(Decimal(16,2),EstimatedMRR*p.Plan_Rate),0)
ELSE isNULL(EstimatedMRR,'0') END as EstimatedMRR,
p.Currency

FROM         OPPORTUNITY_UAT o left outer join
RESELLER r on o.LeadPartner=r.SfdcId left outer join
[$(SMD)].dbo.Plan_Rate p on o.CurrencyIsoCode=p.Currency COLLATE DATABASE_DEFAULT
Where o.Type !='Moves, Splits, Changes'
AND o.Stage  IN ('Closed Won','Closed Won- Account Managers')
AND o.EstimatedMRR>0
AND o.RecordType IN ('Standard','Cloud_Account_Management')
AND p.FiscalYear=(select YEAR (DATEADD(month, +6, GETDATE())))  --JO 10202016 without this MRR will be multiplied
--order by 2
