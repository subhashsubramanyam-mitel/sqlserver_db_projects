create View invoice.VwAvaTaxLine as
select 
	CAST(TL.LineItemId as bigint)*100000+BC.Id*10+5 -- 5 is tax/surcharge prefix
		as AxId,
	TL.LineItemId LineItemId,
	null ProductId, 
	0 KitChecksumValue,
	'AVATAX'	AxItemid,
	TL.Charge SalesPrice,
	1 SalesQty,
	Convert(date, dbo.UfnFirstOfMonth (TL.DateGenerated)) InvoiceMonth,
	Convert(date, TL.DatePeriodStart_Local) DatePeriodStart,
	Convert(date, TL.DatePeriodEnd_Local) DatePeriodEnd,
	BC.Name, 
	TL.LocationId LocationId,
	null Addressid,
	cast(null as nvarchar(100)) City,
	cast(null as nvarchar(30)) [State],
	cast(null as nvarchar(10)) ZipCode,
	cast(null as nvarchar(30)) Country,
	cast('N/A' as nvarchar(16)) Jurisdiction,
	null InvoiceId,
	IG.Id InvoiceGroupId,
	null ServiceGroupName,
	CASE WHEN ( IG.BillingContactId = 0 OR IG.BillingContactId IS NULL )
         THEN NULL
         ELSE PE.FirstName + ' ' + PE.LastName 
       END BillingContact,
	BC.Id 	BillingCategoryId,
	TL.ChargeCategory 	ChargeCategory,
	dbo.UfnFirstOfMonth(DateAdd(month, -1, TL.DateGenerated)) as ServiceMonth,
	TL.Charge Amount,
	'USD' CurrencyCode,
	'7505' ProfitCenter,
	'' AxSalesId,
	0 AxLineNum,
	0 RECVESION,
	0 RECID
from invoice.VwTaxItem TL
	left join enum.BillingCategory BC on BC.Name = 'Taxes'
 inner join company.InvoiceGroup IG on  IG.Id =  TL.InvoiceGroupId
 left join people.Person PE on PE.Id = IG.BillingContactid 
where TL.DateGenerated between '2013-07-01' and '2014-05-28'
