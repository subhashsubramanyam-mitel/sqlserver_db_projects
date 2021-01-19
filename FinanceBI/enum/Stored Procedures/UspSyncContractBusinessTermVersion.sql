
-- =======================================================================================================================================
-- Author:		Subhash Subramanyam
-- Create date: 2020-07-09
-- Description:	Sync Contract Business Term Version data
-- Change Log:  EXEC [enum].[UspSyncContractBusinessTermVersion] 
-- Modified Date	Author					Desc
-- 2020-07-09		Subhash Subramanyam		Created Initial Version
-- =======================================================================================================================================
CREATE PROCEDURE [enum].[UspSyncContractBusinessTermVersion]
	-- Add the parameters for the stored procedure here
	-- @lastSync DATETIME = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing Contract Business Term Version data';

	MERGE enum.ContractBusinessTermVersion AS target
	USING (
		SELECT [Id]
			,[Name]
			,[MinDownturnPct]
			,[MaxDownturnPct]
			,[ServiceCommitmentDateMaxAddMonths]
			,[IsAutoProvisioned]
		FROM [m5db].[m5db].[dbo].[AccountContractBusinessTermVersion] WITH (NOLOCK)
		) AS source
		ON target.Id = source.Id
	WHEN MATCHED
		AND (
			target.[Name] <> source.[Name]
			OR target.[MinDownturnPct] <> source.[MinDownturnPct]
			OR target.[MaxDownturnPct] <> source.[MaxDownturnPct]
			OR coalesce(target.[ServiceCommitmentDateMaxAddMonths], - 1) <> coalesce(source.[ServiceCommitmentDateMaxAddMonths], - 1)
			OR target.[IsAutoProvisioned] <> source.[IsAutoProvisioned]
			)
		THEN
			UPDATE
			SET target.[Name] = source.[Name]
				,target.[MinDownturnPct] = source.[MinDownturnPct]
				,target.[MaxDownturnPct] = source.[MaxDownturnPct]
				,target.[ServiceCommitmentDateMaxAddMonths] = source.[ServiceCommitmentDateMaxAddMonths]
				,target.[IsAutoProvisioned] = source.[IsAutoProvisioned]
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				[Id]
				,[Name]
				,[MinDownturnPct]
				,[MaxDownturnPct]
				,[ServiceCommitmentDateMaxAddMonths]
				,[IsAutoProvisioned]
				)
			VALUES (
				[Id]
				,[Name]
				,[MinDownturnPct]
				,[MaxDownturnPct]
				,[ServiceCommitmentDateMaxAddMonths]
				,[IsAutoProvisioned]
				)
	OUTPUT 'enum.ContractBusinessTermVersion'
		,$ACTION
	INTO SyncChanges;

	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing Contract Business Term Version data';
END