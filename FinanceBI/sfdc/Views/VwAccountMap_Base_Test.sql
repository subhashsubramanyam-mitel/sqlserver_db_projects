



-- cast(convert(float, SA.M5DBAccountId) as int)

 CREATE view [sfdc].[VwAccountMap_Base_Test] as
 select Left(SA.SfdcId,18) SfdcId, SA.Name SfdcAccount,  T.SfdcId SfdcTerritoryId, 
 CASE WHEN M5DBAccountID like 'EU-%' THEN 'EU'
     WHEN M5DBAccountID like 'AU-%' THEN 'AU'
     WHEN isnumeric(SA.M5dbAccountId) = 1 THEN 'US' ELSE 'None' END Region,
  CASE WHEN M5DBAccountID like '%-%' THEN convert(int, SUBSTRING(M5DBAccountID,4,len(M5DBAccountId)-3))
     WHEN isnumeric(SA.M5dbAccountId) = 1 THEN convert(int, M5DBAccountID)
	 ELSE 0 END 
  M5dbAccountId 
 from
  sfdc.Account2  SA 
	LEFT JOIN [sfdc].[vwTerritory] T
			ON T.TerritoryName = SA.STTerritory
  where 
 (SA.M5DBAccountID LIKE 'EU-%' or SA.M5dbAccountId LIKE 'AU-%' or isnumeric(SA.M5dbAccountId) = 1 )
 and not (SA.M5DBAccountId = '1129' and SA.DBnum = '0')
   







