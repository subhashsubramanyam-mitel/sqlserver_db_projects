

 CREATE View [dbo].[V_SFDC_TERRITORY] as 
 -- Only return 1 Axcode MW 08032015
 -- now just making AXCode Uniqiue 04012019
 SELECT
  [Created]
      ,[SfdcId]
      ,CASE WHEN rn> 1 then [AXCode]+'_'+convert(Varchar(5),rn) else AXCode end as AXCode
      ,[Region]
      ,[TerritoryName]
      ,[Subregion]
      ,[Theatre]
      ,[CSM]
      ,[ASM]
      ,[SE]
      ,[RVP]
      ,[RD]
      ,[ASR]
	,DualCSEPBM, CloudCSR, GOV
	  FROM (
SELECT  [Created]
      ,[SfdcId]
      ,[AXCode]
      ,[Region]
      ,[TerritoryName]
      ,[Subregion]
      ,[Theatre]
      ,[CSM]
      ,[ASM]
      ,[SE]
      ,[RVP]
      ,[RD]
      ,[ASR]
	,DualCSEPBM, CloudCSR, GOV,
	  Row_number() over (partition by AXCode order by Created desc) rn
  FROM [dbo].[SFDC_TERRITORY]
 ) a --where rn = 1
