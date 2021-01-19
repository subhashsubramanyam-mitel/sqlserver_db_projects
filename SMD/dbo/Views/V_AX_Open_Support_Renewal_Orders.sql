
CREATE View [dbo].[V_AX_Open_Support_Renewal_Orders]
as

SELECT 
  p.[SalesOrder]
  ,p.[OrderDate]
  ,p.[BillTo]
  ,p.[BillToName]
     ,p.[EndCustomer]
	 ,p.[EndCustomerName]
      ,p.[SKU]
      --,p.[ItemDesc]
        ,p.[BookedUSD]
      ,p.[ShipPostalCode]
      ,p.[ShipCity]
      ,p.[ShipState]
      ,p.[ShipCountry]
      --,p.[OrigSalesOrder]
      ,p.[OrderType]
      --,p.[PartnerId] as 'Reseller Id'
      --,p.[Partner] as 'Reseller'
      --,p.[SC_Billings]
      --,p.[ItemCost]
      --,p.[RequestedShipDate]
      ,p.[SalesPoolId]
      --,p.[Theatre]
      --,p.[Region]
         ,s.PurchOrderFormID
		 ,s.SemSuppRenewDate as 'SupportStartDate'
,s.SemSuppCoTermDate as 'SupportEndDate'

--,p.[ExtendedNetPriceLocal]
--,p.[CurrencyCode]
,S.SEMRESELLERACCT as 'ResellerId'
, S.SEMResellerName as 'ResellerName'
,s.PurchOrderFormID as 'EDI form Id'
  FROM
  [dbo].[AX_BOOKINGS] p
  -- [dbo].[PM_SALESDATA] p
  join [SVLCORPAXDB1].PROD.dbo.SALESTABLE S
   ON S.SALESID= p.SalesOrder
  where[OrderType] in ( 'S', 'SR')
--and source = 'AX'
and s.PurchOrderFormID <> ''
--order by      p.[OrderDate] desc

