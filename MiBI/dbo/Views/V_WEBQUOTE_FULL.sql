










-- used in webquote!!!!


CREATE VIEW [dbo].[V_WEBQUOTE_FULL]
AS
SELECT     ImpactNumber, 
 
FLOOR(Total * .115) AS CustomerY1, 
FLOOR(Total * .115 * 3 * .9) AS CustomerY3, 
FLOOR(Total * .115 * 5 * .85) AS CustomerY5, 
FLOOR(Total * .115 * 1.2) AS CustomerY1FEE, 
FLOOR((Total * .115  ) * 3 * .9  )+(Total * .115*.2) AS CustomerY3FEE, 
FLOOR((Total * .115  ) * 5 * .85  )+(Total * .115*.2)  AS CustomerY5FEE, 
FLOOR(Total * .115) * SupportPrice AS VARY1, 
FLOOR(Total * .115 * 3 * .9) * SupportPrice AS VARY3, 
FLOOR(Total * .115 * 5 * .85)  * SupportPrice AS VARY5, 
FLOOR(Total * .115 * 1.2) * SupportPrice AS VARY1FEE, 
(FLOOR((Total * .115  ) * 3 * .9  ) +(Total * .115*.2))* SupportPrice  AS VARY3FEE, 
(FLOOR((Total * .115  ) * 5 * .85  ) +(Total * .115*.2))* SupportPrice  AS VARY5FEE,
-- VAD prices should just pull from  V_SUP_ASSET_TOTAL  !!!!!  doing now MW 10082014
FLOOR(Total * .115) * /*CASE WHEN SupportPrice = .35 THEN .305 
WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 
THEN .395 ELSE 0 END */
VADSupportPrice AS VADY1, 
FLOOR(Total * .115 * 3 * .9) * VADSupportPrice
/*CASE WHEN SupportPrice = .35 THEN .305 WHEN SupportPrice = .39 THEN .345 WHEN 
SupportPrice = .44 THEN .395 ELSE 0 END */
AS VADY3, 
FLOOR(Total * .115 * 5 * .85)  * VADSupportPrice
/*CASE WHEN SupportPrice = .35 
THEN .305 WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 THEN .395 ELSE 0 END */
AS VADY5, 
FLOOR(Total * .115 * 1.2) 
                      * VADSupportPrice
                      /*CASE WHEN SupportPrice = .35 THEN .305 
                      WHEN SupportPrice = .39 THEN .345 WHEN SupportPrice = .44
                      THEN .395 ELSE 0 END */
AS VADY1FEE, 
(FLOOR((Total * .115  ) * 3 * .9  ) +(Total * .115*.2) )
* VADSupportPrice 
/*CASE WHEN SupportPrice = .35 THEN .305 WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 THEN .395 ELSE 0 END */
AS VADY3FEE, 
(FLOOR((Total * .115  ) * 5 * .85  )+(Total * .115*.2) ) * VADSupportPrice
/*CASE WHEN SupportPrice = .35 THEN .305 
WHEN SupportPrice = .39 THEN .345 WHEN SupportPrice = .44 THEN .395 ELSE 0 END   */ 
AS VADY5FEE,
FLOOR(Total * .115*3*.95)  as MYBA3List,
FLOOR(Total * .115*5*.925)  as MYBA5List,

SupportPrice as VARSupportPrice,
VADSupportPrice,
FLOOR((Total * .115*3*.95)+(Total * .115*.2) )  as MYBA3ListFEE,
FLOOR((Total * .115*5*.925)+(Total * .115*.2) )  as MYBA5ListFEE
FROM         dbo.V_SUP_ASSET_TOTAL



-- select * from [V_WEBQUOTE_FULL] where Partner_Csn = '51097'









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
         Begin Table = "V_SUP_ASSET_TOTAL"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_WEBQUOTE_FULL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_WEBQUOTE_FULL';

