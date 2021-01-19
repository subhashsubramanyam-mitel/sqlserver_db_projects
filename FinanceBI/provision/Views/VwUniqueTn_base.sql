


/* Change Log: 5/25/2018, added 10 digits to avoid numbers with leading zeros) */

create VIEW [provision].[VwUniqueTn_base]
AS
SELECT     TN.AccountId, Right(TN.Id,10) Id, TN.LocationId, TN.Label,  TT.Name TnType, A.Name Carrier,
			TN.ProfileId,P.Name ProfileName, Coalesce(P.IsConference,0) IsConference, 
			Coalesce(P.IsDid,0) IsDID, Coalesce(P.IsMainLine,0) IsMainLine, TS.Name as TnStatus
FROM         
	(
		select FOO.*, ROW_NUMBER() over (PARTITION BY Right(Foo.Id,10) ORDER BY IsUS DESC) as TnRank
		from (
				select T.*,
						CASE WHEN CountryId = 840 THEN 1 ELSE 0 END as IsUS
				from provision.Tn T
			) FOO
	) TN
left join provision.Profile P on P.Id = TN.ProfileId and P.Tn = Tn.Id and P.IsActive = 1
inner join enum.TnType TT on TT.Id = TN.TnTypeId
LEFT JOIN enum.TnStatus TS on TS.Id = TN.TnStatusId
left join provision.CircuitTrunkGroup TG on TG.Id = TN.TrunkGroupId 
left join company.Account A on A.Id = TG.CarrierAccountId

WHERE TN.TnRank = 1 -- consider only one TN in case of multiple countries, preferring US if present




