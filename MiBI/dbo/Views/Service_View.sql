﻿CREATE VIEW dbo.Service_View
AS
SELECT     SR_NUM, SR_TITLE, Partner, End_User, Support_Program, SR_DESC, SR_AREA, SR_SUB_AREA, Res_Stat, LOGIN, Date_Open, ACT_CLOSE_DT, 
                      Commit_Time, SR_Version, Product, Phase, Source, Feature, Severity, Priority, Status, Sub_Status, FST_NAME, LAST_NAME, EMAIL_ADDR, 
                      Queue_Call, Searched_KB, LAST_UPD, Res_By_KB, Support_Prog_for_SR
FROM         dbo.SR_HEADER AS srhdr

GO
GRANT ALTER
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT TAKE OWNERSHIP
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Service_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Service_View] TO [TacEngRole]
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
         Begin Table = "srhdr"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 223
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Service_View';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Service_View';

