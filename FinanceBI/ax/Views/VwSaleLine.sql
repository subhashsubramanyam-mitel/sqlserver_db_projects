









CREATE View [ax].[VwSaleLine] as
select 
	CASE WHEN SL.SEMPOSTINGORDERTYPE = 'SKY-CR' THEN
		CAST(SL.RECID As bigint)*100000+BC.Id*10+2 -- 2 suffix means SKY Credits (manual)
	WHEN SL.ITEMID = '758-0028' THEN
		CAST(SL.RECID As bigint)*100000+BC.Id*10+4 -- 3 suffix means Courtesy Credit (manual)
	ELSE 
		CAST(LI.LineItemId as bigint)*100000+BC.Id*10+0 -- 0 suffix means non-tax line item
	End
		as AxId,
	LI.LineItemId LineItemId, -- can be null for Manual credits
	CASE WHEN SL.NAME like 'IP Phone%' THEN 1 
		 WHEN SL.NAME like 'Internet Access%' THEN 3
		 ELSE LI.ProductId
		 End as ProductId, 
	SL.STCLOUDCHECKSUM KitChecksumValue,
	SL.ITEMID	AxItemid,
	SL.SALESPRICE SalesPrice,
	SL.SALESQTY SalesQty,
	Convert(date, dbo.UfnFirstOfMonth (SL.SHIPPINGDATEREQUESTED)) InvoiceMonth,
	CASE WHEN SL.SEMPOSTINGORDERTYPE = 'SKY-CR' or SL.ITEMID = '758-0028' THEN SL.SHIPPINGDATEREQUESTED
	   ELSE Convert(date, SL.STCLOUDDATEPERIODSTART) End DatePeriodStart,
	CASE WHEN SL.SEMPOSTINGORDERTYPE = 'SKY-CR' or SL.ITEMID = '758-0028' THEN SL.SHIPPINGDATEREQUESTED
	   ELSE Convert(date, SL.STCLOUDDATEPERIODEND) End DatePeriodEnd,
	SL.Name, 
	CASE WHEN coalesce(SL.STCLOUDLOCATIONID,0) = 0 THEN IGL.DefaultLocationId 
		ELSE SL.STCLOUDLOCATIONID End 
		as LocationId,
	null Addressid,
	SL.DeliveryCity City,
	SL.DeliveryState [State],
	SL.DeliveryZipCode ZipCode,
	SL.DeliveryCountryRegionId Country,
	'N/A' Jurisdiction,
	NULLIF(NULLIF(coalesce(I.Id,LI.InvoiceId), ''), '0') InvoiceId,
	IG.Id InvoiceGroupId,
	null ServiceGroupName,
	CASE WHEN ( IG.BillingContactId = 0 OR IG.BillingContactId IS NULL )
         THEN NULL
         ELSE PE.FirstName + ' ' + PE.LastName 
       END AS BillingContact,
	Coalesce(BC.Id, LI.BillingCategoryId) as BillingCategoryId,
	CASE WHEN SL.SEMPOSTINGORDERTYPE = 'SKY-CR' THEN 'Credit - Manual'
		 WHEN SL.ITEMID = '758-0028' THEN 'Credit - Courtesy'
		ELSE LI.ChargeCategory 
		END as	ChargeCategory,
	CASE WHEN SL.SEMPOSTINGORDERTYPE = 'SKY-CR' or SL.ITEMID = '758-0028' 
		 THEN dbo.UfnFirstOfMonth(SL.SHIPPINGDATEREQUESTED)
	   ELSE dbo.UfnFirstOfMonth(DateAdd(day, -1, SL.STCLOUDDATEPERIODEND)) End as ServiceMonth,
	SL.LINEAMOUNT Amount,
	SL.CURRENCYCODE CurrencyCode,
	SL.DIMENSION2_ ProfitCenter,
	SL.SALESID AxSalesId,
	SL.LINENUM AxLineNum,
	SL.RECVERSION,
	SL.RECID
from ax.SalesLine SL
	left join enum.BillingCategory BC on BC.Name = SL.NAME
 inner join ax.SalesTable ST on ST.SALESID = SL.SALESID 
 inner join ax.CustTable CT on CT.ACCOUNTNUM = SL.CUSTACCOUNT 
 inner join company.InvoiceGroup IG on ISNUMERIC(CT.STCLOUDINVOICEID)=1 and  IG.Id =  CT.STCLOUDINVOICEID
 left join people.Person PE on PE.Id = IG.BillingContactid 
left join invoice.VwLineItem_EX LI on ( LI.LineItemId =
			CASE WHEN coalesce(SL.STPARENTLINEITEMID,0) = 0 THEN SL.STCLOUDLINEITEMID ELSE SL.STPARENTLINEITEMID END )
left join company.VwDefaultInvoiceGroupLocation IGL on IGL.InvoiceGroupId = IG.Id
left join invoice.Invoice I on I.InvoiceGroupId = IG.Id and dbo.UfnFirstOfMonth(I.DateGenerated) = dbo.UfnFirstOfMonth(SL.ShippingDateREquested)
where SL.SHIPPINGDATEREQUESTED >= '2017-01-01'
and ( SL.SEMPOSTINGORDERTYPE = 'SKY-CR' -- manual credit
		or SL.ITEMID = '758-0028' --- courtesy credit
		or coalesce(SL.STCLOUDLINEITEMID,'') <> '')










