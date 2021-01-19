CREATE VIEW [dbo].[V_LeadOpptyData]
AS
SELECT a.SfdcId
	,a.Company
	,a.STLeadId
	,a.PartnerSalesStage
	,a.Amount
	,a.OpptyRegEligDate
	,a.OpptyRegSubmitDate
	,a.OpptyRegApprDate
	,a.OpptyRegExpDate
	,a.OpptyRegStatus
	,a.PartnerSTID
FROM dbo.[LEAD] a
LEFT OUTER JOIN dbo.RESELLER r ON a.PartnerSTID = r.ImpactNumber
WHERE ISNULL(PartnerSalesStage, '<No Values>') NOT IN (
		'<No Values>'
		,'Generate Interest'
		,'Discover and Reorient'
		)
	AND (
		(
			r.SubType IN (
				'IVAR'
				,'VAR'
				)
			AND a.LeadSource IN (
				'Partner Registration'
				,'QMS Registration'
				)
			)
		OR (
			r.SubType IN (
				'DMR'
				,'Service Provider'
				)
			AND a.LeadSource IN (
				'Partner Registration'
				,'QMS Registration'
				,'Sales Registration'
				)
			)
		)
	AND (
		(
			r.Theatre = 'North America'
			AND a.Amount >= '25000'
			)
		OR (
			r.Theatre <> 'North America'
			AND a.Amount >= '10000'
			)
		)