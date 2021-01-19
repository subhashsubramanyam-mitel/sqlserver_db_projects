

-- EXEC [Tableau].[UspInitPipeline_intl]
CREATE PROCEDURE [Tableau].[UspInitPipeline_intl]
AS
BEGIN
	-- MW 08052019 Called from nightly schedule
	-- MW 03162020 Update cust info

	
	--1. INSERT TO tableau.mVwSFDCCustInfo
	SELECT *
	INTO #mVwSFDCCustInfo
	FROM [$(MiBI)].dbo.V_TABLEAU_SFDC_CUST_INFO WITH(NOLOCK)

	IF OBJECT_ID('Tableau.mVwSFDCCustInfo', 'U') IS NOT NULL
		DROP TABLE Tableau.mVwSFDCCustInfo

	SELECT *
	INTO Tableau.mVwSFDCCustInfo
	FROM #mVwSFDCCustInfo

	DROP TABLE #mVwSFDCCustInfo
	

	--2. INSERT TO tableau.mVwGlobalPipeline_AU
	SELECT *
	INTO #mVwGlobalPipeline_AU
	FROM tableau.VwGlobalPipeline_AU
	
	IF (
			SELECT count(*)
			FROM #mVwGlobalPipeline_AU
			) > 1000
	BEGIN
		IF OBJECT_ID('tableau.mVwGlobalPipeline_AU', 'U') IS NOT NULL
			DROP TABLE tableau.mVwGlobalPipeline_AU

		SELECT *
		INTO tableau.mVwGlobalPipeline_AU
		FROM #mVwGlobalPipeline_AU
	END
	ELSE
		RAISERROR (
				'INTL BOSS Pipeline Data Not Initialized'
				,16
				,1
				)

	DROP TABLE #mVwGlobalPipeline_AU
	
	
	--3. INSERT TO tableau.mVwGlobalPipeline_EU
	SELECT *
	INTO #mVwGlobalPipeline_EU
	FROM tableau.VwGlobalPipeline_EU

	IF (
			SELECT count(*)
			FROM #mVwGlobalPipeline_EU
			) > 1000
	BEGIN
		IF OBJECT_ID('tableau.mVwGlobalPipeline_EU', 'U') IS NOT NULL
			DROP TABLE tableau.mVwGlobalPipeline_EU

		SELECT *
		INTO tableau.mVwGlobalPipeline_EU
		FROM #mVwGlobalPipeline_EU
	END
	ELSE
		RAISERROR (
				'INTL BOSS Pipeline Data Not Initialized'
				,16
				,1
				)

	DROP TABLE #mVwGlobalPipeline_EU

END
