
CREATE View [dbo].[V_SKY_ACCOUNT_IDS] as
-- MW 01142015 Mapping for ST IDs in SFDC
 select 
 M5dbAccountID,
 max(ShoretelId) as ShoretelId
 from 
SFDC_SKY_INVOICEGROUP  
where ShoretelId  != 0
group by M5dbAccountID
