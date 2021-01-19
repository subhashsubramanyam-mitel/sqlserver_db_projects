
CREATE VIEW [ALSandbox].[VwServiceCommitmentPlus]
AS
SELECT        ALSandbox.VwServiceCommitment.DateBillingStart, ALSandbox.VwServiceCommitment.DateBillingStopped, ALSandbox.VwServiceCommitment.ProductId, ALSandbox.VwServiceCommitment.LocationId, 
                         ALSandbox.VwServiceCommitment.OrderId, ALSandbox.VwServiceCommitment.OrderProjectManagerId, ALSandbox.VwServiceCommitment.DateSvcLiveActual, ALSandbox.VwServiceCommitment.DateSvcLiveScheduled, 
                         ALSandbox.VwServiceCommitment.DateSvcCreated, ALSandbox.VwServiceCommitment.[Ac Id], ALSandbox.VwServiceCommitment.[Ac Name], ALSandbox.VwServiceCommitment.InstallEnforcementDate, 
                         ALSandbox.VwServiceCommitment.[Contract Id], ALSandbox.VwServiceCommitment.StartDate, ALSandbox.VwServiceCommitment.EndDate, ALSandbox.VwServiceCommitment.ServiceStatusId, 
                         ALSandbox.VwServiceCommitment.InitialCreationDate, oss.[Order].Name, oss.[Order].DateBillingStart AS [Date Billing Start], oss.[Order].DateBillingStopped AS [Date Billing Stop], oss.[Order].DateLiveScheduled, 
                         oss.[Order].DateLiveScheduledOriginal, ALSandbox.VwServiceCommitment.DateLiveScheduled AS [Date Live Scheduled], ALSandbox.VwServiceCommitment.DateLiveScheduledOriginal AS [Date live Scheduled Original], 
                         company.VwLocation.[Loc Name], enum.VwProduct.[Prod Name], enum.VwProduct.ProdSubCategory, enum.VwProduct.[Prod Category], enum.VwProduct.[Prod Id], people.VwPerson.Id AS [Person Id], people.VwPerson.FullName, 
                         people.VwPerson.FirstName, people.VwPerson.LastName, people.VwPerson.Email, oss.[Order].OrderStatusId, oss.VwOrder.OrderName, oss.VwOrder.OrderTypeId, enum.OrderStatus.Name AS [Order staus Name], 
                         enum.OrderStatus.Id AS [Order Status Id], oss.VwOrder.OrderId AS Expr1, company.VwLocation.[Loc Id], oss.[Order].Id
FROM            ALSandbox.VwServiceCommitment INNER JOIN
                         oss.[Order] ON ALSandbox.VwServiceCommitment.OrderId = oss.[Order].Id INNER JOIN
                         company.VwLocation ON ALSandbox.VwServiceCommitment.LocationId = company.VwLocation.[Loc Id] INNER JOIN
                         oss.VwOrder ON ALSandbox.VwServiceCommitment.OrderId = oss.VwOrder.OrderId INNER JOIN
                         people.VwPerson ON ALSandbox.VwServiceCommitment.OrderProjectManagerId = people.VwPerson.Id INNER JOIN
                         enum.VwProduct ON ALSandbox.VwServiceCommitment.ProductId = enum.VwProduct.[Prod Id] INNER JOIN
                         enum.OrderStatus ON oss.[Order].OrderStatusId = enum.OrderStatus.Id
WHERE        (ALSandbox.VwServiceCommitment.InstallEnforcementDate > CONVERT(DATETIME, '2018-12-01 00:00:00', 102))
and enum.OrderStatus.Name = 'Pending'

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[63] 2[5] 3) )"
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
         Begin Table = "VwServiceCommitment"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "Order (oss)"
            Begin Extent = 
               Top = 6
               Left = 307
               Bottom = 136
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "VwLocation (company)"
            Begin Extent = 
               Top = 6
               Left = 576
               Bottom = 136
               Right = 775
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VwOrder (oss)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VwPerson (people)"
            Begin Extent = 
               Top = 177
               Left = 319
               Bottom = 307
               Right = 517
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VwProduct (enum)"
            Begin Extent = 
               Top = 138
               Left = 543
               Bottom = 268
               Right = 757
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "OrderStatus (enum)"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 387
              ', @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'VwServiceCommitmentPlus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Right = 208
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
         Column = 1890
         Alias = 900
         Table = 1170
         Output = 1380
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
', @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'VwServiceCommitmentPlus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'VwServiceCommitmentPlus';

