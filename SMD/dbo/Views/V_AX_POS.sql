



CREATE VIEW [dbo].[V_AX_POS]
AS
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT     
	'AX' As Source,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.OrderDate) as OrderDate, 
	a.OrderDate,
	a.Invoice, 
	NULL AS VADId, 
	NULL AS VADName,
	a.InvoiceDate,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.InvoiceDate) as InvoiceDate, 
	a.SalesOrder, 
	a.CustomerPo, 
	a.BillTo AS ImpactNumber, 
	a.BillToName, 
	a.EndCust, 
	a.EndCustName, 
	a.SKU, 
	a.QTY, 
	a.NetSalesUSD, 
	a.ShipPostalCode, 
	a.ShipCity, 
	a.ShipState, 
	a.ShipCountry, 
	a.StockCode, 
	a.ItemDesc,
	a.CUSTGROUP,
    a.OrigSalesOrder,
    a.OrderType,
	b.GmFamily as GMFamily,
-- Parter Group is COE Account from SFDC
c.PartnerGId,
c.PartnerG,
CASE 
WHEN a.AxRevType = 0 THEN 'N/A'
WHEN a.AxRevType = 1 THEN 'Product'
WHEN a.AxRevType = 2 THEN 'Freight'
WHEN a.AxRevType = 3 THEN 'Service'
WHEN a.AxRevType = 4 THEN 'Support'
WHEN a.AxRevType = 5 THEN 'Cloud MRR'
WHEN a.AxRevType = 6 THEN 'Cloud NRR'
else 'N/A'
end as  RevType,
a.BillTo as PartnerId,
a.BillToName as Partner,
a.InvoiceDateUTC as AX_InvoiceDateUTC,
a.ItemGroupName,
NetSalesUSD as SC_Billings,
isnull(i.ItemCostCurrent,0) as ItemCost,
RequestedShipDate,
SalesPoolId,   -- <--------  !!!!!!!!!!!!!!!!!!!!!!!! This is at time of order!  MW 02202015
a.EndCustCreateDate,
-- MW 03042015 Adding currency Info
a.CurrencyCode,
a.NetSalesLocalCurrency
--,a.BossInvoiceGroupId
-- MW 01202017  Adding correct var logic for partner dashboard
,CASE WHEN isnumeric(IVARId) = 0 Then BillTo else IVARId end as SC_VARId
--PM Add Itemsubtype to the table
,P.ItemSubType,
--MW 09082017  Adding here instead of add column
CAST(a.InvoiceDate AS DATE) as InvoiceDate_DateFormat,
	   CASE
        WHEN MONTH(a.InvoiceDate ) BETWEEN 1  AND 3  THEN convert(char(4), YEAR(a.InvoiceDate) ) + '-Q3'
        WHEN MONTH(a.InvoiceDate) BETWEEN 4  AND 6  THEN convert(char(4), YEAR(a.InvoiceDate) ) + '-Q4'
        WHEN MONTH(a.InvoiceDate) BETWEEN 7  AND 9  THEN convert(char(4), YEAR(a.InvoiceDate) + 1) + '-Q1'
        WHEN MONTH(a.InvoiceDate) BETWEEN 10 AND 12 THEN convert(char(4), YEAR(a.InvoiceDate) + 1) + '-Q2'
    END  as FYQuarter,
	NetSalesUSD as NetSalesPlanRate
FROM         
SMD.dbo.AX_BILLINGS a left outer join
PRODUCT_LINE b on a.Sku = b.Sku left outer join
V_PARTNERG c on a.BillTo	= c.PartnerId collate database_default left outer join
AX_ITEMS i on a.SKU = i.Sku
left outer join [dbo].[SFDC_PRODUCTS] P 
on P.SKU = a.sku collate database_default
where a.InvoiceDate >= CONVERT(CHAR(10),'10-1-2013',101)
--<PM>Remove VAD stocking orders from load
and a.BillTo not in ( '51746', '736458','735129') 
UNION ALL
SELECT 'POS' as Source ,
	  null as OrderDate
	  ,[Invoice]
      ,[VADId]
      ,VADName
      ,[InvoiceDate]
      ,[SalesOrder]
      ,[CustomerPO]
      ,[ImpactNumber]
      ,[PartnerName]
      ,[CustomerId]
      ,[CustomerName]
      ,a.[Sku]
      ,[Qty]
      ,[Billings]
      ,[ShipPostalCode]
      ,[ShipCity]
      ,[ShipState]
      ,[ShipCountry]
      ,[StockCode]
      ,[StockCodeDesc] ,
      CUSTGROUP,
      [SalesOrder] as OrigSalesOrder,
      'POS' as OrderType
       ,a.GMFamily,
       PartnerGId,
       PartnerG,
       CASE 
WHEN [AxRevType] = 0 THEN 'N/A'
WHEN [AxRevType] = 1 THEN 'Product'
WHEN [AxRevType] = 2 THEN 'Freight'
WHEN [AxRevType] = 3 THEN 'Service'
WHEN [AxRevType] = 4 THEN 'Support'
WHEN [AxRevType] = 5 THEN 'Cloud MRR'
WHEN [AxRevType] = 6 THEN 'Cloud NRR'
else 'invalidSKU'
end as  RevType,
      [ImpactNumber] As PartnerId,
      [PartnerName] as Partner,
      DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), InvoiceDate) as AX_InvoiceDateUTC,
       ItemGroupName,
       --ScorecardBillings
       (Billings + (Billings*.105)) as SC_Billings,
     ItemCostCurrent as ItemCost,
[InvoiceDate]as RequestedShipDate,
null as SalesPoolId,
null as EndCustCreateDate ,
-- MW 03042015 Adding currency Info
CurrencyCode,
LocalBillings  as NetSalesLocalCurrency
--null as BossInvoiceGroupId
-- MW 01202017  Adding correct var logic for partner dashboard
, [ImpactNumber] as SC_VARId
--PM Add Itemsubtype to the table
,P.ItemSubType,
--MW 09082017  Adding here instead of add column
CAST(InvoiceDate AS DATE) as InvoiceDate_DateFormat,
	   CASE
        WHEN MONTH(InvoiceDate ) BETWEEN 1  AND 3  THEN convert(char(4), YEAR(InvoiceDate) ) + '-Q3'
        WHEN MONTH(InvoiceDate) BETWEEN 4  AND 6  THEN convert(char(4), YEAR(InvoiceDate) ) + '-Q4'
        WHEN MONTH(InvoiceDate) BETWEEN 7  AND 9  THEN convert(char(4), YEAR(InvoiceDate) + 1) + '-Q1'
        WHEN MONTH(InvoiceDate) BETWEEN 10 AND 12 THEN convert(char(4), YEAR(InvoiceDate) + 1) + '-Q2'
    END  as FYQuarter,
	Billings as NetSalesPlanRate

  FROM [SMD].[dbo].[V_POS_ALL] a
  left outer join [dbo].[SFDC_PRODUCTS] P 
on P.SKU = a.sku collate database_default
  where InvoiceDate  >= CONVERT(CHAR(10),'10-1-2013',101)
  
         




























GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_AX_POS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_AX_POS';

