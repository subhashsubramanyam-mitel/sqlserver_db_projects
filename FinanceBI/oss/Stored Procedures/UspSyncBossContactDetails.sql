/***************************************************************************************************
Procedure:          [oss].[UspSyncBossContactDetails]
Create Date:        2020-12-09
Author:             Subhash Subramanyam
Description:        Loads BOSS Phone number and others Details:
                    1. Unique list of Phone numbers per region get synchronized to [oss].[BossContactDetails]
					2. Duplicated list of Phone numbers per region get synchronized to [oss].[BossContactDetailsDup]
Call by:            [schema.usp_ProcThatCallsThis]
                    [Application Name]
                    [Job]
                    [PLC/Interface]
Affected table(s):  [oss].[BossContactDetails]
                    [oss].[BossContactDetailsDup]
Used By:            Functional Area this is use in, for example, Payroll, Accounting, Finance
Parameter(s):       <No Parameters>
Usage:              EXEC [oss].[UspSyncBossContactDetails]
                       
                    Additional notes or caveats about this object, like where is can and cannot be run, or
                    gotchas to watch for when using it.
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author					Comments
------------------- -------------------		------------------------------------------------------------
2020-12-09          Subhash Subramanyam		Initial Draft
2021-01-20          Place Holder			General formatting and added header information.
2021-02-20          Place Holder			Added logic to automatically Move G <-> H after 12 months.
***************************************************************************************************/

CREATE PROCEDURE [oss].[UspSyncBossContactDetails]
AS
BEGIN

	SET NOCOUNT ON;
	-- select Region, count(*) from [oss].[BossContactDetails] group by Region
	-- select Region, count(*) from [oss].[BossContactDetailsDup] group by Region

	MERGE [oss].[BossContactDetails] tgt
	USING [oss].[VwBossNAContactDetails] src
		ON tgt.Region = src.Region
			AND tgt.TN = src.TN
	WHEN MATCHED
		AND (
			src.[Customer Name] <> tgt.[Customer Name]
			OR src.[Platform] <> tgt.[Platform]
			OR ISNULL(src.[Account Team], '') <> ISNULL(tgt.[Account Team], '')
			OR ISNULL(src.[Instance], '') <> ISNULL(tgt.[Instance], '')
			)
		THEN
			UPDATE
			SET [Customer Name] = src.[Customer Name]
				,[Platform] = src.[Platform]
				,[Account Team] = src.[Account Team]
				,Instance = src.Instance
	WHEN NOT MATCHED
		THEN
			INSERT (
				Region
				,TN
				,[Customer Name]
				,[Platform]
				,[Account Team]
				,Instance
				)
			VALUES (
				src.Region
				,src.TN
				,src.[Customer Name]
				,src.[Platform]
				,src.[Account Team]
				,src.Instance
				);

	MERGE [oss].[BossContactDetails] tgt
	USING [AU_FinanceBI].FinanceBI.[oss].[VwBossAUContactDetails] src
		ON tgt.Region = src.Region
			AND tgt.TN = src.TN
	WHEN MATCHED
		AND (
			src.[Customer Name] <> tgt.[Customer Name]
			OR src.[Platform] <> tgt.[Platform]
			OR ISNULL(src.[Account Team], '') <> ISNULL(tgt.[Account Team], '')
			OR ISNULL(src.[Instance], '') <> ISNULL(tgt.[Instance], '')
			)
		THEN
			UPDATE
			SET [Customer Name] = src.[Customer Name]
				,[Platform] = src.[Platform]
				,[Account Team] = src.[Account Team]
				,Instance = src.Instance
	WHEN NOT MATCHED
		THEN
			INSERT (
				Region
				,TN
				,[Customer Name]
				,[Platform]
				,[Account Team]
				,Instance
				)
			VALUES (
				src.Region
				,src.TN
				,src.[Customer Name]
				,src.[Platform]
				,src.[Account Team]
				,src.Instance
				);

	MERGE [oss].[BossContactDetails] tgt
	USING [EU_FinanceBI].FinanceBI.[oss].[VwBossEUContactDetails] src
		ON tgt.Region = src.Region
			AND tgt.TN = src.TN
	WHEN MATCHED
		AND (
			src.[Customer Name] <> tgt.[Customer Name]
			OR src.[Platform] <> tgt.[Platform]
			OR ISNULL(src.[Account Team], '') <> ISNULL(tgt.[Account Team], '')
			OR ISNULL(src.[Instance], '') <> ISNULL(tgt.[Instance], '')
			)
		THEN
			UPDATE
			SET [Customer Name] = src.[Customer Name]
				,[Platform] = src.[Platform]
				,[Account Team] = src.[Account Team]
				,Instance = src.Instance
	WHEN NOT MATCHED
		THEN
			INSERT (
				Region
				,TN
				,[Customer Name]
				,[Platform]
				,[Account Team]
				,Instance
				)
			VALUES (
				src.Region
				,src.TN
				,src.[Customer Name]
				,src.[Platform]
				,src.[Account Team]
				,src.Instance
				);
				

			MERGE [oss].[BossContactDetails] tgt
			USING (
				SELECT 'NA' AS Region
					,[PhoneNumber] COLLATE DATABASE_DEFAULT AS TN
					,NULL AS [Customer Name]
					,[Platform] COLLATE DATABASE_DEFAULT AS [Platform]
					,NULL AS [Account Team]
					,[Instance]
				FROM [$(MiBI)].[dbo].[mVwECCPHONELOOKUP]
				WHERE CustomerType = 'MiCloud Flex'
				) src
				ON tgt.Region = src.Region
					AND tgt.TN COLLATE DATABASE_DEFAULT = src.TN COLLATE DATABASE_DEFAULT
			WHEN NOT MATCHED
				THEN
					INSERT (
						Region
						,TN
						,[Customer Name]
						,[Platform]
						,[Account Team]
						,Instance
						)
					VALUES (
						src.Region
						,src.TN
						,src.[Customer Name]
						,src.[Platform]
						,src.[Account Team]
						,src.[Instance]
						);


		SELECT * INTO #BossContactDetailsDupNA
		FROM [oss].[VwBossNAContactDetailsDup]

		IF EXISTS(SELECT TOP 1 1 FROM #BossContactDetailsDupNA)
		BEGIN
			DELETE FROM [oss].[BossContactDetailsDup] WHERE Region = 'NA'

			INSERT INTO [oss].[BossContactDetailsDup]
			SELECT * FROM #BossContactDetailsDupNA
		END

		DROP TABLE #BossContactDetailsDupNA

		SELECT * INTO #BossContactDetailsDupAU
		FROM [AU_FinanceBI].FinanceBI.[oss].[VwBossAUContactDetailsDup]

		IF EXISTS(SELECT TOP 1 1 FROM #BossContactDetailsDupAU)
		BEGIN
			DELETE FROM [oss].[BossContactDetailsDup] WHERE Region = 'AU'

			INSERT INTO [oss].[BossContactDetailsDup]
			SELECT * FROM #BossContactDetailsDupAU
		END

		DROP TABLE #BossContactDetailsDupAU

		SELECT * INTO #BossContactDetailsDupEU
		FROM [EU_FinanceBI].FinanceBI.[oss].[VwBossEUContactDetailsDup]

		IF EXISTS(SELECT TOP 1 1 FROM #BossContactDetailsDupEU)
		BEGIN
			DELETE FROM [oss].[BossContactDetailsDup] WHERE Region = 'EU'

			INSERT INTO [oss].[BossContactDetailsDup]
			SELECT * FROM #BossContactDetailsDupEU
		END

		DROP TABLE #BossContactDetailsDupEU

END