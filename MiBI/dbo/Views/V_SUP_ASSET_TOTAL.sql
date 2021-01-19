
CREATE VIEW [dbo].[V_SUP_ASSET_TOTAL]
AS

/*
example use: e+ support for cdw


mw  used in WEB SUpport quote

mw 09132016  updated to use sku lifecycle

*/
 
SELECT     
a.End_User_Csn, 
a.ImpactNumber, 
a.NAME, 
a.Partner_Csn, 
a.SupportType, 
b.Total, 
c.NPTotal,
case 
			when r.S3N = '65.0' then .35
			when r.S3N = '61.0' then .39
			When r.S3N = '56.0' then .44 
			When r.S3N = '51.52' then .4848 
			When r.S3N = '69.5' then .305  
			When r.S3N = '62.39' then .3761  
			When r.S3N = '49.78' then .5022 
			
			When r.S3N =  '43.5' then .565
			When r.S3N =  '50.75' then .4925
			When r.S3N = '50.50' then .4950 
			else 0
			END as SupportPrice, --VAR,
-- MW 06212017 Us Vads new pricing
			-- SSC/ING get 3.5 now MW 06132017 i.e.(r.S3N + 3.5)-100
			
case
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '65.0' then .315
			when r.S3N = '65.0' then .305 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '61.0' then .355
			when r.S3N = '61.0' then .345 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '56.0' then .405
			When r.S3N = '56.0' then .395 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '62.39' then .3411
			When r.S3N = '62.39' then .3311
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '49.78' then .4672
			When r.S3N = '49.78' then .4572 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '43.5' then .53
			When r.S3N =  '43.5' then .52
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '50.75' then .4575
			When r.S3N =  '50.75' then .4475		
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '50.5' then .46
			When r.S3N =  '50.5' then .45	
			else 0
			END as VADSupportPrice -- VAD
			
-- MW 06212017 Old Version

/*
			--vad gets 4.5 points, hence the  wierd numbers
case 
			when r.S3N = '65.0' then .305 
			when r.S3N = '61.0' then .345 
			When r.S3N = '56.0' then .395 
			When r.S3N = '62.39' then .3311
			When r.S3N = '49.78' then .4572 
			
			When r.S3N =  '43.5' then .52
			When r.S3N =  '50.75' then .4475			
			else 0
			END as VADSupportPrice -- VAD
			*/
FROM         dbo.CUSTOMERS AS a  (nolock) LEFT OUTER JOIN
			 RESELLER r on a.PartnerId = r.ImpactNumber left outer join
                          (SELECT     ImpactNumber, SUM(ShipQty * ListPrice) AS Total
                            FROM          dbo.CUSTOMER_ASSETS a (nolock)  left outer join
							PRODUCT p (nolock) on a.SKU = p.SKU 
                            where a.Status = 'Production' AND 
							isnull(p.SkuLifecycle,'Orderable') IN (
							'Orderable',
							'Supported',
							'Renewable'
												) 
                            GROUP BY ImpactNumber) AS b ON a.ImpactNumber = b.ImpactNumber LEFT OUTER JOIN
                          (SELECT     ImpactNumber, SUM(ShipQty * ListPrice) AS NPTotal
                            FROM          dbo.CUSTOMER_ASSETS AS CUSTOMER_ASSETS_1  (nolock)
                            WHERE      (ProductLine <> 'Phones') and Status = 'Production'
                            GROUP BY ImpactNumber) AS c ON a.ImpactNumber = c.ImpactNumber

-- select    S3N , count(*) from RESELLER group by  S3N










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
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 228
               Bottom = 84
               Right = 385
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 423
               Bottom = 84
               Right = 580
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SUP_ASSET_TOTAL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SUP_ASSET_TOTAL';

