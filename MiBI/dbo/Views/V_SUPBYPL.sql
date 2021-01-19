

/*where a.CustomerSupportType like '%Shared%'*/
CREATE VIEW [dbo].[V_SUPBYPL]
AS
SELECT     t.FQuarter,
			t.theMonth, 
a.CustomerName, 
c.NAME AS Partner, 
a.CustomerSupportType, 
b.ProductLine, 
a.ShipQty, 
a.ListPrice, 
ISNULL(c.SupportPrice / 100, 0) 
                      AS SupportPrice,
 (CASE WHEN (a.CustomerSupportType LIKE '%NP' AND b.ProductLine LIKE '%phones%') 
 THEN 0 WHEN (a.CustomerSupportType LIKE '%Shared%' AND (b.ProductLine LIKE '%Contact Center%' OR
                      b.ProductLine LIKE '%Mobility%')) THEN (a.ShipQty * a.ListPrice) * .115 WHEN a.CustomerSupportType LIKE 'Partner%' THEN (a.ShipQty * a.ListPrice) 
                      * isnull(c.SupportPrice / 100, 0) WHEN a.CustomerSupportType LIKE 'Enterprise%' THEN (a.ShipQty * a.ListPrice) * .115 ELSE 0 END) 
                      * d.Term * d.Disc AS SupportCost, a.PONum AS PO,
                      a.SKU, a.Description,
			t.FQuarter as CurrentQuarter,
			t.theMonth as CurrentMonth
FROM         dbo.CUSTOMER_ASSETS AS a INNER JOIN
                          (SELECT     ISNULL(CustomerRowId, '-') AS CustomerRowId, ISNULL(SUM(CASE WHEN (CustomerSupportType LIKE '%NP' AND 
                                                   ProductLine = 'Phones') THEN 0 ELSE (ShipQty * ListPrice) END), 1) AS SupportBase
                            FROM          dbo.CUSTOMER_ASSETS
                            WHERE      (Status = 'Production')
                            GROUP BY CustomerRowId) AS aa ON a.CustomerRowId = aa.CustomerRowId INNER JOIN
                      dbo.PRODUCT_LINE AS b ON a.SKU = b.sku LEFT OUTER JOIN
                      dbo.RESELLER AS c ON a.PartnerRowId = c.Partner_Csn INNER JOIN
                      dbo.V_SUPPORT_CALC AS d ON a.CustomerRowId = d.End_User_Csn INNER JOIN
                      dbo.TimeLookup AS t ON CONVERT(Char(10), a.ShipDate, 101) = CONVERT(CHAR(10), t.theDate, 101) inner join
					  dbo.TimeLookup AS tt ON CONVERT(Char(10),  getdate(), 101) = CONVERT(CHAR(10), tt.theDate, 101)



GO
GRANT SELECT
    ON OBJECT::[dbo].[V_SUPBYPL] TO [CANDY\srahman]
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
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "aa"
            Begin Extent = 
               Top = 6
               Left = 264
               Bottom = 84
               Right = 421
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 459
               Bottom = 114
               Right = 610
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 84
               Left = 264
               Bottom = 192
               Right = 415
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 207
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 114
               Left = 453
               Bottom = 222
               Right = 605
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
        ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SUPBYPL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Output = 720
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SUPBYPL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SUPBYPL';

