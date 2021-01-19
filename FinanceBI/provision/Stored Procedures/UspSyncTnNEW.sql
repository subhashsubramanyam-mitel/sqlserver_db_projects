
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
--  Change Log:  Sep 09, 2015, Tarak, Optimize 
--               F3b 24, 2017, Tarak, delete US numbers for identical Foreign numbers
--               Jul 18, 2018, Tarak, introduce materialized view for TNs to avoid Rank function related SQL server bug
-- =============================================
CREATE PROCEDURE [provision].[UspSyncTnNEW] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Tn data';

	Declare @SyncTIme Varchar(12) = Convert(varchar(10), DateAdd(day, 0, @lastSync), 120); -- 0 day safety window
	DECLARE @SS varchar(8000) = '
	MERGE provision.Tn as target
	USING (
		SELECT * FROM OpenQuery([M5DB],
	''select * from Billing.dbo.UfnTNsToBeSynced(''''' + @SyncTime + ''''')'')
	) AS source
	ON target.Id = source.Id and target.CountryId = source.CountryId
	WHEN MATCHED THEN	
		UPDATE SET 
			target.TnTypeId = source.TnTypeId, 
			target.AccountId = source.AccountId, target.LocationId = source.LocationId, target.ProfileId = source.ProfileId, 
			target.Label = source.Label,
			target.TrunkGroupId = source.TrunkGroupId
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, CountryId, TnTypeId, AccountId, LocationId, ProfileId, Label,TrunkGroupId ) 
		VALUES ( Id, CountryId, TnTypeId, AccountId, LocationId, ProfileId, Label,TrunkGroupId )
	OUTPUT ''provision.Tn'', $action INTO SyncChanges;'

	EXEC(@SS);

	-- Duplicate TNs with other CountryId need to be removed from US
	delete from provision.TN
		where CountryId = 840 and id in (
		select Id from provision.TN 
		group by Id
		having count(1) > 1
		)

	-- Materialize the Unique TN view
	truncate table provision.MatVwUniqueTn_base;
	insert into provision.MatVwUniqueTn_base
	select * from provision.VwUniqueTn_base;

	PRINT convert(varchar,getdate(),14) + N': End syncing Tn data';

END

