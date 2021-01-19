

 CREATE View [dbo].[V_SFDC_ORDER_SHIP_ADDR] as
 -- MW 12072015 Brandon Requested adding ship info to order in SFDC

 select 
  a.SalesOrder,
  a.ShipState,
	a.ShipPostalCode,
	-- SFDC
	CASE WHEN a.ShipCountry = 'UK' then 'GB' ELSE a.ShipCountry END AS ShipCountry
  from          
POS_AXBILLINGS_COMBINED a inner join
SFDC_OPTY_TRK b on a.SalesOrder = b.SalesOrder
 where InvoiceDate >= convert(Char(10), '07/01/2015',101)
 and a.Source = 'AX' and b.OrderCreateStatus = 'C'
 group by   
a.SalesOrder,
a.ShipState,
a.ShipPostalCode,
a.ShipCountry

 Union all
 
 select 
 a.SalesOrder,
 a.ShipState,	
 a.ShipPostalCode,	
 -- SFDC
	CASE WHEN a.ShipCountry = 'UK' then 'GB' ELSE a.ShipCountry END AS ShipCountry FROM
 (
 SELECT     
	rtrim( rtrim(SalesOrder) + '-' +
	isnull(PartnerId,VADId) + '-' +
	isnull(EndCust, 'NoCustInfo')  + '-' +
	convert(char(10), InvoiceDate,112) ) + '-' +
	convert(Varchar(5),ROW_NUMBER() over (Partition by
		rtrim( rtrim(SalesOrder) + '-' +
		isnull(PartnerId,VADId) + '-' +
		isnull(EndCust, 'NoCustInfo')  + '-' +
		convert(char(10), InvoiceDate,112) )
	  order by EndCustName)	)
	as SalesOrder, 
	ShipState,
	ShipPostalCode,
	ShipCountry

 FROM          
POS_AXBILLINGS_COMBINED 
 where InvoiceDate >= convert(Char(10), '07/01/2015',101)
 and Source = 'POS'
group by 	
	rtrim(rtrim(SalesOrder) + '-' +
	isnull(PartnerId,VADId) + '-' +
	isnull(EndCust, 'NoCustInfo')  + '-' +
	convert(char(10), InvoiceDate ,112) )	, 
	isnull(rtrim(CustomerPo),'-'),
	InvoiceDate   , 
	InvoiceDate   ,
	isnull(PartnerId,VADId)   ,
	EndCust, 
	EndCustName,
	ShipState,
	ShipPostalCode,
	ShipCountry
	HAVING Sum(NetSalesUSD) <>0
) a inner join 
SFDC_OPTY_TRK b on a.SalesOrder = b.SalesOrder
 where b.OrderCreateStatus = 'C'





	 

