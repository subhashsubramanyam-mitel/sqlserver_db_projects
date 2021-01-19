



CREATE VIEW [dbo].[V_SFDC_POS_BILLINGS] AS 
-- MW 03042015 POS Invoice List with Line ID for Sync


select 
 	rtrim(SalesOrder) + '-' +
	rtrim(isnull(a.PartnerId,a.VADId)) + '-' +
	isnull(CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END
					, 'NA')  + '-' +
	convert(char(8), InvoiceDate,112)   + '-' +
	rtrim(a.SKU)   + '-' + cast  (  
	ROW_NUMBER() over (partition By   	
	 	rtrim(SalesOrder) + '-' +
		rtrim(isnull(a.PartnerId,a.VADId)) + '-' +
		isnull(CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END
					, 'NoCustInfo')  + '-' +
		convert(char(8), InvoiceDate,112)   + '-' +
		rtrim(a.SKU)
	order by InvoiceDate)  as   Varchar(5) ) 
  as RecId,
		a.Invoice,
-- !!!!!!!!!!!!!!!!!!! HAS TO BE SAME AS V_POS_ORDERS!!!!!!!!!!!!!!!!!
	rtrim( rtrim(a.SalesOrder) + '-' +
	isnull(a.PartnerId,a.VADId) + '-' +
	isnull(CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END
				, 'NoCustInfo')  + '-' +
	convert(char(10), a.InvoiceDate,112) ) + '-' +
	-- hack for  first record since this is how the sales Order group by works in OPTY_TRK
	'1'
	/*
	convert(Varchar(5),ROW_NUMBER() over (Partition by
		rtrim( rtrim(a.SalesOrder) + '-' +
		isnull(a.PartnerId,a.VADId) + '-' +
		isnull(a.EndCust, 'NoCustInfo')  + '-' +
		convert(char(10), InvoiceDate,112) )
	  order by a.EndCustName)	) */
	as SalesOrder, 

		a.OrderType,
		ISNULL(a.SalesPoolId,b.AxTerritory) as AxTerritory, 
		a.NetSalesUSD,
		--a.NetSalesLocalCurrency,
		a.InvoiceDate,
		c.SKU,
		a.RevType,
		a.CurrencyCode,
		a.NetSalesLocalCurrency,
		a.EndCust as CustomerId,
		isnull(a.PartnerId,a.VADId) as PartnerId,
		a.SalesOrder as VAD_SO -- in case needed
		,ROW_NUMBER() over (Partition by
		rtrim( rtrim(a.SalesOrder) + '-' +
		isnull(a.PartnerId,a.VADId) + '-' +
		isnull(CASE WHEN ISNUMERIC(EndCust) = 1 then EndCust ELSE null END
						, 'NoCustInfo')  + '-' +
		convert(char(10), InvoiceDate,112) )
	  order by a.EndCustName)	 as rn,
			CASE WHEN RevType IN ('Support','Service','N/A') THEN NetSalesUSD*.5
				ELSE NetSalesUSD-(QTY*ItemCost) END AS Margin,
				-- Postal Code for territory matching
					CASE WHEN LEN (
					rtrim(substring(ShipPostalCode, 0 ,6) ) 
					) = 4 THEN '0' + rtrim(substring(ShipPostalCode, 0 ,6) ) 
					else rtrim(substring(ShipPostalCode, 0 ,6) )  END
					 as	ShipPostalCode,
	  a.VADId,
	  a.NetSalesPlanRate
	--a.QTY
 from POS_AXBILLINGS_COMBINED a left outer join
	  SFDC_SAP_AX_ID_MAP m on a.PartnerId = convert(VarChar(15),m.OtherERPNo) left outer join
      SFDC_PARTNERS b on  convert(VarChar(15),m.ShoreTelId_SAP) = b.ImpactNumber collate database_default  left outer join
	  -- to filter out bad data. Will set null
	  --SFDC_PRICEBOOK_ENTRY c on a.SKU = c.SKU collate database_default
	  AX_ITEMS c on a.SKU = c.SKU
where  a.Source='POS'
--and a.PartnerId is not null -- fixed in select
and a.SalesOrder is not null -- ING file is screwed up sometimes
and a.SKU NOT IN (
'55000',
'55003',
'55004',
'93154',
'93192'
) 
and 
-- MW 08022016 if you update the date update the audit process so that date is after this one.  !!!!!!!!!!!!!!!!!!
InvoiceDate >=  convert(Char(10), '04/01/2016',101)  
-- NO Point
AND a.NetSalesUSD != 0
--ANd SalesOrder Like 'ZD%'
-- ING Enable on 5-18-2016 MW
--AND a.VADID != '736458'

/*

Update For Audit
 Update SFDC_POS_BILLING_TRK 
 set 	NetSalesUSD = b.NetSalesUSD,
		NetSalesLocalCurrency =b.NetSalesLocalCurrency,
		Margin =b.Margin,
		NetSalesPlanRate =b.NetSalesPlanRate,
		ErrorMsg = '',
		Status = 'N' from
 SFDC_POS_BILLING_TRK a inner join
 (
 select 
		a.RecId,
		a.NetSalesUSD,
		a.NetSalesLocalCurrency
		,a.Margin
		,a.NetSalesPlanRate
		-- Im SO fancy, trying insert of NET NEW another way
	FROM V_SFDC_POS_BILLINGS a inner Join
		 SFDC_POS_BILLING_TRK b on a.RecId = b.RecId
where --a.InvoiceDate > convert(Char(10), '10/01/2015',101) and   
b.Status = 'X'
) b on a.RecId = b.RecId

*/



























