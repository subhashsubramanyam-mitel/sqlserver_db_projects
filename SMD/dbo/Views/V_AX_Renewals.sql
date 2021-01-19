


CREATE View  [dbo].[V_AX_Renewals] AS



SELECT 
      p.[OrderDate]
      ,p.[Invoice]
      --,[VADId]
      --,[VADName]
      ,p.[InvoiceDate]
      ,p.[SalesOrder]
      ,p.[CustomerPo]
      ,p.BillTo as 'BillToId'
	  ,p.[BillToName]
      ,p.[EndCust]
      ,p.[EndCustName]
      ,p.[SKU]
	  ,p.[ItemDesc]
      ,p.[QTY]

      ,p.[NetSalesUSD]
      ,p.[ShipPostalCode]
      ,p.[ShipCity]
      ,p.[ShipState]
      ,p.[ShipCountry]
      ,p.[OrigSalesOrder]
      ,p.[OrderType]
      ,p.IVARId as 'Reseller Id'
      ,p.IVARName as 'Reseller'
      ,p.NetSalesUSD as SC_Billings
      ,null as ItemCost
      ,p.[RequestedShipDate]
      ,p.[SalesPoolId]
      ,t.[Theatre]
      ,t.[Region]
,p.NetSalesLocalCurrency as ExtendedNetPriceLocal
,p.[CurrencyCode]
,p.IVARId as 'ResellerId'
,p.IVARName as 'ResellerName'
  FROM  AX_BILLINGS p left outer join
 -- join [SVLCORPAXDB1].PROD.dbo.SALESTABLE S
  -- ON S.SALESID= p.SalesOrder
SFDC_TERRITORY t on p.SalesPoolId = t.AXCode collate database_default
  where[OrderType] in ( 'S', 'SR')
--and source = 'AX'






