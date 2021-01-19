CREATE view global.VwSFDCSkyBillingsRow as
-- MW 09282016 for Sky SalesCOM orch select * from SVLBIDB.AU_FinanceBI.invoice.VwLineItem_EX
-- AU
--
 select 

			--SalesOrder + '_' + convert(char(10),InvoiceDate,121) as SalesOrder,
			'AU-'+convert(Varchar(50),a.InvoiceId) as SalesOrder,
			a.DateGenerated as OrderDate,
			 DATEADD(mm, 1,a.DateGenerated  ) as ComDate,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) as CustomerSfdcId,
			c.PartnerOfRecordCloud,
			 null as PONumber,
			 isnull(c.NAME,rtrim(ig.Name)) as IgName,
			 a.CurrencyCode,
			 'AU-'+ convert(varchar(10),a.AccountId) as BossAccountId,
			SUM(a.Charge_LC) as HostedBilling
From  --AX_BILLINGS a left outer join
	  --AX_ITEMS i on a.SKU = i.SKU left outer join
	 AU_FinanceBI.FinanceBI.invoice.VwLineItem_EX a left outer join
	 AU_FinanceBI.FinanceBI.[company].VwInvoiceGroup ig on a.InvoiceGroupId = ig.Id left outer join
	 SMD.SMD.dbo.SFDC_CUSTOMERS c on  'AU-'+ convert(varchar(10),a.AccountId)  = c.M5DBAccountID   collate database_default  --and isnumeric(c.M5DBAccountID) = 1
	 -- MW 10032016 Make sure was invoiced from AX, this table loaded nightly
	  INNER JOIN SMD.SMD.dbo.SFDC_SKY_BILLING_AX_ROW ax on 'AU-'+convert(varchar(50),a.InvoiceId) = ax.CustomerPo
where 
	a.DateGenerated >= convert(Char(10), '01/01/2017',101)  
	--ChargeCategory NOT IN ('Surcharge','Regulatory')
group by 

			--SalesOrder + '_' + convert(char(10),InvoiceDate,121) ,
			'AU-'+convert(Varchar(50),a.InvoiceId),
			a.DateGenerated ,
			DATEADD(mm, 1,a.DateGenerated  ) ,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) ,
			c.PartnerOfRecordCloud,
			 isnull(c.NAME,rtrim(ig.Name)),
			--a.CustomerPO
			a.CurrencyCode,
			'AU-'+ convert(varchar(10),a.AccountId)
Having 	SUM(a.Charge) != 0

Union ALL

-- EU
--
 select 

			--SalesOrder + '_' + convert(char(10),InvoiceDate,121) as SalesOrder,
			'EU-'+convert(Varchar(50),a.InvoiceId) as SalesOrder,
			a.DateGenerated as OrderDate,
			 DATEADD(mm, 1,a.DateGenerated  ) as ComDate,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) as CustomerSfdcId,
			c.PartnerOfRecordCloud,
			 null as PONumber,
			 isnull(c.NAME,rtrim(ig.Name)) as IgName,
			 a.CurrencyCode,
			 'EU-'+ convert(varchar(10),a.AccountId) as BossAccountId,
			SUM(a.Charge_LC) as HostedBilling
From  --AX_BILLINGS a left outer join
	  --AX_ITEMS i on a.SKU = i.SKU left outer join
	 EU_FinanceBI.FinanceBI.invoice.VwLineItem_EX a left outer join
	 EU_FinanceBI.FinanceBI.[company].VwInvoiceGroup ig on a.InvoiceGroupId = ig.Id left outer join
	 SMD.SMD.dbo.SFDC_CUSTOMERS c on  'EU-'+ convert(varchar(10),a.AccountId)  = c.M5DBAccountID   collate database_default  --and isnumeric(c.M5DBAccountID) = 1
	 -- MW 10032016 Make sure was invoiced from AX, this table loaded nightly
	 INNER JOIN SMD.SMD.dbo.SFDC_SKY_BILLING_AX_ROW ax on 'EU-'+convert(varchar(50),a.InvoiceId) = ax.CustomerPo
where 
	a.DateGenerated >= convert(Char(10), '01/01/2017',101)  
	--ChargeCategory NOT IN ('Surcharge','Regulatory')
group by 

			--SalesOrder + '_' + convert(char(10),InvoiceDate,121) ,
			'EU-'+convert(Varchar(50),a.InvoiceId),
			a.DateGenerated ,
			DATEADD(mm, 1,a.DateGenerated  ) ,
			 ISNULL( c.SfdcId , '001C000001NB5YfIAL' ) ,
			c.PartnerOfRecordCloud,
			 isnull(c.NAME,rtrim(ig.Name)),
			--a.CustomerPO
			a.CurrencyCode,
			'EU-'+ convert(varchar(10),a.AccountId)
Having 	SUM(a.Charge) != 0


UNION ALL
-- EU Using AX for Credits
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
			'EU-'+ convert(varchar(10),ig.AccountId) as BossAccountId,
			SUM(a.NetSalesPlanRate) as HostedBilling
From  SMD.SMD.dbo.AX_BILLINGS a left outer join
	 -- AX_ITEMS i on a.SKU = i.SKU left outer join
	 EU_FinanceBI.FinanceBI.[company].VwInvoiceGroup ig on a.BossInvoiceGroupId = 'EU-'+ convert(varchar(10),ig.Id)   and  -- MW 05222017 No EU since not in FinanceBI...
																		 a.BossInvoiceGroupId like 'EU-%'  left outer join
	 SMD.SMD.dbo.SFDC_CUSTOMERS c on 'EU-'+ convert(varchar(10),ig.AccountId) = c.M5DBAccountID  collate database_default  and c.M5DBAccountID like 'EU-%'
where 
	InvoiceDate >= convert(Char(10), '01/01/2017',101) and a.BossInvoiceGroupId like 'EU-%' 
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
			'EU-'+ convert(varchar(10),ig.AccountId)
Having 	SUM(a.NetSalesPlanRate)  != 0
 UNION ALL
 -- AU Credits
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
			'AU-'+ convert(varchar(10),ig.AccountId) as BossAccountId,
			SUM(a.NetSalesPlanRate) as HostedBilling
From  SMD.SMD.dbo.AX_BILLINGS a left outer join
	 -- AX_ITEMS i on a.SKU = i.SKU left outer join
	 EU_FinanceBI.FinanceBI.[company].VwInvoiceGroup ig on a.BossInvoiceGroupId = 'AU-'+ convert(varchar(10),ig.Id)   and  -- MW 05222017 No EU since not in FinanceBI...
																		 a.BossInvoiceGroupId like 'AU-%'  left outer join
	 SMD.SMD.dbo.SFDC_CUSTOMERS c on 'AU-'+ convert(varchar(10),ig.AccountId) = c.M5DBAccountID  collate database_default  and c.M5DBAccountID like 'AU-%'
where 
	InvoiceDate >= convert(Char(10), '01/01/2017',101) and a.BossInvoiceGroupId like 'AU-%' 
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
			'AU-'+ convert(varchar(10),ig.AccountId)
Having 	SUM(a.NetSalesPlanRate)  != 0

  





