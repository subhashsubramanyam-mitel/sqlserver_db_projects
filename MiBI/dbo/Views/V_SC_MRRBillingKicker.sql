
CREATE VIEW [dbo].[V_SC_MRRBillingKicker]
AS
--JO 03072017 per Monica to calculate kicker
SELECT     
r.ImpactNumber,
o.LeadPartner,
o.CloseDate, 
--isNULL(EstimatedMRR,'0') as EstimatedMRR  
--JO 09032016 per Multicurrency
CASE WHEN o.CurrencyIsoCode !='USD' then ISNULL(CONVERT(Decimal(16,2),EstimatedMRR*p.Plan_Rate),0)
ELSE isNULL(EstimatedMRR,'0') END as EstimatedMRR

FROM         OPPORTUNITY o left outer join
RESELLER r on o.LeadPartner=r.SfdcId left outer join
[$(SMD)].dbo.Plan_Rate p on o.CurrencyIsoCode=p.Currency COLLATE DATABASE_DEFAULT
Where o.Stage  IN ('Closed Won')
AND o.EstimatedMRR>0
AND o.RecordType IN ('Standard')
AND o.SubType IN ('Migrate Premises to Cloud')
and o.AccountName not in ('kim demo','test','hamlin')
and (o.CloseDate BETWEEN CONVERT(CHAR(10), '10-01-2016', 101) AND CONVERT(CHAR(10), '10-1-2017', 101))
AND p.FiscalYear=(select YEAR (DATEADD(month, +6, GETDATE())))  --JO 10202016 without this MRR will be multiplied
--order by 2


