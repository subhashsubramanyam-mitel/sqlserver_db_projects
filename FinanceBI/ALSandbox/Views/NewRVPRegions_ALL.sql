	CREATE VIEW ALSandbox.NewRVPRegions_ALL AS

	SELECT TerritoryName
			,CASE WHEN Theatre != 'North America' THEN Theatre
			  WHEN SubRegion = 'Canada' THEN 'East & Canada'
			  WHEN Region = 'South Central' THEN 'Central'
			  WHEN Region = 'South East' THEN 'East & Canada'
			  WHEN Region = 'East' THEN 'East & Canada'
			  WHEN Region = 'Rockies' THEN 'West'
			  ELSE Region 
			  END AS RVP
	FROM [sfdc].[vwTerritory]
