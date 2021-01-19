



-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2015-11-24
-- Description:	Sync Sales Contract 
-- Change Log:  
--      2019-07-23 added three attributes 	 SalesForceId  ,PlatformTypeId ,DateSigned 
-- =============================================
CREATE PROCEDURE [sales].[UspSyncContract] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Sales Contract  data';

	MERGE sales.Contract as target
	USING (
		SELECT 
		[Id]
      ,[ContractNumber]
      ,[Name]
      ,[ContractTypeId]
      ,[ContractStatusId]
      ,[AccountId]
      ,[DateContractWon]
      ,[ContractLength]
      ,[ContractSpecialTerms]
      ,[SalesPersonId]
      ,[LichenQuoteId]
      ,[DateCreatedOriginal]
      ,[CreatedByPersonId]
      ,[DateModifiedOriginal]
      ,[ModifiedByPersonId]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
      ,[ContractFileName]
      ,[ContractFilePath]
      ,[ProjectManagerId]
      ,[ContractGoLive]
      ,[ClientProgrammerId]
      ,[DataEngineerId]
      ,[BillingLocationId]
      ,[AccountManagerId]
      ,[ContractSignedPersonId]
      ,[BusinessTermVersion]
      ,[RenewAutomatically]
      ,NULL AS [InstallTermUOM]
      ,NULL AS [InstallTermQuantity]
      ,[DownturnPercentage]
      ,[ProfileAmount]
	  ,SalesForceId  
	  ,PlatformTypeId 
	  ,DateSigned 
	  ,CommitmentDate
		FROM 
			M5DB.M5DB.Dbo.Sales_Contract SC with(nolock)
		WHERE
			(SC.DateModified >= DateAdd(day, -1, @lastSync) ) -- 1 day safety window
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.[ContractNumber] = source.[ContractNumber] , 
			target.[Name] = source.[Name] , 
			target.[ContractTypeId] = source.[ContractTypeId] , 
			target.[ContractStatusId] = source.[ContractStatusId] , 
			target.[AccountId] = source.[AccountId] , 
			target.[DateContractWon] = source.[DateContractWon] , 
			target.[ContractLength] = source.[ContractLength] , 
			target.[ContractSpecialTerms] = source.[ContractSpecialTerms] , 
			target.[SalesPersonId] = source.[SalesPersonId] , 
			target.[LichenQuoteId] = source.[LichenQuoteId] , 
			target.[DateCreatedOriginal] = source.[DateCreatedOriginal] , 
			target.[CreatedByPersonId] = source.[CreatedByPersonId] , 
			target.[DateModifiedOriginal] = source.[DateModifiedOriginal] , 
			target.[ModifiedByPersonId] = source.[ModifiedByPersonId] , 
			target.[DateModified] = source.[DateModified] , 
			target.[DateCreated] = source.[DateCreated] , 
			target.[ModifiedBy] = source.[ModifiedBy] , 
			target.[ContractFileName] = source.[ContractFileName] , 
			target.[ContractFilePath] = source.[ContractFilePath] , 
			target.[ProjectManagerId] = source.[ProjectManagerId] , 
			target.[ContractGoLive] = source.[ContractGoLive] , 
			target.[ClientProgrammerId] = source.[ClientProgrammerId] , 
			target.[DataEngineerId] = source.[DataEngineerId] , 
			target.[BillingLocationId] = source.[BillingLocationId] , 
			target.[AccountManagerId] = source.[AccountManagerId] , 
			target.[ContractSignedPersonId] = source.[ContractSignedPersonId] , 
			target.[BusinessTermVersion] = source.[BusinessTermVersion] , 
			target.[RenewAutomatically] = source.[RenewAutomatically] , 
			target.[InstallTermUOM] = source.[InstallTermUOM] , 
			target.[InstallTermQuantity] = source.[InstallTermQuantity] , 
			target.[DownturnPercentage] = source.[DownturnPercentage] , 
			target.[ProfileAmount] = source.[ProfileAmount] 
		  ,target.SalesForceId   = source.SalesForceId
		  ,target.PlatformTypeId  = source.PlatformTypeId
		  ,target.DateSigned  = source.DateSigned
		  ,target.CommitmentDate = source.CommitmentDate

	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( 			
		[Id]
      ,[ContractNumber]
      ,[Name]
      ,[ContractTypeId]
      ,[ContractStatusId]
      ,[AccountId]
      ,[DateContractWon]
      ,[ContractLength]
      ,[ContractSpecialTerms]
      ,[SalesPersonId]
      ,[LichenQuoteId]
      ,[DateCreatedOriginal]
      ,[CreatedByPersonId]
      ,[DateModifiedOriginal]
      ,[ModifiedByPersonId]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
      ,[ContractFileName]
      ,[ContractFilePath]
      ,[ProjectManagerId]
      ,[ContractGoLive]
      ,[ClientProgrammerId]
      ,[DataEngineerId]
      ,[BillingLocationId]
      ,[AccountManagerId]
      ,[ContractSignedPersonId]
      ,[BusinessTermVersion]
      ,[RenewAutomatically]
      ,[InstallTermUOM]
      ,[InstallTermQuantity]
      ,[DownturnPercentage]
      ,[ProfileAmount] 
	  ,SalesForceId  
	  ,PlatformTypeId 
	  ,DateSigned 
	  ,CommitmentDate
			 ) 
		VALUES ( 			
		[Id]
      ,[ContractNumber]
      ,[Name]
      ,[ContractTypeId]
      ,[ContractStatusId]
      ,[AccountId]
      ,[DateContractWon]
      ,[ContractLength]
      ,[ContractSpecialTerms]
      ,[SalesPersonId]
      ,[LichenQuoteId]
      ,[DateCreatedOriginal]
      ,[CreatedByPersonId]
      ,[DateModifiedOriginal]
      ,[ModifiedByPersonId]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
      ,[ContractFileName]
      ,[ContractFilePath]
      ,[ProjectManagerId]
      ,[ContractGoLive]
      ,[ClientProgrammerId]
      ,[DataEngineerId]
      ,[BillingLocationId]
      ,[AccountManagerId]
      ,[ContractSignedPersonId]
      ,[BusinessTermVersion]
      ,[RenewAutomatically]
      ,[InstallTermUOM]
      ,[InstallTermQuantity]
      ,[DownturnPercentage]
      ,[ProfileAmount] 
	  ,SalesForceId  
	  ,PlatformTypeId 
	  ,DateSigned 
	  ,CommitmentDate
			 ) 
	OUTPUT 'sales.Contract', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing Sales Contract  data';


END



