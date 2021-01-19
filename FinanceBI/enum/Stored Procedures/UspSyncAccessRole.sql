-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-11-20
-- Description:	Sync Role data
-- Change Log:
-- =============================================
create PROCEDURE enum.UspSyncAccessRole 
	-- Add the parameters for the stored procedure here
	@lastSyncUTC datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Access Role data';

	INSERT INTO enum.AccessRole
	SELECT 
		R.ID, R.Name
	FROM M5DB.M5DB.dbo.access_Role R
	left join enum.AccessRole AR on AR.Id = R.Id
	where AR.Id is null

	PRINT convert(varchar,getdate(),14) + N': End syncing Access Role data';

END
