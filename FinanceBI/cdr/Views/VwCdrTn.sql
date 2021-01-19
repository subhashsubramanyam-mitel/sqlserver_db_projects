
create VIEW [cdr].[VwCdrTn]
AS
SELECT     T.AccountId, convert(nvarchar(32),T.Id)Id, T.LocationId, T.Label, T.ProfileId, TT.Name AS TnType
FROM         FinanceBI.provision.Tn T INNER JOIN
                     FinanceBI. enum.TnType TT ON T.TnTypeId = TT.Id
UNION ALL
SELECT     BT.AccountId, convert(nvarchar(32),BT.Id)Id, BT.LocationId, BT.Label, BT.ProfileId, 'BadTN' AS TnType
FROM         cdr.BadTN BT

