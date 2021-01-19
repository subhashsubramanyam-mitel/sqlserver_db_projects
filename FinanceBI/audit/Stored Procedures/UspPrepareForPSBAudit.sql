-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-04-16
-- Description:	Prepare data for Profile Service Billing Audit
-- Change Log : Introduced more robust version of materialized view  creation. 
-- =============================================
CREATE PROCEDURE [audit].[UspPrepareForPSBAudit]
AS
BEGIN

-- Copy
/*
IF OBJECT_ID('audit.mVwTnProfile', 'U') IS NOT NULL
  DROP TABLE audit.mVwTnProfile
select   * into audit.mVwTnProfile
 from M5DB.Billing.dbo.VwTnProfile
 */


 	truncate table audit.mVwTnProfile_Staging; 
	insert into audit.mVwTnProfile_Staging
	select * from M5DB_Prod.Billing.dbo.VwTnProfile;

	BEGIN TRANSACTION
	exec sp_rename 'audit.mVwTnProfile', 'mVwTnProfile_Old';
	exec sp_rename 'audit.mVwTnProfile_Staging', 'mVwTnProfile';
	exec sp_rename 'audit.mVwTnProfile_Old', 'mVwTnProfile_Staging';

	COMMIT
 
insert into audit.mVwTnProfile
( Tn, TnStatus, TnAccountId, TnAccountPrimaryClusterId, IsTnMainNumber, RedirectTn, TrunkGroupId, ProfileId, ProfileTypeId, ProfileType, PartitionId, PartitionClusterId,
                       PartitionAccountId, PartitionAccountPrimaryClusterId)
select 
 'TnNotFound', TnStatus, TnAccountId, TnAccountPrimaryClusterId, IsTnMainNumber, RedirectTn, TrunkGroupId, ProfileId, ProfileTypeId, ProfileType, PartitionId, PartitionClusterId,
                       PartitionAccountId, PartitionAccountPrimaryClusterId
from 
audit.mVwTnProfile
where TN='55555555'

insert into audit.mVwTnProfile
( Tn, TnStatus, TnAccountId, TnAccountPrimaryClusterId, IsTnMainNumber, RedirectTn, TrunkGroupId, ProfileId, ProfileTypeId, ProfileType, PartitionId, PartitionClusterId,
                       PartitionAccountId, PartitionAccountPrimaryClusterId)
select 
 'TnNotLinked', TnStatus, TnAccountId, TnAccountPrimaryClusterId, IsTnMainNumber, RedirectTn, TrunkGroupId, ProfileId, ProfileTypeId, ProfileType, PartitionId, PartitionClusterId,
                       PartitionAccountId, PartitionAccountPrimaryClusterId
from 
audit.mVwTnProfile
where TN='55555555'

/*
IF OBJECT_ID('audit.mVwTnProfileService', 'U') IS NOT NULL
  DROP TABLE audit.mVwTnProfileService

select * 
into audit.mVwTnProfileService
from audit.VwTnProfileService
*/
truncate table audit.mVwTnProfileService_Staging; 
	insert into audit.mVwTnProfileService_Staging
	select * from audit.VwTnProfileService;

	BEGIN TRANSACTION
	exec sp_rename 'audit.mVwTnProfileService', 'mVwTnProfileService_Old';
	exec sp_rename 'audit.mVwTnProfileService_Staging', 'mVwTnProfileService';
	exec sp_rename 'audit.mVwTnProfileService_Old', 'mVwTnProfileService_Staging';

	COMMIT

update audit.mVwTnProfileService set RedirectTn = null where RedirectTN = ''

update audit.mvwTnProfileService set ProfileName = 'James  Eglinton' 
where ProfileName like '%James  Eglinton%' and ProfileName <> 'James  Eglinton'
		and LEN(ProfileName) < LEN('James  Eglinton')+2;
/*
IF OBJECT_ID('audit.mVwLatestService', 'U') IS NOT NULL
  DROP TABLE audit.mVwLatestService

select * 
into audit.mVwLatestService
from oss.VwLatestService
*/
truncate table audit.mVwLatestService_Staging; 
	insert into audit.mVwLatestService_Staging
	select * from oss.VwLatestService;

	BEGIN TRANSACTION
	exec sp_rename 'audit.mVwLatestService', 'mVwLatestService_Old';
	exec sp_rename 'audit.mVwLatestService_Staging', 'mVwLatestService';
	exec sp_rename 'audit.mVwLatestService_Old', 'mVwLatestService_Staging';

	COMMIT

-- Monthly processing of usage summary in separate stored proc


END
