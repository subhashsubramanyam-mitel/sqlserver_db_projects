CREATE VIEW dbo.V_SYED_CUST
AS
SELECT     a.OrderDate, a.ShipDate, a.SalesOrder, a.Quarter, a.InvoiceNumber, a.PartnerG, a.CustGroupDesc, a.CustSoldToName, a.EndCustName, a.Size, 
                      a.Employees, a.Vertical, a.SIC, a.REVtype, a.TYPE, a.GMFamily, a.EndCustBuild, a.StockCode, a.Sku, a.STRelease, a.NetUSD, a.ListPrice, 
                      a.PromoPrice, a.StdCost, a.EndCust, a.StockCodeDesc, a.Qty, a.StdCogsUSD, a.StdMgnUSD, a.ProductClass, a.SalesArea, a.RVP, a.RD, a.RegionArea, 
                      a.Channel, a.Fyear, a.Fquarter, a.FiscalMonth, a.Country, a.ShipState, a.ShipCity, a.CustomerPo, a.OrderType, b.ProductLine, 
                      dbo.RESELLER.Type AS PartnerType, dbo.RESELLER.ImpactNumber AS VarId, dbo.RESELLER.NAME AS VarName, dbo.RESELLER.ChampLevel
FROM         dbo.RESELLER INNER JOIN
                      dbo.AX_SALESDATA ON dbo.RESELLER.ImpactNumber = dbo.AX_SALESDATA.VarId RIGHT OUTER JOIN
                      dbo.CUSTOMER_PRODUCT_DATA AS a ON dbo.AX_SALESDATA.SalesOrder = a.SalesOrder LEFT OUTER JOIN
                      dbo.PRODUCT_LINE AS b ON a.StockCode = b.StockCode

GO
GRANT SELECT
    ON OBJECT::[dbo].[V_SYED_CUST] TO [CANDY\srahman]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[58] 4[5] 2[20] 3) )"
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
         Begin Table = "a"
            Begin Extent = 
               Top = 0
               Left = 19
               Bottom = 228
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RESELLER"
            Begin Extent = 
               Top = 6
               Left = 426
               Bottom = 234
               Right = 577
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 215
               Left = 110
               Bottom = 323
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AX_SALESDATA"
            Begin Extent = 
               Top = 28
               Left = 217
               Bottom = 293
               Right = 368
            End
            DisplayFlags = 280
            TopColumn = 3
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SYED_CUST';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SYED_CUST';

