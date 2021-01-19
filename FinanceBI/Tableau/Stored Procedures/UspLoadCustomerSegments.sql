
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-01
-- Description:	Load CustomerSegments Table
-- Usage: EXEC [Tableau].[UspLoadCustomerSegments]
--		  SELECT count(*) from tableau.CustomerSegments
-- =============================================
CREATE PROCEDURE [Tableau].[UspLoadCustomerSegments]
	--@rundate date
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT a.AccountId
		,count(*) AS NumProfiles
	INTO #AccountNumProfiles
	FROM oss.VwServiceProduct_EX a(NOLOCK)
	WHERE a.ProductId IN -- Only Profiles/Seats
		(
			108
			,351
			,352
			,353
			,354
			,402
			,403
			)
		AND --b.Name in ( 'Active' , 'Pending', 'Provisioning')
		a.ServiceStatusId IN (
			1
			,16
			,27
			)
	GROUP BY a.AccountId

	TRUNCATE TABLE tableau.CustomerSegments

	INSERT INTO tableau.CustomerSegments (
		[AccountId]
		,[NumProfiles]
		,CustomerSegmentByProfileSize
		) (
		SELECT [AccountId]
		,[NumProfiles]
		,CASE 
			WHEN [NumProfiles] < 51
				THEN '0-50'
			WHEN [NumProfiles] < 101
				THEN '51-100'
			WHEN [NumProfiles] < 251
				THEN '101-250'
			WHEN [NumProfiles] > 250
				THEN '250+'
			END AS CustomerSegmentByProfileSize FROM (
		SELECT a.AccountId
			,CASE 
				WHEN a.NumProfiles > isnull(b.Employees, 0)
					THEN a.NumProfiles
				WHEN b.Employees > a.NumProfiles
					THEN b.Employees
				ELSE 0
				END AS NumProfiles
		FROM #AccountNumProfiles a
		LEFT OUTER JOIN tableau.mVwSFDCCustInfo b ON a.AccountId = b.AccountId
			AND isnumeric(b.AccountId) = 1
		) a
		)

		DROP TABLE #AccountNumProfiles

END
