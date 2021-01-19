
CREATE VIEW ALSandbox.VwGainsight_DisruptionList AS

SELECT Map.SfdcId
	,D.AccountId
	,[Platform]
	,Instance
	,LDVS
	,[CC Num]
	,[Outage Date]
	,CASE WHEN [Outage Type] = 'Bound' AND coalesce([Inbound Mins],0) = 0 
			THEN 'Outbound'
		  WHEN [Outage Type] = 'Bound' AND coalesce([Outbound Mins],0) = 0 
			THEN 'Inbound'
		  WHEN [Outage Type] = 'Bound'
			THEN 'Inbound/Outbound'
		  WHEN [Outage Type] = 'CC'
			THEN 'Call Center'
		ELSE [Outage Type]
		END AS [Outage Type]
	,[Total Mins]
	,[Total Call Mins]
	,[Inbound Mins]
	,[Outbound Mins]
	,CASE WHEN [Outage Type] = 'Bound' 
			THEN [Users Affected]
		WHEN [Outage Type] = 'CC'
			THEN [CC Users Affected]
		ELSE 0
		END AS [Users Affected]
	,[Total Users]
	,[Total CC Users]
	,dateadd(month,datediff(month,0,[Outage Date]),0) AS [OutageMonth]
FROM ALSandbox.SvcAvailabilityCustomer D
LEFT JOIN sfdc.VwAccountMap Map
	ON D.AccountId = Map.M5dbAccountId
