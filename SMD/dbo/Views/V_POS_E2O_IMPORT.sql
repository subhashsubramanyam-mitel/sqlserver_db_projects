












CREATE view [dbo].[V_POS_E2O_IMPORT] as
 -- Import from HANA POS MW 01202019
select 
	 TransactionId	
	,CustomerId	
	,CustomerName	
	,SalesOrder	
	 ,convert(date,a.ShipDate) as ShipDate	
	,convert(date,a.ShipDate) as WarrantyStart,  DATEADD(month, 13,  convert(date,a.ShipDate))  as WarrantyEnd
	,a.SKU	as Sku
	,Description	
	,SERIALNUMBER	+ SERIALNUMBER2	 as SerialNumber
	,Qty	
	,ListPrice	
	,CURRENCY	as Currency
	

 from
(
	SELECT
		   [/BIC/YSO_TID]  as TransactionId
      , substring([/BIC/YSOE_CID], patindex('%[^0]%',[/BIC/YSOE_CID]), 15) as CustomerId 

     ,[/BIC/YSOCUSNM]  as CustomerName
    
      ,[/BIC/YSOORDNO] as SalesOrder

      ,[/BIC/YSOTRADT]  as  ShipDate   --, convert(date,a.InvoiceDate) as WARRANTY_START,  DATEADD(month, 13,  convert(date,a.InvoiceDate))  as WARRANTY_END, 

      --,[/BIC/YSOMATID]  as SKU
	  -- MW 01282019 USe validated SKU
	  ,[/BIC/YSOVSKU] as SKU

	  ,[/BIC/YSOM_DPT] as Description

	  ,SERIALNUMBER
	  ,SERIALNUMBER2

      ,[/BIC/YSO_QUAN]   as Qty  
	  --,[/BIC/YSOCLUP]  As ListPrice
	  --non converted
	 ,[/BIC/YSO_LUTP] as ListPrice



	  ,[CURRENCY]    
	  ,[/BIC/YSOWHSE] as Warehouse
	  ,[/BIC/YSO_LDFG] as LoadFlag

 
	FROM OPENQUERY (BWP,  'SELECT * FROM   SAPBWP."/BIC/AYSOCBK012"  where "/BIC/YSORVADI"  in 
	( 341256, 384053, 339762,
	341682	
--,
--365181	,
--366639	,
--367637	,
--368844	,
--374660	,
--375389	,
--376222	,
--383793	,
--384433	,
--384436	,
--384439	,
--384440	,
--384441	,
--384442	,
--384443	,
--384444	,
--384445	,
--384446	,
--384447	,
--384448	,
--384449	,
--384452	,
--384453	,
--384455	,
--384491	,
--384513	,
--385390	,
--385731	,
--385896	,
--385901	,
--386368	,
--386419	,
--387241	,
--387873	,
--388637	,
--388687	,
--388752	,
--388880	,
--389221	,
--389252	,
--389253	,
--749593		
	)
	and COUNTRY = ''US''
	and "/BIC/YSOTRADT" > 20190501')   
	) a inner join
	SE_SUPPORT_PRD_LKUP b on a.SKU = b.SKU collate database_default
	where Warehouse Not in ( 99 , 90 ) and    a.LoadFlag <> 'D'







