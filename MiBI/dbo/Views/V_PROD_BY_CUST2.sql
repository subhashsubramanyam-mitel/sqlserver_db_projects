

CREATE VIEW [dbo].[V_PROD_BY_CUST2]
AS
 


 SELECT      a.Created,
		a.ImpactNumber, 
		a.ImpactNumber as End_User_Csn,
a.NAME, r.NAME as PartnerName, a.SupportType, a.Region, a.City, b.Industry, b.Size, b.Employees, ip.Date AS 'IP Telephony', uc.Date AS 'Unified Communications', cc.Date AS 'Contact Center', 
                      mob.Date AS 'Mobility', o.Date AS 'Other', st.Date AS 'Sales Tools', svc.Date AS 'Services'

, 		isnull(l.Has, 'N') as 'SBE', b.UserLic as UserLicenses, a.State, a.Country

FROM         dbo.CUSTOMERS AS a LEFT OUTER JOIN
                      dbo.V_CUST_INFO AS b ON a.ImpactNumber = b.CustomerId LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber AS SE_ID, b.MarketFamily, MIN(CONVERT(Char(10), a.ShipDate, 101)) AS Date
                            FROM          dbo.CUSTOMER_ASSETS AS a INNER JOIN
                                                   dbo.PRODUCT AS b ON a.SKU = b.SKU
                            WHERE      (b.MarketFamily = 'Contact Center')
                            GROUP BY a.ImpactNumber, b.MarketFamily) AS cc ON a.ImpactNumber = cc.SE_ID LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber AS SE_ID, b.MarketFamily, MIN(CONVERT(Char(10), a.ShipDate, 101)) AS Date
                            FROM          dbo.CUSTOMER_ASSETS AS a INNER JOIN
                                                   dbo.PRODUCT AS b ON a.SKU = b.SKU
                            WHERE      (b.MarketFamily = 'IP Telephony')
                            GROUP BY a.ImpactNumber, b.MarketFamily) AS ip ON a.ImpactNumber = ip.SE_ID LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber AS SE_ID, b.MarketFamily, MIN(CONVERT(Char(10), a.ShipDate, 101)) AS Date
                            FROM          dbo.CUSTOMER_ASSETS AS a INNER JOIN
                                                   dbo.PRODUCT AS b ON a.SKU = b.SKU
                            WHERE      (b.MarketFamily = 'Mobility')
                            GROUP BY a.ImpactNumber, b.MarketFamily) AS mob ON a.ImpactNumber = mob.SE_ID LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber AS SE_ID, b.MarketFamily, MIN(CONVERT(Char(10), a.ShipDate, 101)) AS Date
                            FROM          dbo.CUSTOMER_ASSETS AS a INNER JOIN
                                                   dbo.PRODUCT AS b ON a.SKU = b.SKU
                            WHERE      (b.MarketFamily = 'Other')
                            GROUP BY a.ImpactNumber, b.MarketFamily) AS o ON a.ImpactNumber = o.SE_ID LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber AS SE_ID, b.MarketFamily, MIN(CONVERT(Char(10), a.ShipDate, 101)) AS Date
                            FROM          dbo.CUSTOMER_ASSETS AS a INNER JOIN
                                                   dbo.PRODUCT AS b ON a.SKU = b.SKU
                            WHERE      (b.MarketFamily = 'Sales Tools')
                            GROUP BY a.ImpactNumber, b.MarketFamily) AS st ON a.ImpactNumber = st.SE_ID LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber AS SE_ID, b.MarketFamily, MIN(CONVERT(Char(10), a.ShipDate, 101)) AS Date
                            FROM          dbo.CUSTOMER_ASSETS AS a INNER JOIN
                                                   dbo.PRODUCT AS b ON a.SKU = b.SKU
                            WHERE      (b.MarketFamily = 'Services')
                            GROUP BY a.ImpactNumber, b.MarketFamily) AS svc ON a.ImpactNumber = svc.SE_ID LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber AS SE_ID, b.MarketFamily, MIN(CONVERT(Char(10), a.ShipDate, 101)) AS Date
                            FROM          dbo.CUSTOMER_ASSETS AS a INNER JOIN
                                                   dbo.PRODUCT AS b ON a.SKU = b.SKU
                            WHERE      (b.MarketFamily = 'Unified Communications')
                            GROUP BY a.ImpactNumber, b.MarketFamily) AS uc ON a.ImpactNumber = uc.SE_ID left outer join
						 
(SELECT     a.ImpactNumber,  'Y' as Has,count(*) as SBE
FROM         CUSTOMER_ASSETS a INNER JOIN
             PRODUCT b ON a.SKU = b.SKU
			 where b.ItemType  =  'Small Business Edition'
        GROUP BY a.ImpactNumber
) l on a.ImpactNumber = l.ImpactNumber left outer join
RESELLER r on a.PartnerId = r.ImpactNumber
where a.Type = 'Customer (Installed)'
GO
GRANT SELECT
    ON OBJECT::[dbo].[V_PROD_BY_CUST2] TO [CANDY\DWalter]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_PROD_BY_CUST2] TO [PMData]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[21] 3) )"
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
               Bottom = 114
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 6
               Left = 418
               Bottom = 99
               Right = 569
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ip"
            Begin Extent = 
               Top = 6
               Left = 607
               Bottom = 99
               Right = 758
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mob"
            Begin Extent = 
               Top = 102
               Left = 418
               Bottom = 195
               Right = 569
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent = 
               Top = 102
               Left = 607
               Bottom = 195
               Right = 758
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "st"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 207
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PROD_BY_CUST2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         Begin Table = "svc"
            Begin Extent = 
               Top = 114
               Left = 227
               Bottom = 207
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "uc"
            Begin Extent = 
               Top = 198
               Left = 416
               Bottom = 291
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PROD_BY_CUST2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_PROD_BY_CUST2';

