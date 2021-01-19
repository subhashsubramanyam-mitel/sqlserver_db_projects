
CREATE VIEW [provision].[VwTn]
AS
SELECT     TN.AccountId, TN.Id, TN.LocationId, TN.Label, TN.ProfileId, TT.Name AS TnType, 
			A.Name Carrier, TS.Name as TnStatus
FROM         provision.Tn TN
INNER JOIN
                      enum.TnType TT ON TN.TnTypeId = TT.Id
LEFT JOIN enum.TnStatus TS on TS.Id = TN.TnStatusId
left join provision.CircuitTrunkGroup TG on TG.Id = TN.TrunkGroupId 
left join company.Account A on A.Id = CarrierAccountId

