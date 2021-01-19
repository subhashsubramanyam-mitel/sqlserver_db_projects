CREATE PROCEDURE [support].[GetCallRecordingDetails]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
		,0 AS PositiveEmotionCount
		,0 AS NegativeEmotionCount
		,0 AS NeutralEmotionCount

	FROM support.Sentiment_Analytics
	SET NOCOUNT OFF;
END
