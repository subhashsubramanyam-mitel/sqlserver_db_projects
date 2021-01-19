/*
CREATE VIEW [dbo].[V_QMS_SAP_CONDITIONS]
AS

SELECT   
--LineAmount	   
rtrim(a.bs_id) as bs_id
,rtrim(a._sequence_number)*100 as ITM_NUMBER
,'EDI1' as COND_TYPE
--,rtrim(a._price_quantity) as COND_P_UNT
,rtrim(replace(a.quote_line_partner_ext_price, ',', '.') ) as COND_VALUE
FROM     
CORPDB.STDW.dbo.QMS_QUOTE_LINE a	
WHERE rtrim(a.quote_line_doNotShip) = 'false'
AND a._price_quantity != '0'
and ((a._price_quantity = '1' AND a._part_custom_field8 !='Y')or (a._price_quantity != '1'))
--and a.bs_id='632282443'
UNION ALL

--Discount (SemQMSDiscount)
SELECT   	   
rtrim(a.bs_id) as bs_id
,rtrim(a._sequence_number)*100 as ITM_NUMBER
,'YK35' as COND_TYPE
--,rtrim(a._price_quantity) as COND_P_UNT
--,a.quote_line_partner_disc as COND_VALUE
,CONVERT(varCHAR(15),CAST(rtrim(replace( CASE WHEN quote_line_partner_disc = 'Mixed%' 
	THEN '0'ELSE quote_line_partner_disc
	END, '%', '')) as decimal(16,2)))
FROM     
CORPDB.STDW.dbo.QMS_QUOTE_LINE a 
Where _part_custom_field9 NOT IN
(select SKUNumber COLLATE DATABASE_DEFAULT from [$(MiBI)].dbo.ArenaItemTrk
Where status=1
and lifecyclePhase='In Production'
and SystemsAffectedbyChange like '%QMS%'
 and ItemGroup='SUPP')
and rtrim(a.quote_line_doNotShip) = 'false'
AND a._price_quantity != '0'
and ((a._price_quantity = '1' AND a._part_custom_field8 !='Y')or (a._price_quantity != '1'))
--and a.bs_id='637371371'

UNION ALL
--create credit Line
select 
rtrim(a.bs_id) as bs_id
,b.PO_ITM_NO*100 as ITM_NUMBER
,'YRD0' as COND_TYPE
--,'1' as COND_P_UNT
,a.quote_DoNotShipCredit as COND_VALUE
from CORPDB.STDW.dbo.QMS_QUOTE_HEADER a LEFT OUTER JOIN
CORPDB.STDW.dbo.V_QMS_SAP_TEST b on a.bs_id=b.bs_id
where convert(decimal(18,3),rtrim(quote_DoNotShipCredit))>'0'
--and a.bs_id='73666834'

UNION ALL
--Freight charge
select 
rtrim(bs_id) as bs_id
,0 as ITM_NUMBER
,'YHD0' as COND_TYPE
--,'1' as COND_P_UNT
,quote_freightCharge as COND_VALUE
from CORPDB.STDW.dbo.QMS_QUOTE_HEADER
Where quote_freightCharge>'0'
--and bs_id='73666834'
*/












