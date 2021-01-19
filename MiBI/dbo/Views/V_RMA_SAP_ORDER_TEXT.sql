/*
CREATE VIEW [dbo].[V_RMA_SAP_ORDER_TEXT]
AS
--JO 03212018 for RMA to SAP
SELECT   
--Description
TxnId as Id
,'000000' as ITM_NUMBER
,'Y011' as TEXT_ID
,'E' as LANGU
,replace(replace(Description, char(13), ''), char(10), '') as TEXT_LINE
FROM CORPDB.STDW.dbo.WEB_RMA_TRKv2
UNION ALL

SELECT 
--Serial Number
TxnId as Id
,'100' as ITM_NUMBER
,'Y110' as TEXT_ID
,'E' as LANGU
,f.Item AS TEXT_LINE
FROM CORPDB.STDW.dbo.WEB_RMA_TRKv2 AS s
CROSS APPLY dbo.SplitStrings(s.[Serial], ';') as f
Where s.Serial is not NULL

UNION ALL

SELECT   
--Support
TxnId as Id
,'000000' as ITM_NUMBER
,'Z120' as TEXT_ID
,'E' as LANGU
,b.existingContractType COLLATE DATABASE_DEFAULT as TEXT_LINE
FROM CORPDB.STDW.dbo.WEB_RMA_TRKv2 a LEFT OUTER JOIN
V_GetSupport b on a.CustomerId=b.ImpactNumber COLLATE DATABASE_DEFAULT

UNION ALL

SELECT   
--Email
TxnId as Id
,'000000' as ITM_NUMBER
,'Y070' as TEXT_ID
,'E' as LANGU
,CustomerEmail as TEXT_LINE
FROM CORPDB.STDW.dbo.WEB_RMA_TRKv2

UNION ALL

SELECT   
--4/18/2018 per Peter,Lynn add RMA info
--Y019
TxnId as Id
,'000000' as ITM_NUMBER
,'Y019' as TEXT_ID
,'E' as LANGU
,'RMA #'+SrNumber+', '+ShipContact+' was provided with a return label, return within 15 days for 100% credit towards this invoice.' as TEXT_LINE
FROM CORPDB.STDW.dbo.WEB_RMA_TRKv2
*/




