

 CREATE View [dbo].[V_PM_POS_DATA] as
 -- New POS For the PM_SALESDATA table --Post AX
 -- MW 05012018
 SELECT   
	   'POS' as Source,
	   a.OrderDate
      ,a.Invoice
      ,a.VADId
      ,a.VADName
      ,a.InvoiceDate
      ,a.SalesOrder
      ,a.CustomerPo
      ,a.ImpactNumber
      ,a.BillToName
      ,a.EndCust
      ,a.EndCustName
      ,a.SKU
      ,a.QTY
      ,a.NetSalesUSD
      ,a.ShipPostalCode
      ,a.ShipCity
      ,a.ShipState
      ,a.ShipCountry
      ,a.StockCode
      ,a.ItemDesc
      ,a.CUSTGROUP
      ,a.OrigSalesOrder
      ,a.OrderType
      ,a.GMFamily
      ,a.PartnerId as PartnerGId
      ,a.Partner  as PartnerG
      ,a.RevType
      ,a.PartnerId
      ,a.Partner
      ,a.AX_InvoiceDateUTC
      ,a.ItemGroupName
      ,a.SC_Billings
      ,a.ItemCost
      ,a.RequestedShipDate
      ,p.AxArea as SalesPoolId,
	  p.ChampLevel,
		c.Version_ph as CustomerVersion,
		p.Theatre,
		t.Region,
		c.Industry as CustomerVertical,
		c.SIC as CustomerVerticalClass,
		a.NetSalesLocalCurrency as ExtendedNetPriceLocal,
		a.CurrencyCode
  FROM   
	CI_POS_BILLINGS a left outer join  -- from 4/1 only
	SFDC_PARTNERS p on a.ImpactNumber = p.ImpactNumber collate database_default left outer join
	SFDC_TERRITORY t on p.AxArea = t.AxCode  collate database_default left outer join
	CUST_INFO c on a.EndCust = c.CustomerId collate database_default 
  where Source = 'POS'
