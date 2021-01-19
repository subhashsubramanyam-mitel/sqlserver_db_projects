
CREATE VIEW [dbo].[V_MRRRevPYKicker]
AS

-- Partner Year MRR Rev for dashboard

SELECT     ImpactNumber,SUM(EstimatedMRR) as MRRRevPYKicker
FROM         [$(MiBI)].dbo.V_SC_MRRBillingKicker
WHERE     (CloseDate BETWEEN CONVERT(CHAR(10), '10-01-2016', 101) AND CONVERT(CHAR(10), '10-1-2017', 101))
GROUP BY ImpactNumber

