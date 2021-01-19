



-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2019-07-23
-- Description:	Sync Sales Contract Line Item
-- Change Log:  
-- =============================================
CREATE PROCEDURE [sales].[UspSyncContractLineItem] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Sales Contract LineItem  data';

	MERGE sales.ContractLineItem as target
	USING (
		SELECT 
			[Id]
		  ,[ContractId]
		  ,[ProductId]
		  ,[LocationId]
		  ,[MRR]
		  ,[NRR]
		  ,[TrialDuration]
		  ,[ContractQuantity]
		  ,[Quantity]
		  ,[DateCreated]
		  ,[DateModified]
		  ,[ModifiedBy]
		  ,[WaiveNRR]
		
		FROM 
			M5DB.M5DB.Dbo.Sales_ContractLineItem SCL with(nolock)
		WHERE
			(SCL.DateModified >= DateAdd(day, -1, @lastSync) ) -- 1 day safety window
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			  target.[ContractId] = source.[ContractId]
			  ,target.[ProductId] = source.[ProductId]
			  ,target.[LocationId] = source.[LocationId]
			  ,target.[MRR] = source.[MRR]
			  ,target.[NRR] = source.[NRR]
			  ,target.[TrialDuration] = source.[TrialDuration]
			  ,target.[ContractQuantity] = source.[ContractQuantity]
			  ,target.[Quantity] = source.[Quantity]
			  ,target.[DateCreated] = source.[DateCreated]
			  ,target.[DateModified] = source.[DateModified]
			  ,target.[ModifiedBy] = source.[ModifiedBy]
			  ,target.[WaiveNRR] = source.[WaiveNRR]

	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( 			
		[Id]
      ,[ContractId]
      ,[ProductId]
      ,[LocationId]
      ,[MRR]
      ,[NRR]
      ,[TrialDuration]
      ,[ContractQuantity]
      ,[Quantity]
      ,[DateCreated]
      ,[DateModified]
      ,[ModifiedBy]
      ,[WaiveNRR]

			 ) 
		VALUES ( 			
		[Id]
      ,[ContractId]
      ,[ProductId]
      ,[LocationId]
      ,[MRR]
      ,[NRR]
      ,[TrialDuration]
      ,[ContractQuantity]
      ,[Quantity]
      ,[DateCreated]
      ,[DateModified]
      ,[ModifiedBy]
      ,[WaiveNRR]
			 ) 
	OUTPUT 'sales.ContractLineItem', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing Sales Contract LineItem data';


END




