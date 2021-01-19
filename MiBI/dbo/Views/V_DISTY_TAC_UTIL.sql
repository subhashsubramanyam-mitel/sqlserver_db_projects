
CREATE VIEW [dbo].[V_DISTY_TAC_UTIL]
AS
/*DISTY TAC UTIL 
SELECT     a.Partner_Csn, a.ImpactNumber, a.NAME AS DistyName, ISNULL(clients.CLIENTS, 0) AS CLIENTS, ISNULL(sr.SRActual, 0) AS SRActual, ISNULL(sr.SR, 
                      0) AS SR_Anual, CASE WHEN clients.CLIENTS = '0' THEN '999' ELSE CAST(ISNULL((sr.SR), 0) / ISNULL(clients.CLIENTS, 1) AS decimal(14, 4)) 
                      * 100 END AS UTILIZATION
FROM         dbo.RESELLER AS a LEFT OUTER JOIN
                          (SELECT     DistyRowId AS SE_ID, ISNULL(SUM(Qty), 0) AS CLIENTS
                            FROM          dbo.TAC_UTIL_LIC
                            GROUP BY DistyRowId) AS clients ON a.Partner_Csn = clients.SE_ID LEFT OUTER JOIN
                          (SELECT     DistyRowId AS SE_ID, COUNT(SR_NUM) AS SRActual, CAST(COUNT(SR_NUM) * 52 / CAST(CASE WHEN year(getdate()) 
                                                   = '2009' THEN (DATEPART(wk, getdate()) - 20) WHEN year(getdate()) = '2010' THEN (DATEPART(wk, '01-01-2010') + 32) END AS decimal) 
                                                   AS decimal) AS SR
                            FROM          dbo.TAC_UTIL_SR
                            GROUP BY DistyRowId) AS sr ON a.Partner_Csn = sr.SE_ID
WHERE     (a.Type = 'Active Distributor')

Changed to load from tables to lock down date.
*/

SELECT      SE_ID AS Partner_Csn, 
		    ImpactNumber AS ImpactNumber, 
		    Partner AS DistyName, 
		    Licenses AS CLIENTS, 
		    SrCount AS SRActual, 
			SrCount_Annual as SR_Anual,
		    Utilization AS UTILIZATION
FROM          TAC_UTIL_DISTY

GO
GRANT SELECT
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\SASmith]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\SASmith]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\DCouchman]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\DCouchman]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\BLynch]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\BLynch]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\AHerrell]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\AHerrell]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\CBurnett]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CANDY\CBurnett]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [CRAdmin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_DISTY_TAC_UTIL] TO [TacEngRole]
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
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "clients"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 84
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sr"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 99
               Right = 567
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_DISTY_TAC_UTIL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_DISTY_TAC_UTIL';

