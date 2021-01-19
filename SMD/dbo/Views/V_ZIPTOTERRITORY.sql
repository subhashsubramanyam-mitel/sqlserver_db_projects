
  Create view V_ZIPTOTERRITORY as
  -- MW 10022017 maps zip to territory info
  select   a.ZipCode, b.AXCode, b.Region, b.Subregion, b.ASM, b.CloudCSR,b.TerritoryName
 from 
  CORPDB.STDW.dbo.ZipCodeMap a inner join
  SFDC_TERRITORY b on a.Area = b.AXCode collate database_default
