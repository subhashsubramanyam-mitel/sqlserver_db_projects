
CREATE VIEW [dbo].[Quality_SR_View]
AS
SELECT     dbo.DEFECT_HEADER.DEFECT_NUM AS Defect_Number, dbo.DEFECT_HEADER.Developer, dbo.DEFECT_HEADER.FI, dbo.DEFECT_HEADER.Priority, 
                      dbo.DEFECT_HEADER.ABSTRACT, dbo.DEFECT_HEADER.Area, dbo.DEFECT_HEADER.Version, dbo.DEFECT_HEADER.Ext_Desc, 
                      dbo.DEFECT_DETAIL.TargetRel AS Target, dbo.DEFECT_DETAIL.Status, dbo.DEFECT_DETAIL.Test_Engineer, dbo.DEFECT_DETAIL.Sub_Status, 
                      dbo.DEFECT_DETAIL.X_QAA_QAC_DATE, dbo.DEFECT_DETAIL.Due_Date, dbo.DEFECT_DETAIL.Risk, dbo.DEFECT_DETAIL.Correct_In, 
                      dbo.DEFECT_DETAIL.Change_List, dbo.DEFECT_HEADER.Keywords, dbo.DEFECT_HEADER.Close_Date, dbo.DEFECT_NOTES.NOTE_TYPE, 
                      dbo.DEFECT_DETAIL.Reviewed_by, dbo.DEFECT_DETAIL.Resolved_Date, dbo.DEFECT_DETAIL.MRT_LAST_UPDATE, 
                      dbo.DEFECT_HEADER.Date_Open, dbo.DEFECT_HEADER.Created_By, dbo.DEFECT_HEADER.Type, dbo.DEFECT_HEADER.QA_Owner, 
                      dbo.DEFECT_HEADER.FoundIn AS Found, dbo.DEFECT_HEADER.TEST_CASES, dbo.DEFECT_HEADER.Res_Description, 
                      dbo.DEFECT_HEADER.Found_Via, dbo.DEFECT_HEADER.Sub_Area, dbo.SR_HEADER_SVY.SR_NUM, dbo.SR_HEADER_SVY.Date_Open AS SR_Open_Date, 
                      dbo.SR_HEADER_SVY.ACT_CLOSE_DT AS SR_Closed_Date, dbo.SR_HEADER_SVY.Status AS SR_Status, dbo.SR_HEADER_SVY.Sub_Status AS SR_Sub_Status, 
                      dbo.SR_HEADER_SVY.SR_Version, dbo.SR_HEADER_SVY.AccountId, dbo.DEFECT_HEADER.Notify_1, dbo.DEFECT_HEADER.Notify_2, dbo.SR_HEADER_SVY.PartnerId, 
                      dbo.DEFECT_HEADER.DeveloperGroup, dbo.DEFECT_HEADER.WO, dbo.DEFECT_HEADER.Reason,
					  --dbo.DEFECT_DETAIL.,
					  dbo.DEFECT_DETAIL.Verified_Date, dbo.DEFECT_DETAIL.Verified_In
FROM         dbo.DEFECT_HEADER LEFT OUTER JOIN
                      dbo.DEFECT_DETAIL ON dbo.DEFECT_HEADER.DEFECT_NUM = dbo.DEFECT_DETAIL.DEFECT_NUM LEFT OUTER JOIN
                      dbo.DEFECT_NOTES ON dbo.DEFECT_HEADER.DEFECT_NUM = dbo.DEFECT_NOTES.DEFECT_NUM AND 
                      dbo.DEFECT_NOTES.NOTE_TYPE = 'Test Request Plan' LEFT OUTER JOIN
                      dbo.SR_DEF_INTERFACE ON dbo.DEFECT_HEADER.DEFECT_NUM = dbo.SR_DEF_INTERFACE.DEFECT_NUM LEFT OUTER JOIN
                      dbo.SR_HEADER_SVY ON dbo.SR_DEF_INTERFACE.SR_NUM = dbo.SR_HEADER_SVY.SR_NUM
GO
GRANT ALTER
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT TAKE OWNERSHIP
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Quality_SR_View] TO [CANDY\TChen]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Quality_SR_View] TO [TacEngRole]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Quality_SR_View] TO [TacEngRole]
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
         Begin Table = "DEFECT_HEADER"
            Begin Extent = 
               Top = 8
               Left = 483
               Bottom = 250
               Right = 640
            End
            DisplayFlags = 280
            TopColumn = 14
         End
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
         Begin Table = "DEFECT_NOTES"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SR_DEF_INTERFACE"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 315
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SR_HEADER"
            Begin Extent = 
               Top = 114
               Left = 227
               Bottom = 222
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
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Quality_SR_View';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Quality_SR_View';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Quality_SR_View';

