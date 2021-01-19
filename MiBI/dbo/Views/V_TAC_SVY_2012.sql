
CREATE VIEW [dbo].[V_TAC_SVY_2012]
AS
SELECT     dbo.TAC_SVY_2012.Id, dbo.TAC_SVY_2012.FIELD2, dbo.TAC_SVY_2012.FIELD3, dbo.TAC_SVY_2012.FIELD4, dbo.TAC_SVY_2012.FIELD5, 
                      dbo.TAC_SVY_2012.FIELD6, dbo.TAC_SVY_2012.FIELD7, dbo.TAC_SVY_2012.FIELD8, dbo.TAC_SVY_2012.FIELD9, dbo.TAC_SVY_2012.FIELD10, 
                      dbo.TAC_SVY_2012.FIELD11, dbo.TAC_SVY_2012.FIELD12, dbo.TAC_SVY_2012.FIELD13, dbo.TAC_SVY_2012.FIELD14, dbo.TAC_SVY_2012.FIELD15, 
                      dbo.TAC_SVY_2012.FIELD16, dbo.TAC_SVY_2012.FIELD17, dbo.TAC_SVY_2012.FIELD18, dbo.TAC_SVY_2012.FIELD19, dbo.TAC_SVY_2012.FIELD20, 
                      dbo.TAC_SVY_2012.FIELD21, dbo.TAC_SVY_2012.FIELD22, dbo.TAC_SVY_2012.FIELD23, dbo.TAC_SVY_2012.FIELD24, dbo.TAC_SVY_2012.FIELD25, 
                      dbo.TAC_SVY_2012.FIELD26, dbo.TAC_SVY_2012.FIELD27, dbo.TAC_SVY_2012.FIELD28, dbo.TAC_SVY_2012.FIELD29, dbo.TAC_SVY_2012.FIELD30, 
                      dbo.TAC_SVY_2012.FIELD31, dbo.TAC_SVY_2012.FIELD32, dbo.TAC_SVY_2012.FIELD33, dbo.TAC_SVY_2012.FIELD34, dbo.TAC_SVY_2012.FIELD35, 
                      dbo.TAC_SVY_2012.FIELD36, dbo.TAC_SVY_2012.FIELD37, dbo.TAC_SVY_2012.FIELD38, dbo.TAC_SVY_2012.FIELD39, dbo.TAC_SVY_2012.FIELD40, 
                      dbo.TAC_SVY_2012.FIELD41, dbo.TAC_SVY_2012.FIELD42, dbo.TAC_SVY_2012.FIELD43, dbo.TAC_SVY_2012.FIELD44, dbo.TAC_SVY_2012.FIELD45, 
                      dbo.TAC_SVY_2012.FIELD46, dbo.TAC_SVY_2012.FIELD47, dbo.TAC_SVY_2012.FIELD48, dbo.TAC_SVY_2012.FIELD49, 
                      dbo.SR_HEADER_SVY2.AccountId, dbo.SR_HEADER_SVY2.PartnerId
FROM         dbo.TAC_SVY_2012 LEFT OUTER JOIN
                      dbo.SR_HEADER_SVY2 ON dbo.TAC_SVY_2012.FIELD8 = dbo.SR_HEADER_SVY2.SR_NUM






GO
GRANT SELECT
    ON OBJECT::[dbo].[V_TAC_SVY_2012] TO [TacEngRole]
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
         Begin Table = "TAC_SVY_2012"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SR_HEADER"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 412
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_TAC_SVY_2012';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_TAC_SVY_2012';

