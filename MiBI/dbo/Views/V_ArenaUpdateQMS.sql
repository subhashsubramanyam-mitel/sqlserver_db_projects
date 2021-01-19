
CREATE VIEW [dbo].[V_ArenaUpdateQMS]

AS

select
'update' as [update],
substring(a.number,0,9) as part_number,
'1' as direct_buy,
CASE WHEN a.description='N/A' then '' ELSE a.description END AS description,
'' as units,
'-1' as lead_time,
CASE WHEN a.USPrice ='N/A' then '' ELSE a.USPrice END AS priceUSD,
CASE WHEN a.UKPrice ='N/A' then '' ELSE a.UKPrice END AS priceGBP,
CASE WHEN a.EUPrice ='N/A' then '' ELSE a.EUPrice END AS priceEUR,
CASE WHEN a.AUPrice ='N/A' then '' ELSE a.AUPrice END AS priceAUD,
CASE WHEN a.CAPrice ='N/A' then '' ELSE a.CAPrice END AS priceCAD,
CASE WHEN a.ItemType ='N/A' then '' ELSE a.ItemType END AS _part_custom_field1,
'' as _part_custom_field2,
CASE WHEN a.StatementofWork ='N/A' then '' 
	WHEN a.StatementofWork ='No' then 'N'
	WHEN a.StatementofWork ='Yes' then 'Y'
	ELSE a.StatementofWork END AS _part_custom_field3,
'' as _part_custom_field4,
CASE WHEN a.SupportTerm ='N/A' then '' ELSE a.SupportTerm END AS _part_custom_field5,
CAST(b.HWOnlyPercentofPrice as decimal)*100 AS _part_custom_field6,
CAST(b.SWOnlyPercentofPrice as decimal)*100 AS _part_custom_field7, --04032015 took out per Marina
--CASE WHEN a.GMFamily ='Support' then 'Y' ELSE '' END AS _part_custom_field8, --10212015 new logic per Kurt 
CASE WHEN b.ItemGroup='SUPP' THEN 'Y'
	WHEN b.ItemGroup='PHON' THEN 'HP'
	WHEN b.ItemGroup IN ('FGSW','GSSW') THEN 'S'
	WHEN b.ItemGroup IN ('TRVL','MISC') THEN 'O'
	WHEN b.MarketFamily ='Other' THEN 'O'
	WHEN b.MarketFamily ='Global Services' and b.ItemType NOT IN ('Monthly Subscription','Out of Warranty / Expired Support') THEN 'O'
	WHEN b.MarketFamily ='IP Telephony' and b.ItemType ='Application Servers' THEN 'S'
	WHEN b.MarketFamily ='IP Telephony' and b.ItemType In ('Legacy Integration','Other Equipment') THEN 'O'
	WHEN b.MarketFamily ='IP Telephony' and b.ItemType ='Server Hardware' THEN 'HO'
	WHEN b.MarketFamily ='IP Telephony' and b.ItemType ='Small Business Edition' THEN 'HS & S'
	WHEN b.MarketFamily ='IP Telephony' and b.ItemType In ('Third Party Products','Voice Switches') THEN 'HS'
	WHEN b.MarketFamily ='Mobility' and b.ItemType ='Docks' THEN 'HP'
	ELSE '' END AS _part_custom_field8,
CASE WHEN a.SKUNumber ='N/A' then '' ELSE a.SKUNumber END AS _part_custom_field9,
CAST(b.CustomerSupportRate as decimal)*100 AS _part_custom_field10,
CASE WHEN a.DiscountCategory ='N/A' then '' ELSE a.DiscountCategory END AS _part_custom_field11,
CASE WHEN a.PromotionsDiscountDetails ='N/A' then '' ELSE a.PromotionsDiscountDetails END AS _part_custom_field12,
CASE WHEN a.PromotionsEffectiveDateRange ='N/A' then '' ELSE a.PromotionsEffectiveDateRange END AS _part_custom_field13,
CAST(b.PhonePercentofPrice as decimal)*100 AS _part_custom_field14,
'' as _part_custom_field15,
CASE WHEN b.ItemType='Voice Switches' THEN '1'
	WHEN b.ItemType='Phones' THEN '2'
	WHEN b.ItemType='Docks' THEN '3'
	WHEN b.ItemType='Application Servers' THEN '4'
	WHEN (b.ItemType='Client Software' OR b.ItemType='Promotions') THEN '5'
	WHEN b.ItemType='Small Business Edition' THEN '6'
	WHEN b.ItemType='Advanced Applications' THEN '7'
	WHEN b.ItemType='Collaboration' THEN '8'
	WHEN b.ItemType='Server Hardware' THEN '9'
	WHEN b.ItemType='Third Party Products' THEN '10'
	WHEN b.ItemType='Other Equipment' THEN '11'
	WHEN b.ItemType='Partner Support' THEN '12'
	WHEN (b.ItemType='Enterprise Support' OR b.ItemType='UC Demos') THEN '13'
	WHEN b.ItemType='Shared Support' THEN '14'
	WHEN b.ItemType='Implementation Services' THEN '15'
	WHEN b.ItemType='Training' THEN '16'
	WHEN b.ItemType='Professional Services' THEN '17'
	WHEN b.ItemType='VoIP Network Services' THEN '18'
	WHEN b.ItemType='Out of Warranty / Expired Support' THEN '19'
	WHEN b.ItemType='User Documentation' THEN '20'
	WHEN b.ItemType='Legacy Integration' THEN '21'
	WHEN b.ItemType='Fees' THEN '22'
	WHEN b.ItemType='GSA Bundles' THEN '23'
	WHEN b.ItemType='Promotions' THEN '24'
	WHEN b.ItemType='Voice Switches' THEN '25'
	WHEN b.ItemType='Voice Switches' THEN '26'
	WHEN b.ItemType='Promotions' THEN '27'
	WHEN b.ItemType='CC Demos' THEN '28'
	WHEN b.ItemType='Demo Kits' THEN '29'
	WHEN b.ItemType='Mobility Demos' THEN '30'
	ELSE '' END AS _part_custom_field16,
CASE WHEN a.PartnersAffected ='N/A' then '' ELSE a.PartnersAffected END AS _part_custom_field17,
'' as _part_custom_field18,
'' as _part_custom_field19,
CASE WHEN a.MarketFamily ='N/A' then '' ELSE a.MarketFamily END AS _part_custom_field20,
'' as _part_custom_field21,
CASE WHEN (b.AnnualBillingTerm='3' OR b.AnnualBillingTerm='5') THEN 'Y'
	ELSE 'N' END AS _part_custom_field22,
CASE WHEN a.NoPhoneListPrice ='N/A' then '' ELSE a.NoPhoneListPrice END AS _part_custom_field23,
CAST(b.ShoreTelCostPercentofListPrice as decimal)*100 as _part_custom_field24,
CASE WHEN a.Stockable='Yes' then 'Y'
	WHEN a.Stockable='No' then 'N'
	ELSE '' END as _part_custom_field25,
'' as _part_custom_field26,
CASE WHEN a.DependencyCode ='N/A' then '' ELSE a.DependencyCode END AS _part_custom_field27,
CASE WHEN a.ItemSubtype='E' then 'C'
	WHEN a.ItemSubtype='A' then 'A'
	WHEN a.ItemSubtype='M' then 'M'
	ELSE '' END as _part_custom_field28,
'' as _part_custom_field29,
'' as _part_custom_field30,
b.ProductId as partner_part_id,
b.PricebookEntryId as partner_std_pbook_entry_id

FROM         ArenaItemTrk a LEFT OUTER JOIN
ArenaItemTrkSF b on a.guid=b.guid

WHERE ((a.effectiveDateTime >=getdate()-1 and a.effectiveDateTime<getdate()+1 and a.effectiveDateTime >a.EffectiveDateActual) OR
(a.EffectiveDateActual >=getdate()-1 and a.EffectiveDateActual<getdate()+1))
and a.lifecyclePhase='In Production' and a.status='1'
and a.SystemsAffectedbyChange like '%QMS%'
and a.ItemType NOT IN ('Monthly Subscription') --06082015 per Kurt
and a.guid NOT IN
(
select guid 
from ArenaItemTrkSF
where lastupdateDateTime BETWEEN DATEADD(hour, -28, GetDate()) and  DATEADD(hour, -2, GetDate())
and lifecyclePhase='In Production'
)
