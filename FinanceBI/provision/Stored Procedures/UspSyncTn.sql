
-- =============================================
-- Author:		Yaniv Schahar
-- Create date: 4/8/11
-- Description:	Sync TN data
--  Change Log:  10/19/11. TN should point to primary profile.
--   CAUTION:     The ROW_NUMBER randomly selects priamry profile in case of multiple.
--                Once the multiple priamry profile situation is corrected in m5db, replace by a simple join.
--	Change Log:  7/15/12 Tarak, added CountryId  -- it was left out of Internationalization planning
--               2014-02-05  Gerry Amitrano
--                   US19123:  As a [Shoretel Staff], I want the ability to set a TN to be FAX type
--                   Column IsMainNumber has been removed; now identified by TnTypeId = 4
-- =============================================
CREATE PROCEDURE [provision].[UspSyncTn] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Tn data';

	MERGE provision.Tn as target
	USING (
		SELECT 
			Tn.Id,Tn.CountryId,
			case	-- Handle the heuristic here, later remove that (when we have the UI) 
				when ( TN.label like '%main %' or TN.Label like '% main%' ) then 2 -- Main
				when ( Tn.Id like '800%' or Tn.Id like '855%' or Tn.Id like '866%' or Tn.Id like '877%' or Tn.Id like '888%' ) then 2 -- Main
				else Tn.TnTypeId
			end as TnTypeId,
			TN.AccountId,
			TN.LocationId,
			TN.ProfileId,
			NULLIF(TN.Label,'') as Label,
			TN.TrunkGroupId,
			TN.TnStatusId
		FROM (
			SELECT 
				T.Id, 
				T.CountryId,
				T.AccountId,
				T.LocationId, 
				P.Id as ProfileId, 
				P.ProfileTypeId, 
				coalesce( NULLIF( ltrim(rtrim(PE.FirstName + ' ' + PE.LastName)), ''), P.InternalCallerId, P.ComponentName) as Label,
				--coalesce(ltrim(rtrim(PE.FirstName + ' ' + PE.LastName)), P.InternalCallerId, P.ComponentName) as Label,
				CASE 
					--WHEN P.IsConference = 1 THEN 3 -- Conference (Have to get this from the partition)
                    -- 2014-02-05  US19123   Next line commented and replaced by succeeding line
					-- WHEN T.IsMainNumber = 1 THEN 2 -- MainNumber
                    WHEN T.TnTypeId = 4 THEN 2  -- MainNumber
					ELSE 1 -- DID
				END as TnTypeId,
				ROW_NUMBER() OVER (PARTITION BY P.TnId order by P.DateModified desc) as LastModifiedProfile,
				T.DateModified as TnDateModified,
				P.DateModified as ProfileDateModified,
				T.TrunkGroupId,
				T.TnStatusId
			FROM 
				M5DB.M5DB.Dbo.[Tn] T with(nolock)
				-- Get the primary profile (if more than one)
				left outer join (
					select P.Id, P.TnId, P.PersonId, P.InternalCallerId, P.ComponentName, /*P.IsConference,*/ P.ProfileTypeId, P.DateModified
					from 
						M5DB.M5DB.Dbo.[Profile] P with(nolock)
						--inner join M5DB.M5DB.Dbo.[Partition] Par with(nolock) on Par.Id = P.PartitionId
					where 
						TnId is not null and P.isPrimary = 1 and P.ProfileStatusId = 0
						--and Par.PrimaryCluster = 1
				) P on P.TnId = T.Id
				left outer join M5DB.M5DB.Dbo.[Person] PE with(nolock) on P.PersonId = PE.Id
			) TN
		WHERE
			( Tn.ProfileId is null or TN.LastModifiedProfile = 1 )
			and ( ( TN.TnDateModified >= @lastSync ) or ( TN.ProfileDateModified >= @lastSync ) )
	) AS source
	ON target.Id = source.Id and target.CountryId = source.CountryId
	WHEN MATCHED THEN	
		UPDATE SET 
			target.TnTypeId = source.TnTypeId, 
			target.AccountId = source.AccountId, target.LocationId = source.LocationId, target.ProfileId = source.ProfileId, 
			target.Label = source.Label,
			target.TrunkGroupId = source.TrunkGroupId,
			target.TnStatusId = source.TnStatusId
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, CountryId, TnTypeId, AccountId, LocationId, ProfileId, Label,TrunkGroupId,TnStatusId ) 
		VALUES ( Id, CountryId, TnTypeId, AccountId, LocationId, ProfileId, Label,TrunkGroupId,TnStatusId  )
	OUTPUT 'provision.Tn', $action INTO SyncChanges;

-- Duplicate TNs with other CountryId need to be removed
	delete from provision.TN
		where CountryId = 840 and id in (
		select Id from provision.TN 
		group by Id
		having count(1) > 1
		)

	PRINT convert(varchar,getdate(),14) + N': End syncing Tn data';

END

