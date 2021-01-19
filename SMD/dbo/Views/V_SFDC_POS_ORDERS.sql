CREATE View [dbo].[V_SFDC_POS_ORDERS] as
 --MW 03042015 Source for POS Orders into SFDC_OPTY_TRK for Processing
 -- *****SalesOrder MUST match logic in V_SFDC_SALESPRODUCTS*****
 SELECT     
   'POS' as Source,
	rtrim( rtrim(SalesOrder) + '-' +
	isnull(PartnerId,VADId) + '-' +
	isnull(CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END
					, 'NoCustInfo')  + '-' +
	convert(char(10), InvoiceDate,112) ) + '-' +
	convert(Varchar(5),ROW_NUMBER() over (Partition by
		rtrim( rtrim(SalesOrder) + '-' +
		isnull(PartnerId,VADId) + '-' +
		isnull(
				CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END 
						, 'NoCustInfo')  + '-' +
		convert(char(10), InvoiceDate,112) )
	  order by EndCustName)	)
	as SalesOrder, 
	isnull(rtrim(CustomerPo),'-') as CustomerPo,
	InvoiceDate as OrderDate, 
	InvoiceDate as ReqShipDate,
	isnull(PartnerId,VADId) as VarId,
	Rtrim(CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END) as EndCust, -- only numerics!!!  MW 10072016  otherwise this matches to accounts with shit like 'TBD'
	rtrim(EndCustName) as CustomerName,
	/*lower(RIGHT(End_Customer_IT_Contact_EMail, 
	LEN(End_Customer_IT_Contact_EMail) - 
	CHARINDEX('@', End_Customer_IT_Contact_EMail)))  as EmailDomain,
	Not in SMD */
	Sum(NetSalesUSD) as Billings
 FROM          
POS_AXBILLINGS_COMBINED 
 where InvoiceDate >= convert(Char(10), '07/01/2015',101)
 and Source = 'POS'
   -- ING Enable on 5-18-2016 MW
--AND  VADID != '736458'

group by 	
	rtrim(rtrim(SalesOrder) + '-' +
	isnull(PartnerId,VADId) + '-' +
	isnull(CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END
					, 'NoCustInfo')  + '-' +
	convert(char(10), InvoiceDate ,112) )	, 
	isnull(rtrim(CustomerPo),'-'),
	InvoiceDate   , 
	InvoiceDate   ,
	isnull(PartnerId,VADId)   ,
	EndCust, 
	EndCustName   
	HAVING Sum(NetSalesUSD) <>0