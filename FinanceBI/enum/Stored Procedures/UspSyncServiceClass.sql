-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-01-20
-- Description:	Sync Service Class
-- Change Log:
-- =============================================
create PROCEDURE enum.UspSyncServiceClass 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing ServiceClass data';

	MERGE enum.ServiceClass as target
	USING (
		SELECT 
			SC.Id,
			SC.ParentId,
			SG.Name as ServiceGroup,
			SC.Name,
			SC.LichenClassName,
			SC.RootName,
			SC.DisplaySortOrder
		FROM 
			M5DB.M5DB.dbo.service_ServiceClass SC with(nolock)
			inner join M5DB.M5DB.dbo.service_ServiceGroup SG on SG.Id = SC.ServiceGroupId
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED and (
			coalesce(target.ParentId,-1) <> coalesce(source.ParentId, -1) or
			target.ServiceGroup <> source.ServiceGroup or
			target.Name <> source.Name or
			target.LichenClassName <> source.LichenClassName or
			target.RootName <> source.RootName or
			target.DisplaySortOrder <> source.DisplaySortOrder
			)
		THEN	
		UPDATE SET 
			target.ParentId = source.ParentId,
			target.ServiceGroup = source.ServiceGroup,
			target.Name = source.Name,
			target.LichenClassName = source.LichenClassName,
			target.RootName = source.RootName,
			target.DisplaySortOrder = source.DisplaySortOrder

	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, ParentId, ServiceGroup, Name, LichenClassName, RootName, DisplaySortOrder )
		VALUES ( Id, ParentId, ServiceGroup, Name, LichenClassName, RootName, DisplaySortOrder ) 
	OUTPUT 'enum.ServiceClass', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing ServiceClass data';

END
