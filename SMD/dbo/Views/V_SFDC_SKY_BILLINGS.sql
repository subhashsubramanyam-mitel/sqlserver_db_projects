









CREATE view [dbo].[V_SFDC_SKY_BILLINGS] as
-- MW 09282016 for Sky SalesCOM orch

 select 

			--SalesOrder + '_' + convert(char(10),InvoiceDate,121) as SalesOrder,
			convert(Varchar(50),a.InvoiceId) as SalesOrder,
			a.DateGenerated as OrderDate,
			 DATEADD(mm, 1,a.DateGenerated  ) as ComDate,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) as CustomerSfdcId,
			c.PartnerOfRecordCloud,
			 null as PONumber,
			 isnull(c.NAME,rtrim(ig.Name)) as IgName,
			 a.CurrencyCode,
			 a.AccountId as BossAccountId,
			SUM(a.Charge_LC) as HostedBilling
From  --AX_BILLINGS a left outer join
	  --AX_ITEMS i on a.SKU = i.SKU left outer join
	 SVLBIDB.FinanceBI.invoice.VwLineItem_EX a left outer join
	 SVLBIDB.FinanceBI.[company].VwInvoiceGroup ig on a.InvoiceGroupId = ig.Id left outer join
	 SFDC_CUSTOMERS c on a.AccountId = c.M5DBAccountID   collate database_default  and isnumeric(c.M5DBAccountID) = 1
	 -- MW 10032016 Make sure was invoiced from AX, this table loaded nightly
	 INNER JOIN SFDC_SKY_BILLING_AX ax on a.InvoiceId = ax.CustomerPo
where 
	a.DateGenerated >= convert(Char(10), '01/01/2017',101)  
	--ChargeCategory NOT IN ('Surcharge','Regulatory')
group by 

			--SalesOrder + '_' + convert(char(10),InvoiceDate,121) ,
			convert(Varchar(50),a.InvoiceId),
			a.DateGenerated ,
			DATEADD(mm, 1,a.DateGenerated  ) ,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) ,
			c.PartnerOfRecordCloud,
			 isnull(c.NAME,rtrim(ig.Name)),
			--a.CustomerPO
			a.CurrencyCode,
			a.AccountId
Having 	SUM(a.Charge) != 0



UNION ALL
-- Using AX for Credits
 select 

			-- SalesOrder + '_' + convert(char(10),InvoiceDate,121) as SalesOrder,
			'SKY AX CREDIT: ' + SalesOrder   as SalesOrder,
			a.InvoiceDate as OrderDate,
			 DATEADD(mm, 1,a.InvoiceDate  ) as ComDate,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) as CustomerSfdcId,
			c.PartnerOfRecordCloud,
			a.CustomerPO as PONumber,
			isnull(c.NAME,rtrim(ig.Name)) as IgName,
			'USD' AS CurrencyCode,
			ig.AccountId as BossAccountId,
			SUM(a.NetSalesPlanRate) as HostedBilling
From  AX_BILLINGS a left outer join
	 -- AX_ITEMS i on a.SKU = i.SKU left outer join
	 SVLBIDB.FinanceBI.[company].VwInvoiceGroup ig on a.BossInvoiceGroupId = ig.Id and  -- MW 05222017 No EU since not in FinanceBI...
																		isnumeric(a.BossInvoiceGroupId) = 1 left outer join
	 SFDC_CUSTOMERS c on ig.AccountId = c.M5DBAccountID  collate database_default  and isnumeric(c.M5DBAccountID) = 1
where 
	InvoiceDate >= convert(Char(10), '01/01/2017',101) and isnumeric(a.BossInvoiceGroupId) = 1
and OrderType =
(
'SKY-CR'
)
group by 

			'SKY AX CREDIT: ' + SalesOrder,
			a.InvoiceDate ,
			DATEADD(mm, 1,a.InvoiceDate  ) ,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) ,
			c.PartnerOfRecordCloud,
			a.CustomerPO,
			isnull(c.NAME,rtrim(ig.Name)),
			ig.AccountId
Having 	SUM(a.NetSalesPlanRate)  != 0
 

  







