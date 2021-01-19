

CREATE view [sfdc].[vwTerritory] as 
select 
Created,	SfdcId,	AXCode,	Region,	TerritoryName,	Subregion,	Theatre,	CSM,	ASM,	SE,		
	RVP,
	RD,	ASR,	DualCSEPBM,	CloudCSR,	GOV,
	/*
		CASE WHEN Theatre != 'North America' THEN Theatre
		  WHEN SubRegion = 'Canada' THEN 'East & Canada'
		  WHEN Region = 'South Central' THEN 'Central'
		  WHEN Region = 'South East' THEN 'East & Canada'
		  WHEN Region = 'East' THEN 'East & Canada'
		  WHEN Region = 'Rockies' THEN 'West'
		  ELSE Region 
		  END */ -- Old deprecated
		'Deprecated' AS RVPrevised,
		CASE WHEN Theatre in ( 'APAC', 'EMEA',  'CALA') then Theatre  
		     WHEN Region is not null then Region
			 ELSE Theatre --
		END as RegionRevised

from SFDC.Territory 

