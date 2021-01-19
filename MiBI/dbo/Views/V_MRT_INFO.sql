CREATE VIEW dbo.V_MRT_INFO
AS
SELECT     TOP (100) PERCENT dbo.DEFECT_HEADER.Type, dbo.DEFECT_HEADER.Date_Open, dbo.DEFECT_DETAIL.DEFECT_NUM, 
                      dbo.DEFECT_HEADER.ABSTRACT, dbo.DEFECT_HEADER.FI, dbo.DEFECT_DETAIL.Status, dbo.DEFECT_DETAIL.Sub_Status, 
                      dbo.DEFECT_DETAIL.X_QAA_QAC_DATE, dbo.DEFECT_DETAIL.Due_Date, dbo.DEFECT_DETAIL.Risk, dbo.DEFECT_DETAIL.Correct_In, 
                      dbo.DEFECT_DETAIL.Change_List, dbo.DEFECT_DETAIL.Resolved_Date, dbo.DEFECT_DETAIL.MRT_LAST_UPDATE, dbo.DEFECT_DETAIL.TargetRel, 
                      dbo.DEFECT_DETAIL.Test_Engineer, dbo.DEFECT_DETAIL.Reviewed_by, dbo.DEFECT_DETAIL.Verified_Date, dbo.DEFECT_HEADER.Area
FROM         dbo.DEFECT_DETAIL INNER JOIN
                      dbo.DEFECT_HEADER ON dbo.DEFECT_DETAIL.DEFECT_NUM = dbo.DEFECT_HEADER.DEFECT_NUM
ORDER BY dbo.DEFECT_DETAIL.MRT_LAST_UPDATE DESC

GO
GRANT SELECT
    ON OBJECT::[dbo].[V_MRT_INFO] TO [CANDY\VDelacruz]
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
         Begin Table = "DEFECT_DETAIL"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEFECT_HEADER"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 114
               Right = 409
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_MRT_INFO';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_MRT_INFO';

