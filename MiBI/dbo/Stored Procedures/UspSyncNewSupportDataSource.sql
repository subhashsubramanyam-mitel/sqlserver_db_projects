

-- =============================================
-- Author:		Subhash Subramanyam
-- Create date: 11/10/2020
-- Description:	select * from support.NewSupportDataSource
-- Usage: EXEC [dbo].[UspSyncNewSupportDataSource]
-- =============================================
CREATE PROCEDURE [dbo].[UspSyncNewSupportDataSource] @IsFullRefresh BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing NewSupportDatasource data';

	IF OBJECT_ID(N'support.NewSupportDataSource', N'U') > 0 AND @IsFullRefresh = 1
	BEGIN
		
		DROP TABLE support.NewSupportDataSource

		SELECT * 
		INTO support.NewSupportDataSource
		FROM dbo.VwNewSupportDataSource

	END
	ELSE IF OBJECT_ID(N'support.NewSupportDataSource', N'U') > 0 AND @IsFullRefresh = 0
	BEGIN
		DECLARE @CaseLastModifiedDate DATETIME
		
		SELECT @CaseLastModifiedDate = MAX(CaseLastModifiedDate)
		FROM support.NewSupportDataSource (NOLOCK)

		SELECT @CaseLastModifiedDate = ISNULL(DATEADD(DAY, -15 , @CaseLastModifiedDate), '2020-01-01')

		DELETE FROM support.NewSupportDataSource 
		WHERE CaseLastModifiedDate >= @CaseLastModifiedDate
		
		INSERT support.NewSupportDataSource
		SELECT * FROM dbo.VwNewSupportDataSource 
		WHERE CaseLastModifiedDate >= @CaseLastModifiedDate

	END

	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing NewSupportDatasource data';
END
