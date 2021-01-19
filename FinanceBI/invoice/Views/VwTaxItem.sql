create VIEW invoice.VwTaxItem
AS
SELECT     
	BC.Id as BillingCategoryId,
	null as LineItemId,
	1029 as ProductId, 
	InvoiceMonth as DateGenerated,
	null as InvoiceServiceGroupId, 
	Coalesce(L.Id, Loc.LocationId) as LocationId, 
	IG.AccountId, -- AccountId from IG instead of L
	IG.Id as InvoiceGroupId,
	IV.Id as InvoiceId,
	IV.DatePeriodStart_Local, 
	IV.DatePeriodEnd_Local, 
	TaxAmount as Charge,
	'Tax' as ChargeCategory,
	null as OneTimeCharge, 
	null as MonthlyCharge, 
	null as Prorates,
	null as MRR,  
	null as Usage,  
	null as Credits,  
	null as Regulatory,
	null as Surcharge,
	null as Unclassified,
	TaxAmount as Tax,
	null as FootnoteNumber, 
	0 as Quantity

FROM         invoice.GeneralLedger GL
left join   company.Location L on L.Id = GL.DefaultLocationId
inner join  invoice.Invoice IV on IV.Id = GL.InvoiceId
inner join	 company.InvoiceGroup IG on IG.Id = GL.InvoiceGroupId
inner join   (select InvoiceGroupId, Min(ID) as LocationId
				from company.Location
				group by InvoiceGroupId
			   ) Loc on Loc.InvoiceGroupId = GL.InvoiceGroupId
inner join   enum.BillingCategory BC on BC.Name = 'Taxes'
where DocDate < '2014-06-01'
