CREATE VIEW dbo.[V_MiCC_EmailCounter]
AS
-- MW 12292020 new for email stats
SELECT a.DateKey
	,'[' + n.Name + '] ' + b.Reporting + ' ' + b.Name AS QueueName
	,SUM(a.Offered) AS ACDEmailsOffered
	,SUM(a.ReadingCount) AS ACDEmailsHandled
FROM [CLUMICC.MITEL.COM\MICC].[CCMData].[dbo].tblData_MCC_QueuePerformanceByPeriod a
INNER JOIN [CLUMICC.MITEL.COM\MICC].[CCMData].[dbo].tblConfig_Queue b ON a.FKQueue = b.Pkey
	AND b.FKNode = 'E7488423-0BCD-448F-A56A-C5B475222686' --EMail
INNER JOIN [CLUMICC.MITEL.COM\MICC].[CCMData].[dbo].tblEnterpriseConfig_Node n ON b.FKNode = n.Pkey
WHERE
	--a.FKQueue = '8DE690C7-23C5-4E28-9DE8-C951FC6E34B8' and
	a.DateKey > 20201101
GROUP BY a.DateKey
	,'[' + n.Name + '] ' + b.Reporting + ' ' + b.Name