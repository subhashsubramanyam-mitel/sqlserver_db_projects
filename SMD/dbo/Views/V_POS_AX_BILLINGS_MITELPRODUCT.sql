

 CREATE View [dbo].[V_POS_AX_BILLINGS_MITELPRODUCT] as
 -- MW 11202017 view for Frank
 select 
  a.*,
  ISNULL(b.[SAP Sub Family A], 'NO PRODUCT MAPPING') as [SAP Sub Family A],	
  b.[SAP Sub Family B],	
  b.[SAP Main Group],	
  b.[SAP Group],	
  b.[Prod Hier Number],	
  b.[Prod Hier Description]
FROM
 POS_AXBILLINGS_COMBINED a left outer join
 MITEL_PRODUCT_MAP2 b on a.StockCode = b.StockCode
GO
GRANT SELECT
    ON OBJECT::[dbo].[V_POS_AX_BILLINGS_MITELPRODUCT] TO [POS]
    AS [dbo];

