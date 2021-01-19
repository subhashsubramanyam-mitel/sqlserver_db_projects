CREATE PROCEDURE [support].[GetBusinessDetails]
AS
BEGIN
	SET NOCOUNT ON;
 

SELECT '' as CallRecording
	,'' as CaseNumber
	,'' as CaseReason
	,'' as SubReason
	,'' as AgentName
	,'' as Extension
	,'' as InteractionTime
	,'' as  IdleTime
	,CAST(SUM(CustomerSentiment) AS DECIMAL(10,2)) AS CustomerSentiment
	,0.00 as Magnitude
	,'' as Emotion
		,count(AgentId) AS AgentId
		,CAST(AVG(CSATScore) AS DECIMAL(10,2)) AS CSATScore
		,CAST(AVG(FCR) AS DECIMAL(10,2)) AS FCR
		,CAST(AVG(SLA) AS DECIMAL(10,2)) AS SLA
		,CAST(AVG(CaseAge) AS DECIMAL(10,2)) AS CaseAge
		,CustomerType
	,SUM(CASE 
			WHEN Emotion = 'Positive'
				THEN 1
			ELSE 0
			END) as PositiveEmotionCount
	,SUM(CASE 
			WHEN Emotion = 'Negative'
				THEN 1
			ELSE 0
			END) as NegativeEmotionCount
	,SUM(CASE 
			WHEN Emotion = 'Neutral'
				THEN 1
			ELSE 0
			END) as NeutralEmotionCount
FROM  support.Sentiment_Analytics
	WHERE AgentId IN (
			SELECT DISTINCT AgentId
			FROM support.Sentiment_Analytics
			)
GROUP BY CustomerType
END