
-- =============================================
-- Author:		Subhash Subramanyam
-- Create date: 2020-12-06
-- Description:	Load Incremental MRR base
-- =============================================
CREATE PROCEDURE [invoice].[UspLoadIncrMRRbaseEXAggregate]
AS
BEGIN
	TRUNCATE TABLE [invoice].[IncrMRRbase_EX_Aggregate];

	INSERT INTO [invoice].[IncrMRRbase_EX_Aggregate]
	SELECT *
	FROM [invoice].[VwIncrMRRbase_EX_Aggregate]
END
