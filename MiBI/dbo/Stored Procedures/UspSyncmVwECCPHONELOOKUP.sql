
-- ==========================================================================================
-- Author:		Subhash Subramanyam
-- Create date: 12/10/2020
-- Description:	select * from dbo.mVwECCPHONELOOKUP
/* select count(PhoneNumber), count(distinct PhoneNumber) from [dbo].[mVwECCPHONELOOKUP] */
-- Usage: EXEC [dbo].[UspSyncmVwECCPHONELOOKUP]
-- ==========================================================================================
CREATE PROCEDURE [dbo].[UspSyncmVwECCPHONELOOKUP] 
--@lastSync DATETIME = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing dbo.mVwECCPHONELOOKUP ';

	--SELECT @lastSync = MAX(LastModifiedDate) FROM dbo.Location;

	--IF @lastSync IS NULL SET @lastSync = '2000-01-01';
	

		SELECT * INTO #ECCPHONELOOKUP FROM [dbo].[V_ECC_PHONE_LOOKUP];
		ALTER TABLE #ECCPHONELOOKUP ALTER COLUMN PhoneNumber VARCHAR(11) NOT NULL;
		ALTER TABLE #ECCPHONELOOKUP ADD CONSTRAINT PK_ECCPHONELOOKUP PRIMARY KEY CLUSTERED(PhoneNumber);
		--SELECT COUNT(PhoneNumber), COUNT(DISTINCT PhoneNumber) FROM #ECCPHONELOOKUP;

		IF EXISTS(SELECT TOP 1 1 FROM #ECCPHONELOOKUP)
		BEGIN
			INSERT INTO [dbo].[mVwECCPHONELOOKUP] (
				PhoneNumber	
				,CustomerType	
				,Platform
				,Instance
				)
			SELECT source.PhoneNumber	
				,source.CustomerType	
				,source.Platform
				,source.Instance
			FROM #ECCPHONELOOKUP source
			WHERE NOT EXISTS(SELECT 1 FROM [dbo].[mVwECCPHONELOOKUP] target WHERE source.PhoneNumber = target.PhoneNumber) 
				--AND target.PhoneNumber IS NULL
			
			UPDATE target
				SET CustomerType = source.CustomerType
					,Platform = source.Platform
					,Instance = source.Instance
			FROM [dbo].[mVwECCPHONELOOKUP] target
			INNER JOIN #ECCPHONELOOKUP source ON source.PhoneNumber = target.PhoneNumber
		END

		DROP TABLE #ECCPHONELOOKUP;
		
	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing dbo.mVwECCPHONELOOKUP data';
END
