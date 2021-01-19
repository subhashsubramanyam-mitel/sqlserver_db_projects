CREATE VIEW ALSandbox.VwOppKPI AS

SELECT dateadd(hour, -8, O.SfdcCreateDateUTC) AS CreateDateAdjFromUTC
	,O.AccountID
	,O.SubType
	,O.OpportunityID
	,O.RecordType
	,Coalesce(USD.EstimatedMRR_USD, O.EstimatedMRR) AS EstimatedMRR
	,O.ProductInterest
	,O.[Type] 
	,O.Name
	,O.CloseDate
	,O.Stage
	,Won 
	,CASE WHEN coalesce(C.Theater, OpportunityTheater) = 'North America' THEN coalesce(C.Region, OpportunityRegion)
		ELSE coalesce(C.Theater, OpportunityTheater)
		END AS Region
	,C.OwnerName
	,O.OpportunityNumber
	,O.PartnerSelectedCampaign
	,O.Qualified
	,O.IsSecondary
FROM [$(MiBI)].dbo.OPPORTUNITY O
LEFT JOIN [$(MiBI)].dbo.CUSTOMERS C
	ON O.AccountID COLLATE SQL_Latin1_General_CP1_CS_AS 
		= C.SfdcId COLLATE SQL_Latin1_General_CP1_CS_AS
LEFT JOIN [$(MiBI)].dbo.V_EstimatedMRR_USD USD 
	ON O.OpportunityID COLLATE SQL_Latin1_General_CP1_CS_AS 
		= USD.OpportunityID  COLLATE SQL_Latin1_General_CP1_CS_AS
