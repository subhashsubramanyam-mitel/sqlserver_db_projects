


-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2015-11-24
-- Description:	Sync ContractHeader and ContractDetail data
-- Change Log: Feb 24, 2016, IsActive field appears to have been dropped in Contract Details. Assuming 1. 
-- =============================================
CREATE PROCEDURE [company].[UspSyncAccountContract] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Account Contract Term Header data';

	MERGE company.ContractTermHeader as target
	USING (
		SELECT 
			[Id]
		  ,[AccountId]
		  ,NULL AS [InitialCreationDate]
		  ,NULL AS [InstallTermUOM]
		  ,NULL AS [InstallTermQuantity]
		  ,NULL AS [InstallEnforcementDate]
		  ,[LastInvoiceDate]
		  ,[LastInvoiceMRR]
		  ,[EarlyTerminationFee]
		  ,[DateCreated]
		  ,[DateModified]
		  ,[ModifiedBy]
		FROM 
			M5DB.M5DB.Dbo.AccountContractTermHeader CTH with(nolock)
		WHERE
			(CTH.DateModified >= DateAdd(day, -1, @lastSync) ) -- 1 day safety window
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.[AccountId] = source.[AccountId], 
			target.[InitialCreationDate] = source.[InitialCreationDate], 
			target.[InstallTermUOM] = source.[InstallTermUOM], 
			target.[InstallTermQuantity] = source.[InstallTermQuantity], 
			target.[InstallEnforcementDate] = source.[InstallEnforcementDate], 
			target.[LastInvoiceDate] = source.[LastInvoiceDate], 
			target.[LastInvoiceMRR] = source.[LastInvoiceMRR], 
			target.[EarlyTerminationFee] = source.[EarlyTerminationFee], 
			target.[DateCreated] = source.[DateCreated], 
			target.[DateModified] = source.[DateModified], 
			target.[ModifiedBy] = source.[ModifiedBy] 

	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( 			
				[Id]
			  ,[AccountId]
			  ,[InitialCreationDate]
			  ,[InstallTermUOM]
			  ,[InstallTermQuantity]
			  ,[InstallEnforcementDate]
			  ,[LastInvoiceDate]
			  ,[LastInvoiceMRR]
			  ,[EarlyTerminationFee]
			  ,[DateCreated]
			  ,[DateModified]
			  ,[ModifiedBy]  
			 ) 
		VALUES ( 			
			[Id]
			  ,[AccountId]
			  ,[InitialCreationDate]
			  ,[InstallTermUOM]
			  ,[InstallTermQuantity]
			  ,[InstallEnforcementDate]
			  ,[LastInvoiceDate]
			  ,[LastInvoiceMRR]
			  ,[EarlyTerminationFee]
			  ,[DateCreated]
			  ,[DateModified]
			  ,[ModifiedBy]  
			 ) 
	OUTPUT 'company.ContractTermHeader', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing Account Contract Term Header data';

	-- CONTRACT term details

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Account Contract Term Details data';

	MERGE company.ContractTermDetail as target
	USING (
		SELECT 
			[Id]
		  ,[AccountContractHeaderId]
		  ,[SalesForceContractId]
		  ,[ContractTypeId]
		  ,[TermMonths]
		  ,[StartDate]
		  ,[EndDate]
		  ,[ProfileAmount]
		  ,[DownturnPercentage]
		  ,[ProfileLimit]
		  ,[MRR]
		  ,[RenewAutomatically]
		  ,[BusinessTermVersion]
		  ,[SalesContractId]
		  ,1 [IsActive]
		  ,[DateCreated]
		  ,[DateModified]
		  ,[ModifiedBy]
		  ,[IsDeleted]
		FROM 
			M5DB.M5DB.Dbo.AccountContractTermDetail CTH with(nolock)
		WHERE
			(( CTH.DateModified >= DateAdd(day, -1, @lastSync) AND @lastsync IS NOT NULL)
			OR
			@lastsync IS NULL) -- 1 day safety window
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.[AccountContractHeaderId] = source.[AccountContractHeaderId], 
			target.[SalesForceContractId] = source.[SalesForceContractId], 
			target.[ContractTypeId] = source.[ContractTypeId], 
			target.[TermMonths] = source.[TermMonths], 
			target.[StartDate] = source.[StartDate], 
			target.[EndDate] = source.[EndDate], 
			target.[ProfileAmount] = source.[ProfileAmount], 
			target.[DownturnPercentage] = source.[DownturnPercentage], 
			target.[ProfileLimit] = source.[ProfileLimit], 
			target.[MRR] = source.[MRR], 
			target.[RenewAutomatically] = source.[RenewAutomatically], 
			target.[BusinessTermVersion] = source.[BusinessTermVersion], 
			target.[SalesContractId] = source.[SalesContractId], 
			target.[IsActive] = source.[IsActive], 
			target.[DateCreated] = source.[DateCreated], 
			target.[DateModified] = source.[DateModified],
			target.[ModifiedBy] = source.[ModifiedBy],
			target.[IsDeleted] = source.[IsDeleted]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( 			
			[Id]
      ,[AccountContractHeaderId]
      ,[SalesForceContractId]
      ,[ContractTypeId]
      ,[TermMonths]
      ,[StartDate]
      ,[EndDate]
      ,[ProfileAmount]
      ,[DownturnPercentage]
      ,[ProfileLimit]
      ,[MRR]
      ,[RenewAutomatically]
      ,[BusinessTermVersion]
      ,[SalesContractId]
      ,[IsActive]
      ,[DateCreated]
      ,[DateModified]
      ,[ModifiedBy]
	  ,[IsDeleted]
	  ) 
		VALUES ( 			
				[Id]
		  ,[AccountContractHeaderId]
		  ,[SalesForceContractId]
		  ,[ContractTypeId]
		  ,[TermMonths]
		  ,[StartDate]
		  ,[EndDate]
		  ,[ProfileAmount]
		  ,[DownturnPercentage]
		  ,[ProfileLimit]
		  ,[MRR]
		  ,[RenewAutomatically]
		  ,[BusinessTermVersion]
		  ,[SalesContractId]
		  ,[IsActive]
		  ,[DateCreated]
		  ,[DateModified]
		  ,[ModifiedBy]
		  ,[IsDeleted]
		  ) 
	OUTPUT 'company.ContractTermDetail', $action INTO SyncChanges;

	UPDATE ctd
	SET IsDeleted = 1
	FROM company.ContractTermDetail ctd
	LEFT JOIN M5DB.M5DB.Dbo.AccountContractTermDetail actd ON ctd.Id = actd.Id
	WHERE actd.Id IS NULL;

	PRINT convert(varchar,getdate(),14) + N': End syncing Account Contract Term Detail data';

END

