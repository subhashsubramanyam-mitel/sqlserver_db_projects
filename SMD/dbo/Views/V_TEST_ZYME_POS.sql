
 
 Create view V_TEST_ZYME_POS as 
 -- MW 01022019  Test for Zyme POS to SFDC
SELECT 
	   [/BIC/YSO_TID]  -- txn Id
      , substring([/BIC/YSOVESPN], patindex('%[^0]%',[/BIC/YSOVESPN]), 15) as CustomerId 

     ,[/BIC/YSOVEUNM]  --cust name
    
      ,[/BIC/YSOORDNO] -- SO/PO

      ,[/BIC/YSOTRADT]  -- Ship Date, convert(date,a.InvoiceDate) as WARRANTY_START,  DATEADD(month, 13,  convert(date,a.InvoiceDate))  as WARRANTY_END, 

      ,[/BIC/YSOMATID]  --SKU

	  ,[/BIC/YSOM_DPT] as Description

      ,[/BIC/YSO_QUAN]   --QTY   
	  ,[/BIC/YSOCLUP]  -- LIst Price
	  ,[CURRENCY]   --
  FROM [SMD].[dbo].[tmp_HanaPOS] a inner join

  SE_SUPPORT_PRD_LKUP b on a.[/BIC/YSOMATID] = b.SKU collate database_default
