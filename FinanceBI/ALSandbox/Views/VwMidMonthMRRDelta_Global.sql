







CREATE VIEW [ALSandbox].[VwMidMonthMRRDelta_Global] AS

SELECT --'US_'+ ltrim(str(AccountId)) AS AccountId
	  ltrim(str(AccountId))  COLLATE Latin1_General_BIN AS AccountId  -- Should work for US
	,ServiceMonth
	,[MRR Category]  COLLATE database_default as [MRR Category] 
	,PipelineStage  COLLATE database_default as PipelineStage
	,MRR as [MRR Delta]
	--,Region   COLLATE database_default as Region
	, 'NA' as Region
	,[Ac Name]  COLLATE database_default as [Ac Name] 
	,DeltaQuantity
	,DeltaQuantity_Seats
	,MRR_LC as [MRR Delta LC]
	,OrderCloseReason
	,QuantitySeats
FROM ALSandbox.VwMidMonthMRRDelta-- AS MRRD_US

UNION ALL

SELECT 'EU-' + ltrim(Str(AccountId)) COLLATE Latin1_General_BIN  AS AccountId
	,ServiceMonth
	,[MRR Category]  COLLATE database_default as [MRR Category] 
	,PipelineStage  COLLATE database_default as PipelineStage
	,MRR  as [MRR Delta]
	--,Region   COLLATE database_default as Region
	,'EU' As Region
	,[Ac Name]  COLLATE database_default as [Ac Name] 
	,DeltaQuantity -- 0 until it is added
	,DeltaQuantity_Seats
	,MRR_LC  as [MRR Delta LC]
	,null as OrderCloseReason
	,QuantitySeats
FROM EU_FinanceBI.FinanceBI.ALSandbox.VwMidMonthMRRDelta-- AS MRRD_EMEA


/*  select top 1 * from EU_FinanceBI.FinanceBI.ALSandbox.VwMidMonthMRRDelta 
UNION ALL

MW 09232019 commenting out since there is an old AX reference here

SELECT 'SHV_'+ ParentGroupID AS AccountId
	,ChangeMonth AS ServiceMonth
	,MRR_Category AS 'MRR Category'
	,'Secured' AS PipelineStage
	,SUM(MRRDelta_USD) AS MRR
	,'APAC' AS Region
	,ParentGroup COLLATE Latin1_General_BIN AS 'Ac Name' 
FROM ALSandbox.VwSHV_MRRD
GROUP BY ParentGroupID, ChangeMonth, ParentGroup, MRR_Category
--ORDER BY ParentGroupID, ChangeMonth, ParentGroup, MRR_Category
*/


--APAC Connect
UNION ALL

SELECT 'AU-' + ltrim(Str(AccountId)) COLLATE Latin1_General_BIN  AS AccountId
	,ServiceMonth
	,[MRR Category]  COLLATE database_default as [MRR Category] 
	,PipelineStage  COLLATE database_default as PipelineStage
	,MRR   as [MRR Delta]
	--,Region   COLLATE database_default as Region
	,'AU' as Region
	,[Ac Name]  COLLATE database_default as [Ac Name] 
	,DeltaQuantity -- 0 until it is added
	,DeltaQuantity_Seats
	,MRR_LC  as [MRR Delta LC]
	,null as OrderCloseReason
	,QuantitySeats
FROM AU_FinanceBI.FinanceBI.ALSandbox.VwMidMonthMRRDelta-- AS MRRD_AU


/*
-- Until link is in place add AUS Connect Manually

UNION ALL
SELECT 'AU_11531','20170701','Install','Secured',1319.29,'APAC','White Ribbon Australia'
UNION ALL
SELECT 'AU_11534','20170701','Install','Secured',449.03,'APAC','MRWED PTY LTD'
UNION ALL
SELECT 'AU_11537','20170701','Install','Secured',50.58,'APAC','Endevour Petroleum Private Ltd'
UNION ALL
SELECT 'AU_11538','20170701','Install','Secured',204.21,'APAC','CPTB Pty Lyd'
UNION ALL
SELECT 'AU_11539','20170701','Install','Secured',159.94,'APAC','Apex Digital Marketing'
UNION ALL
SELECT 'AU_11506','20170701','Add','Secured',0,'APAC','ConnectACC1'
UNION ALL
SELECT 'AU_11506','20170701','Downsize','Secured',0,'APAC','ConnectACC1'

*/
