CREATE PROCEDURE [support].[GetAgentDetails]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT '' as CallRecording
	,'' as CaseNumber
	,'' as CaseReason
	,'' as SubReason
	,'' as Extension
	,'' as InteractionTime
	,'' as  IdleTime
	,0.00 as Magnitude
		,'' AS CustomerType
		,count(AgentId) AS AgentId
		,AgentName
		,CAST(AVG(CSATScore) AS DECIMAL(10,2)) AS CSATScore
		,CAST(AVG(FCR) AS DECIMAL(10,2)) AS FCR
		,CAST(AVG(SLA) AS DECIMAL(10,2)) AS SLA
		,CAST(AVG(CaseAge) AS DECIMAL(10,2)) AS CaseAge
		,CAST(AVG(CustomerSentiment) AS DECIMAL(10,2)) AS CustomerSentiment
		,0 AS PositiveEmotionCount
		,0 AS NegativeEmotionCount
		,0 AS NeutralEmotionCount
		,'' AS Emotion
	FROM support.Sentiment_Analytics
	WHERE AgentId IN (
			SELECT DISTINCT AgentId
			FROM support.Sentiment_Analytics
			)
	GROUP BY AgentId
		,AgentName

	SET NOCOUNT OFF;
END