CREATE VIEW [dbo].[V_PROD_BY_CUST]
AS
select
		a.ImpactNumber, 
		a.End_User_Csn,
		isnull(b.Has, 'N') as '3rdPartyProducts',
		isnull(c.Has, 'N') as 'CC',
		isnull(d.Has, 'N') as 'ExtendedApps',
		isnull(e.Has, 'N') as 'Other',
		isnull(f.Has, 'N') as 'ProfessionalServices',
		isnull(g.Has, 'N') as 'Switches',
		isnull(h.Has, 'N') as 'Phones',
		isnull(i.Has, 'N') as 'Mobility',
		isnull(j.Has, 'N') as 'AppServer',
		isnull(k.Has, 'N') as 'ClientSoftware',
		isnull(l.Has, 'N') as 'SBE',
		isnull(m.Has, 'N') as 'UC' 
		
FROM
CUSTOMERS a LEFT OUTER JOIN
(
SELECT     a.CustomerRowId,  'Y' as Has, count(*) as '3rdPartyProducts'
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine IN (
		'3rd Party Product Promotions',
		'3rd Party Products'		)
        GROUP BY a.CustomerRowId 
) b on a.End_User_Csn = b.CustomerRowId LEFT OUTER JOIN
(
SELECT     a.CustomerRowId,  'Y' as Has,count(*) as CC
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine IN (
		'Contact Center',
		'Contact Center Promotions'	)
        GROUP BY a.CustomerRowId
) c on a.End_User_Csn = c.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId, 'Y' as Has, count(*) as ExtendedApps
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine  = 'Extended Applications'
        GROUP BY a.CustomerRowId
) d   on a.End_User_Csn = d.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId,  'Y' as Has,count(*) as Other
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine  =  'Other Equipment'
        GROUP BY a.CustomerRowId
) e  on a.End_User_Csn = e.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId,  'Y' as Has,count(*) as ProfessionalServices
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine  =  'Professional Services'
        GROUP BY a.CustomerRowId
) f  on a.End_User_Csn = f.CustomerRowId LEFT OUTER JOIN		
(SELECT     a.CustomerRowId, 'Y' as Has, count(*) as Switches
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine  =  'ShoreGear Voice Switches'
        GROUP BY a.CustomerRowId
) g on a.End_User_Csn = g.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId,  'Y' as Has,count(*) as Phones
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine  =  'ShorePhone Telephones'
        GROUP BY a.CustomerRowId
) h  on a.End_User_Csn = h.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId,  'Y' as Has,count(*) as Mobility
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine  =  'ShoreTel Mobility'
        GROUP BY a.CustomerRowId
) i  on a.End_User_Csn = i.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId,  'Y' as Has,count(*) as AppServer
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine IN (
		 	'ShoreWare Application Server',
			'ShoreWare Application Server Promotions'	)
        GROUP BY a.CustomerRowId
) j  on a.End_User_Csn = j.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId,  'Y' as Has,count(*) as ClientSoftware
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine IN (
 		'ShoreWare Client Software',
'ShoreWare Client Software Promotions')
        GROUP BY a.CustomerRowId
) k  on a.End_User_Csn = k.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId,  'Y' as Has,count(*) as SBE
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine  =  'Small Business Edition'
        GROUP BY a.CustomerRowId
) l on a.End_User_Csn = l.CustomerRowId LEFT OUTER JOIN
(SELECT     a.CustomerRowId, 'Y' as Has,  count(*) as UC
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT_LINE b ON a.SKU = b.sku
			 where b.ProductLine IN (
 		'Unified Communication Promotions',
'Unified Communications')
        GROUP BY a.CustomerRowId
) m on a.End_User_Csn = m.CustomerRowId 
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
         Begin Table = "b_1"
            Begin Extent = 
               Top = 6
               Left = 228
               Bottom = 99
               Right = 392
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 430
               Bottom = 99
               Right = 587
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 625
               Bottom = 99
               Right = 782
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 102
               Left = 228
               Bottom = 195
               Right = 385
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 102
               Left = 423
               Bottom = 195
               Right = 601
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 102
               Left = 639
               Bottom = 195
               Right = 796
            End
            DisplayFlags = 280
            TopColumn = 0
         End
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PROD_BY_CUST';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Begin Table = "h"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 207
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 198
               Left = 233
               Bottom = 291
               Right = 390
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 198
               Left = 428
               Bottom = 291
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 198
               Left = 623
               Bottom = 291
               Right = 780
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 210
               Left = 38
               Bottom = 303
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 294
               Left = 233
               Bottom = 387
               Right = 390
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PROD_BY_CUST';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PROD_BY_CUST';

