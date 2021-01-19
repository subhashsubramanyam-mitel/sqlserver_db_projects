CREATE VIEW [dbo].[V_MRRRevPrev3Qtrs]
AS
-- Partner Year MRR Rev for dashboard
SELECT ImpactNumber
	,SUM(EstimatedMRR) AS MRRRev1Yr
FROM dbo.V_SC_MRRBilling
WHERE (
		CloseDate BETWEEN 
				-- first day of 3rd previous quarter
				DATEADD(qq, DATEDIFF(qq, 0, DATEADD(qq, - 3, getdate())), 0)
			AND CONVERT(CHAR(10), GETDATE(), 101)
		)
GROUP BY ImpactNumber

