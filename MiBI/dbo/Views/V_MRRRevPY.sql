
CREATE VIEW [dbo].[V_MRRRevPY]
AS

-- Partner Year MRR Rev for dashboard

SELECT     ImpactNumber,SUM(EstimatedMRR) as MRRRevPY
FROM         [$(MiBI)].dbo.V_SC_MRRBilling
WHERE     (CloseDate BETWEEN CONVERT(CHAR(10), '10-01-2017', 101) AND CONVERT(CHAR(10), '10-1-2018', 101))
GROUP BY ImpactNumber




