 

--for RMA analysis


CREATE VIEW  V_RMA
AS

 select a.*, b.BusinessLine, b.Category, b.MarketFamily
 from 
 AX_BILLINGS  a left outer join
 PRODUCT_LINE b on a.StockCode = b.StockCode
 where OrderType IN ('R','RR')