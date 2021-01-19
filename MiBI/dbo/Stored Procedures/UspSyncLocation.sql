
-- =============================================
-- Author:		Subhash Subramanyam
-- Create date: 11/10/2020
-- Description:	select count(*) from dbo.Location where [Date_Set_Active__c] IS NOT NULL
-- Usage: EXEC [dbo].[UspSyncLocation]
-- =============================================
CREATE PROCEDURE [dbo].[UspSyncLocation] @lastSync DATETIME = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing location data';
	
	--DECLARE @lastSync DATETIME
	SELECT @lastSync = MAX(LastModifiedDate) FROM dbo.Location;

	IF @lastSync IS NULL 
	SET @lastSync = '2000-01-01';
	
	WITH source AS
	 (
		SELECT [Account_c]
			,[Active_Seats_c]
			,[boss_Abbrev_c]
			,[boss_City_c]
			,[boss_Country_c]
			,[boss_Demarcation_Point_c]
			,CAST(REPLACE(REPLACE([boss_ForecastDate_c], 'T', ' '), 'Z', '') AS DATETIME) AS [boss_ForecastDate_c]
			,[boss_LATA_c]
			,[boss_location_id_c]
			,[boss_Location_Live_c]
			,[boss_NPA_c]
			,[boss_NXX_c]
			,[boss_State_c]
			,[boss_Status_c]
			,[boss_Subtenant_c]
			,[boss_Zip_Code_c]
			,[ConnectionReceivedId]
			,[ConnectionSentId]
			,CAST(REPLACE(REPLACE([Contract_Commitment_Date_c], 'T', ' '), 'Z', '') AS DATETIME) AS [Contract_Commitment_Date_c]
			,[CreatedById]
			,CAST(REPLACE(REPLACE(CreatedDate, 'T', ' '), 'Z', '') AS DATETIME) AS CreatedDate
			,[CurrencyIsoCode]
			,CAST(REPLACE(REPLACE([Date_Set_Active_c], 'T', ' '), 'Z', '') AS DATETIME) AS [Date_Set_Active_c]
			,[Id]
			,[Installation_Type_c]
			,[IsDeleted]
			,[Is_CX_c]
			,[Is_ECC_SCC_c]
			,[Is_Hybrid_c]
			,[Is_Migration_c]
			,[Is_Mitel_Circuit_c]
			,[Is_MPLS_c]
			,CAST(REPLACE(REPLACE([LastActivityDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastActivityDate]
			,[LastModifiedById]
			,CAST(REPLACE(REPLACE([LastModifiedDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastModifiedDate]
			,CAST(REPLACE(REPLACE([LastReferencedDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastReferencedDate]
			,CAST(REPLACE(REPLACE([LastViewedDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastViewedDate]
			,[Number_of_Locations_c]
			,[Opportunity_c]
			,[OwnerId]
		FROM [orangestaging].[Location]
		WHERE CAST(REPLACE(REPLACE(CreatedDate, 'T', ' '), 'Z', '') AS DATETIME) >= @lastSync
		) 
	
			UPDATE target
			SET [Account__c] = source.[Account_c]
				,[Active_Seats__c] = source.[Active_Seats_c]
				,[boss_Abbrev__c] = source.[boss_Abbrev_c]
				,[boss_City__c] = source.[boss_City_c]
				,[boss_Country__c] = source.[boss_Country_c]
				,[boss_Demarcation_Point__c] = source.[boss_Demarcation_Point_c]
				,[boss_ForecastDate__c] = source.[boss_ForecastDate_c]
				,[boss_LATA__c] = source.[boss_LATA_c]
				,[boss_location_id__c] = source.[boss_location_id_c]
				,[boss_Location_Live__c] = source.[boss_Location_Live_c]
				,[boss_NPA__c] = source.[boss_NPA_c]
				,[boss_NXX__c] = source.[boss_NXX_c]
				,[boss_State__c] = source.[boss_State_c]
				,[boss_Status__c] = source.[boss_Status_c]
				,[boss_Subtenant__c] = source.[boss_Subtenant_c]
				,[boss_Zip_Code__c] = source.[boss_Zip_Code_c]
				,[ConnectionReceivedId] = source.[ConnectionReceivedId]
				,[ConnectionSentId] = source.[ConnectionSentId]
				,[Contract_Commitment_Date__c] = source.[Contract_Commitment_Date_c]
				,[CreatedById] = source.[CreatedById]
				,[CreatedDate] = source.[CreatedDate]
				,[CurrencyIsoCode] = source.[CurrencyIsoCode]
				,[Date_Set_Active__c] = source.[Date_Set_Active_c]
				,[Installation_Type__c] = source.[Installation_Type_c]
				,[IsDeleted] = source.[IsDeleted]
				,[Is_CX__c] = source.[Is_CX_c]
				,[Is_ECC_SCC__c] = source.[Is_ECC_SCC_c]
				,[Is_Hybrid__c] = source.[Is_Hybrid_c]
				,[Is_Migration__c] = source.[Is_Migration_c]
				,[Is_Mitel_Circuit__c] = source.[Is_Mitel_Circuit_c]
				,[Is_MPLS__c] = source.[Is_MPLS_c]
				,[LastActivityDate] = source.[LastActivityDate]
				,[LastModifiedById] = source.[LastModifiedById]
				,[LastModifiedDate] = source.[LastModifiedDate]
				,[LastReferencedDate] = source.[LastReferencedDate]
				,[LastViewedDate] = source.[LastViewedDate]
				,[Number_of_Locations__c] = source.[Number_of_Locations_c]
				,[Opportunity__c] = source.[Opportunity_c]
				,[OwnerId] = source.[OwnerId]
		FROM dbo.Location target
		INNER JOIN source ON source.Id = target.Id
	
	
	INSERT INTO dbo.Location (
				[Account__c]
				,[Active_Seats__c]
				,[boss_Abbrev__c]
				,[boss_City__c]
				,[boss_Country__c]
				,[boss_Demarcation_Point__c]
				,[boss_ForecastDate__c]
				,[boss_LATA__c]
				,[boss_location_id__c]
				,[boss_Location_Live__c]
				,[boss_NPA__c]
				,[boss_NXX__c]
				,[boss_State__c]
				,[boss_Status__c]
				,[boss_Subtenant__c]
				,[boss_Zip_Code__c]
				,[ConnectionReceivedId]
				,[ConnectionSentId]
				,[Contract_Commitment_Date__c]
				,[CreatedById]
				,[CreatedDate]
				,[CurrencyIsoCode]
				,[Date_Set_Active__c]
				,[Id]
				,[Installation_Type__c]
				,[IsDeleted]
				,[Is_CX__c]
				,[Is_ECC_SCC__c]
				,[Is_Hybrid__c]
				,[Is_Migration__c]
				,[Is_Mitel_Circuit__c]
				,[Is_MPLS__c]
				,[LastActivityDate]
				,[LastModifiedById]
				,[LastModifiedDate]
				,[LastReferencedDate]
				,[LastViewedDate]
				,[Number_of_Locations__c]
				,[Opportunity__c]
				,[OwnerId]
				)
			SELECT source.[Account_c]
			,source.[Active_Seats_c]
			,source.[boss_Abbrev_c]
			,source.[boss_City_c]
			,source.[boss_Country_c]
			,source.[boss_Demarcation_Point_c]
			,CAST(REPLACE(REPLACE(source.[boss_ForecastDate_c], 'T', ' '), 'Z', '') AS DATETIME) AS [boss_ForecastDate_c]
			,source.[boss_LATA_c]
			,source.[boss_location_id_c]
			,source.[boss_Location_Live_c]
			,source.[boss_NPA_c]
			,source.[boss_NXX_c]
			,source.[boss_State_c]
			,source.[boss_Status_c]
			,source.[boss_Subtenant_c]
			,source.[boss_Zip_Code_c]
			,source.[ConnectionReceivedId]
			,source.[ConnectionSentId]
			,CAST(REPLACE(REPLACE(source.[Contract_Commitment_Date_c], 'T', ' '), 'Z', '') AS DATETIME) AS [Contract_Commitment_Date_c]
			,source.[CreatedById]
			,CAST(REPLACE(REPLACE(source.CreatedDate, 'T', ' '), 'Z', '') AS DATETIME) AS CreatedDate
			,source.[CurrencyIsoCode]
			,CAST(REPLACE(REPLACE(source.[Date_Set_Active_c], 'T', ' '), 'Z', '') AS DATETIME) AS [Date_Set_Active_c]
			,source.[Id]
			,source.[Installation_Type_c]
			,source.[IsDeleted]
			,source.[Is_CX_c]
			,source.[Is_ECC_SCC_c]
			,source.[Is_Hybrid_c]
			,source.[Is_Migration_c]
			,source.[Is_Mitel_Circuit_c]
			,source.[Is_MPLS_c]
			,CAST(REPLACE(REPLACE(source.[LastActivityDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastActivityDate]
			,source.[LastModifiedById]
			,CAST(REPLACE(REPLACE(source.[LastModifiedDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastModifiedDate]
			,CAST(REPLACE(REPLACE(source.[LastReferencedDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastReferencedDate]
			,CAST(REPLACE(REPLACE(source.[LastViewedDate], 'T', ' '), 'Z', '') AS DATETIME) AS [LastViewedDate]
			,source.[Number_of_Locations_c]
			,source.[Opportunity_c]
			,source.[OwnerId]
		FROM [orangestaging].[Location] source
		LEFT JOIN dbo.Location target ON source.Id = target.Id
		WHERE CAST(REPLACE(REPLACE(source.CreatedDate, 'T', ' '), 'Z', '') AS DATETIME) >= @lastSync
		AND target.Id IS NULL ;

	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing location data';
END
