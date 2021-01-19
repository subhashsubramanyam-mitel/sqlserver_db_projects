CREATE VIEW V_OpenAir_Migration_Analysis
AS
-- MW 10012019 OpenAir Migration open Project Analysis
SELECT p.OAProjectId
	,p.ProjectStatus
	,p.ProjectOwnerName
	,o.OpportunityNumber
	,s.ContractStatus
	,s.ServiceStatus
FROM dbo.SFDC_PROJECT p
INNER JOIN dbo.OPPORTUNITY o ON p.OppId = o.OpportunityID
LEFT OUTER JOIN [$(FinanceBI)].Tableau.VwServicesByContract_OA s ON o.OpportunityNumber = s.ContractNumber collate database_default
WHERE ProjectStatus NOT IN (
		'Closed'
		,'Lost'
		,'Complete'
		)