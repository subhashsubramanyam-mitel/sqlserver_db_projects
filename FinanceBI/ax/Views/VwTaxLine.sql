






CREATE View [ax].[VwTaxLine] as
select 
	CAST(LI.LineItemId as bigint)*100000+BC.Id*10+5 -- 5 is tax/surcharge prefix
		as AxId,
	LI.LineItemId LineItemId,
	CASE WHEN LI.ChargeCategory = 'Usage' THEN 1029 --'Tax' 
		 WHEN BC.GroupName = 'Tax' THEN 1029 -- 'Tax'
		 WHEN BC.GroupName = 'Surcharge' THEN 1032 -- 'Surcharge'
		ELSE null
		END	ProductId,
	SL.STCLOUDCHECKSUM KitChecksumValue,
	'T-'+TL.TAXTYPECODE	AxItemid,
	TL.TaxAMOUNT SalesPrice,
	1 SalesQty,
	Convert(date, dbo.UfnFirstOfMonth (SL.SHIPPINGDATEREQUESTED)) InvoiceMonth,
	Convert(date, SL.STCLOUDDATEPERIODSTART) DatePeriodStart,
	Convert(date, SL.STCLOUDDATEPERIODEND) DatePeriodEnd,
	TL.TAXTYPEDESC, 
	SL.STCLOUDLOCATIONID LocationId,
	null Addressid,
	coalesce(TL.City, SL.DeliveryCity) City,
	CASE WHEN coalesce(TL.State, SL.DeliveryState) = 'ZZ' then null 
		ELSE coalesce(TL.State, SL.DeliveryState) END [State],
	SL.DeliveryZipCode ZipCode,
	SL.DeliveryCountryRegionId Country,
	CASE 
		WHEN Substring(TL.TAXTYPECODE,1, 1) = '0' THEN 'Federal'
		WHEN Substring(TL.TAXTYPECODE,1, 1) = '1' THEN 'State'
		WHEN Substring(TL.TAXTYPECODE,1, 1) = '2' THEN 'County'
		WHEN Substring(TL.TAXTYPECODE,1, 1) = '3' THEN 'City'
		WHEN Substring(TL.TAXTYPECODE,1, 1) = '4' THEN 'Local'
		WHEN Substring(TL.TAXTYPECODE,1, 1) = '5' THEN 'Reporting Agency'
		ELSE 'Unknown'
	END Jurisdiction,
	NULLIF(NULLIF(coalesce(I.Id,LI.InvoiceId), ''), '0') InvoiceId,
	IG.Id InvoiceGroupId,
	null ServiceGroupName,
	CASE WHEN ( IG.BillingContactId = 0 OR IG.BillingContactId IS NULL )
         THEN NULL
         ELSE PE.FirstName + ' ' + PE.LastName 
       END AS BillingContact,
	CASE WHEN LI.ChargeCategory = 'Usage' THEN 1499 ELSE BC.Id END	BillingCategoryId,
	CASE WHEN LI.ChargeCategory = 'Usage' THEN 'Tax' ELSE BC.GroupName END	ChargeCategory,
	dbo.UfnFirstOfMonth(DateAdd(day, -1, SL.STCLOUDDATEPERIODEND)) as ServiceMonth,
	TL.TAXAMOUNT Amount,
	SL.CURRENCYCODE CurrencyCode,
	SL.DIMENSION2_ ProfitCenter,
	SL.SALESID AxSalesId,
	SL.LINENUM AxLineNum,
	TL.RECVERSION,
	TL.RECID
from ax.TaxLine TL
	left join enum.BillingCategory BC on BC.Name = TL.TAXTYPEDESC
inner join ax.TaxTable TT on TT.SALESID  = TL.SALESID
 inner join ax.SalesLine SL on SL.SALESID = TL.SALESID and SL.LINENUM = TL.LINENUM
 inner join ax.SalesTable ST on ST.SALESID = SL.SALESID 
 inner join ax.CustTable CT on CT.ACCOUNTNUM = SL.CUSTACCOUNT 
 inner join company.InvoiceGroup IG on ISNUMERIC(CT.STCLOUDINVOICEID)=1 and IG.Id =  CT.STCLOUDINVOICEID
 left join people.Person PE on PE.Id = IG.BillingContactid 
 left join invoice.VwLineItem_EX LI on ( LI.LineItemId =
			CASE WHEN coalesce(SL.STPARENTLINEITEMID,0) = 0 THEN SL.STCLOUDLINEITEMID ELSE SL.STPARENTLINEITEMID END )
-- 11/27/2016 LineItemId is not always present
left join invoice.Invoice I on I.InvoiceGroupId = IG.Id and dbo.UfnFirstOfMonth(I.DateGenerated) = dbo.UfnFirstOfMonth(SL.ShippingDateREquested)
where SL.SHIPPINGDATEREQUESTED >= '2017-01-01' 
and (TL.CUSTINVOICEID like 'IN-%' or TL.CUSTINVOICEID like 'CM-%')
and SL.STCLOUDLINEITEMID is not null and SL.STCLOUDLINEITEMID <> ''







