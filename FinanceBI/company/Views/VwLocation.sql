


CREATE VIEW [company].[VwLocation]
AS
SELECT     
	dbo.UfnRemoveUnprintableChar(L.Name) AS [Loc Name], L.Id AS [Loc Id], L.LichenLocationId,
	L.City AS [Loc City], L.ZipCode AS [Loc ZipCode], 
	C.Name AS Country, C.CodeAlpha2 AS [Country AB], C.CodeAlpha3 AS [Country ABC], 
	SP.CodeAlpha AS [State ST], SP.Name AS StateProvince, 
	dbo.UfnRemoveUnprintableChar( COALESCE(Subtenant, '')) as Subtenant,
	COALESCE(LA.InitialMRR,0.0)as [Loc InitialMRR],
	COALESCE(LA.ActiveMRR,0.0)as [Loc ActiveMRR],
	COALESCE(LA.NumProfiles,0) AS [Loc NumProfiles],
	COALESCE(LA.IsOnNet,0) AS [Loc IsOnNet],
	COALESCE(LA.IsClientMPLS,0) as [Loc IsClientMPLS],
	L.AccountId,
	L.InvoiceGroupId,
	L.IsCommissionable,
	L.DateLiveForecast,
	COALESCE(LA.NumPendingProfiles,0) as NumPendingProfiles,
	LA.ConnectivityType,
	IP.InstallPackage
FROM         
company.Location L 
	LEFT JOIN company.LocationAttr LA ON L.Id = LA.LocationId 
	LEFT JOIN enum.Country C ON L.CountryId = C.Id 
	LEFT JOIN  enum.StateProvince SP ON L.StateProvinceId = SP.Id AND C.Id = SP.CountryId
	LEFT JOIN oss.VwLocationInstallPacakge IP on IP.LocationId = LA.LocationId



