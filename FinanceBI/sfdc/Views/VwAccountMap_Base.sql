





 CREATE view [sfdc].[VwAccountMap_Base] as
 select Left(SA.SfdcId,18) SfdcId, SA.Name SfdcAccount,  T.SfdcId SfdcTerritoryId, A.Id M5dbAccountId, coalesce(A.Name, LA.Name) Account  from
  sfdc.Account2  SA 
  left join company.Account A on A.Id = cast(convert(float, SA.M5DBAccountId) as int)
    left join company.Account LA on LA.LichenAccountId = cast(convert(float, SA.M5DBAccountId) as int)
		LEFT JOIN [sfdc].[vwTerritory] T
			ON T.AXCode = SA.AxCode
  where 
 (SA.M5DBAccountID NOT LIKE '%-%' and isnumeric(SA.M5dbAccountId) = 1 and SA.M5dbAccountId is not null)
 and not (SA.M5DBAccountId = '1129' and SA.DBnum = '0')
   







