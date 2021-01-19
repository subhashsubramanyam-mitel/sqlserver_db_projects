

CREATE VIEW [analytics].[vw_credits] AS

select
	ars1.M5DBAccountId,
	dbo.Cases.AccountID,
	dbo.Cases.CaseNumber,
	dbo.Cases.ClosedDate,
	dbo.Cases.AccountName,
	dbo.Cases.AccountTeam,
	dbo.Cases.AtRisk,
	dbo.Cases.AtRiskIndicator,
	dbo.Cases.AtRiskSituationID,
	dbo.Cases.DaysToSLA,
	ce.SubTotal,
	dbo.Cases.CreditTotal,
	dbo.Cases.CreditApprovalStatus,
	dbo.Cases.Feature,
	dbo.Cases.SubFeature,
	dbo.Cases.SubReason,
	dbo.Cases.SubStatus,
	dbo.Cases.MilestoneStatus,
	dbo.Cases.ParentCase,
	dbo.Cases.RootCause,
	dbo.Cases.CustomerPlatform,
	ce.TransactionType,
	ars1.TriggerField,
	ars1.RootCausePrimary,
	ars1.RootCauseSecondary,
	ars1.RootCauseTertiary


from dbo.Cases
left join dbo.ARS ars1
	on dbo.Cases.AtRiskSituationID = ars1.ID

left join dbo.SFDC_CREDIT_ENTRY ce
	on dbo.Cases.ID = ce.CaseId

where dbo.Cases.ClosedDate >= '2019-01-01 00:00:00'
and ce.TransactionType in ('Courtesy Credit','Service Credit')
and dbo.Cases.CreditApprovalStatus in ('Data Entry','Approved')
;

