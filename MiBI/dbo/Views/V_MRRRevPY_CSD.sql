
CREATE VIEW [dbo].[V_MRRRevPY_CSD]
AS

-- Partner Year MRR Rev for dashboard

SELECT     LPImpactNumber,RPImpactNumber,CSDMAImpactNumber,EstimatedMRR as MRRRevPY
FROM         [$(MiBI)].dbo.V_SC_MRRBilling_CSD
WHERE     (CloseDate BETWEEN CONVERT(CHAR(10), '10-01-2017', 101) AND CONVERT(CHAR(10), '10-1-2018', 101))
--GROUP BY LPImpactNumber,RPImpactNumber,CSDMAImpactNumber





