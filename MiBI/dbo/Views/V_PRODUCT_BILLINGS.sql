
CREATE VIEW [dbo].[V_PRODUCT_BILLINGS]
AS
SELECT     dbo.CUSTOMER_PRODUCT_DATA.OrderDate, dbo.CUSTOMER_PRODUCT_DATA.ShipDate, dbo.CUSTOMER_PRODUCT_DATA.SalesOrder, 
                      dbo.CUSTOMER_PRODUCT_DATA.Quarter, dbo.CUSTOMER_PRODUCT_DATA.ImpactNumber, dbo.CUSTOMER_PRODUCT_DATA.InvoiceNumber, 
                      dbo.CUSTOMER_PRODUCT_DATA.PartnerG, dbo.CUSTOMER_PRODUCT_DATA.CustGroupDesc, dbo.CUSTOMER_PRODUCT_DATA.CustSoldToName, 
                      dbo.CUSTOMER_PRODUCT_DATA.EndCustName, dbo.CUSTOMER_PRODUCT_DATA.Size, dbo.CUSTOMER_PRODUCT_DATA.Employees, 
                      dbo.CUSTOMER_PRODUCT_DATA.Vertical, dbo.CUSTOMER_PRODUCT_DATA.SIC, dbo.CUSTOMER_PRODUCT_DATA.REVtype, 
                      dbo.CUSTOMER_PRODUCT_DATA.TYPE, dbo.CUSTOMER_PRODUCT_DATA.GMFamily, dbo.CUSTOMER_PRODUCT_DATA.EndCustBuild, 
                      dbo.CUSTOMER_PRODUCT_DATA.StockCode, dbo.CUSTOMER_PRODUCT_DATA.Sku, dbo.CUSTOMER_PRODUCT_DATA.STRelease, 
                      dbo.CUSTOMER_PRODUCT_DATA.NetUSD, dbo.CUSTOMER_PRODUCT_DATA.ListPrice, dbo.CUSTOMER_PRODUCT_DATA.PromoPrice, 
                      dbo.CUSTOMER_PRODUCT_DATA.StdCost, dbo.CUSTOMER_PRODUCT_DATA.EndCust, dbo.CUSTOMER_PRODUCT_DATA.StockCodeDesc, 
                      dbo.CUSTOMER_PRODUCT_DATA.Qty, dbo.CUSTOMER_PRODUCT_DATA.StdCogsUSD, dbo.CUSTOMER_PRODUCT_DATA.StdMgnUSD, 
                      dbo.CUSTOMER_PRODUCT_DATA.ProductClass, dbo.CUSTOMER_PRODUCT_DATA.SalesArea, dbo.CUSTOMER_PRODUCT_DATA.RVP, 
                      dbo.CUSTOMER_PRODUCT_DATA.RD, dbo.CUSTOMER_PRODUCT_DATA.RegionArea, dbo.CUSTOMER_PRODUCT_DATA.Channel, 
                      dbo.CUSTOMER_PRODUCT_DATA.Fyear, dbo.CUSTOMER_PRODUCT_DATA.Fquarter, dbo.CUSTOMER_PRODUCT_DATA.FiscalMonth, 
                      dbo.CUSTOMER_PRODUCT_DATA.Country, dbo.CUSTOMER_PRODUCT_DATA.ShipState, dbo.CUSTOMER_PRODUCT_DATA.ShipCity, 
                      dbo.CUSTOMER_PRODUCT_DATA.CustomerPo, dbo.CUSTOMER_PRODUCT_DATA.OrderType, dbo.PRODUCT_LINE_GS.BusinessLine, 
                      dbo.PRODUCT_LINE_GS.Category, dbo.CUSTOMER_PRODUCT_DATA.PartnerCsn, dbo.CUSTOMER_PRODUCT_DATA.CustomerCsn,
						c.SupportType, dbo.PRODUCT_LINE_GS.Cogs
FROM         dbo.CUSTOMER_PRODUCT_DATA LEFT OUTER JOIN
                      dbo.PRODUCT_LINE_GS ON dbo.CUSTOMER_PRODUCT_DATA.StockCode = dbo.PRODUCT_LINE_GS.StockCode left outer join
			CUSTOMERS c on dbo.CUSTOMER_PRODUCT_DATA.ImpactNumber = c.ImpactNumber  --JO 07172014 changed to ImpactNumber
GO
GRANT SELECT
    ON OBJECT::[dbo].[V_PRODUCT_BILLINGS] TO [PMData]
    AS [dbo];


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
         Begin Table = "CUSTOMER_PRODUCT_DATA"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 286
               Right = 199
            End
            DisplayFlags = 280
            TopColumn = 29
         End
         Begin Table = "PRODUCT_LINE_GS"
            Begin Extent = 
               Top = 6
               Left = 237
               Bottom = 114
               Right = 391
            End
            DisplayFlags = 280
            TopColumn = 0
         End
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PRODUCT_BILLINGS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PRODUCT_BILLINGS';

