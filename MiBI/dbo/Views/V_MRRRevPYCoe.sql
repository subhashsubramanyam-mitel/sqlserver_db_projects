
CREATE VIEW [dbo].[V_MRRRevPYCoe]
AS

-- Partner Year MRR Rev for dashboard

SELECT     ImpactNumber,SUM(EstimatedMRR) as MRRRevPY
FROM         [$(MiBI)].dbo.V_SC_MRRBilling
WHERE     (CloseDate BETWEEN CONVERT(CHAR(10), '10-01-2015', 101) AND CONVERT(CHAR(10), '10-1-2016', 101))
GROUP BY ImpactNumber



