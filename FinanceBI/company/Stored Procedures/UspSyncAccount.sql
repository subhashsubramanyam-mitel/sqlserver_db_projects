-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-25
-- Description:	Sync Account data
-- Change Log: Added DeployEnvId
-- =============================================
CREATE PROCEDURE [company].[UspSyncAccount] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing account data';

	MERGE company.Account as target
	USING (
		SELECT
			A.Id,
			CASE WHEN (C.Name is null or C.Name = '') THEN 'Unspecified' ELSE C.Name END Name,
			A.AccountNumber as [Number],
			A.AccountTypeId AS CompanyTypeId,
			C.CompanySalesChannelId,
			coalesce(A.AccountCategoryId,1) AccountCategoryId,
			coalesce(A.AccountSubCategoryId,1) AccountSubCategoryId,
			ACL.ClusterId as [PrimaryClusterId],-- Note that some accounts don't have a cluster yet (ie Prospects)
			COALESCE(LEFT(PAR.OutDialDigit,1),'9') AS [OutDialDigit],

            -- Following line commented and replaced by succeeding line on 2013-11-14
			-- CASE A.AccountStatusId WHEN 0 THEN 1 ELSE 0 END AS IsActive,
			CASE WHEN A.AccountStatusId IN (0,3) THEN 1 ELSE 0 END AS IsActive,   -- 0: Active; 3: Pending

			A.ParentAccountId AS ParentAccountId,
			A.LichenAccountId as LichenAccountId,
			A.PartnerId as PartnerId,
			CASE WHEN ACL.ClusterId =64 THEN 1 Else  0 End as IsHybrid --> Tarak 5/27, align with new Boss release
			, CASE 
				WHEN ACL.ClusterId = 64 then 2  -- Hybrid
				WHEN ACL.PlatformTypeId in  (1,2) then 1 -- Legacy (Call Conductor, Genband)
				WHEN ACL.PlatformTypeId in (3) Then 3 -- COSMO
				ELSE null  END as DeployEnvId,
			A.NativeOid
		FROM 
			M5DB.M5DB.Dbo.Account A with(nolock)
			inner join M5DB.M5DB.Dbo.Company C with(nolock) on A.CompanyId = C.Id
			left outer join (
				select Accountid, ClusterId, ACL.DateModified,C.PlatformTypeId,
					row_number() over 
						(partition by AccountId order by ACL.PrimaryCluster DESC, ACL.Id Desc) RankNum
				from	M5DB.M5DB.Dbo.AccountCluster ACL with(nolock)
				inner join M5DB.M5DB.dbo.Cluster C on C.Id = ACL.ClusterId
				where C.PlatformTypeId in (1,2,11) -- Call Conductor, Genband, COSMO
				--where ACL.PrimaryCluster = 1  move this to order criteria
				) ACL on ACL.AccountId = A.Id and ACL.RankNum = 1
			left outer join (
				select AccountId, ClusterId, MAX(COALESCE(LEFT(OutDialDigit,1),'9')) AS OutDialDigit
				from M5DB.M5DB.Dbo.Partition with(nolock)
				where PrimaryCluster = 1
				group by AccountId, ClusterId
			) PAR on PAR.AccountId = A.Id and PAR.ClusterId = ACL.ClusterId
		WHERE
			/*A.AccountTypeId in (1,3) -- Customer, Prospect	
			and ((ACL.ClusterId in (Select ID from enum.Cluster)) -- Do not take accounts not on GB or CC
				or (ACL.ClusterId is NULL))	-- Will be updated when ACL is, but we still want this account
			and */
			((ACL.ClusterId in (Select ID from enum.Cluster)) -- Do not take accounts not on GB or CC
				or (ACL.ClusterId is NULL))	and
				( C.DateModified >= @lastSync or A.DateModified >= @lastSync or ACL.DateModified >= @lastSync )
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET target.Name = source.Name, target.[Number] = source.[Number],
		target.CompanyTypeId = source.CompanyTypeId, target.CompanySalesChannelId = source.CompanySalesChannelId, 
		target.AccountCategoryId = source.AccountCategoryId, target.AccountSubCategoryId = source.AccountSubCategoryId, 
		target.[PrimaryClusterId] = source.[PrimaryClusterId], target.[OutDialDigit] = source.[OutDialDigit],
		target.IsActive = source.IsActive,
		target.ParentAccountId = source.ParentAccountId,
		target.LichenAccountId = source.LichenAccountId,
		target.PartnerId = source.PartnerId,
		target.IsHybrid = source.IsHybrid,
		target.DeployEnvId = source.DeployEnvId,
		target.NativeOid = source.NativeOid
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, Name, [Number], CompanyTypeId, CompanySalesChannelId, AccountCategoryId, 
			AccountSubCategoryId, [PrimaryClusterId], [OutDialDigit], IsActive, ParentAccountId, 
			LichenAccountId, PartnerId, IsHybrid, DeployEnvId, NativeOid ) 
		VALUES ( Id, Name, [Number], CompanyTypeId, CompanySalesChannelId, AccountCategoryId, 
			AccountSubCategoryId, [PrimaryClusterId], [OutDialDigit], IsActive, ParentAccountId, 
			LichenAccountId, PartnerId, IsHybrid, DeployEnvId, NativeOid ) 
	OUTPUT 'DimAccount', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing account data';

END
