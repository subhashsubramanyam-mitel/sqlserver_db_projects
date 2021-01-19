
CREATE view [temp_Q4ITBillings]
as
select [StockCode], sum([NetSalesUSD]) as 'netsales', source

 --[SKU] 
 from
[dbo].[POS_AXBILLINGS_COMBINED]
where
-- source = 'pos'
--and 
[InvoiceDate] >= '04/01/2015' and [InvoiceDate] <= '06/30/2015' 
group by source, [StockCode]
--order by [StockCode]