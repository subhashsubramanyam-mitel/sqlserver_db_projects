CREATE VIEW ALSandbox.vwAOB
AS
SELECT        company.VwAccount.IsBillable, company.VwContractDetail.BusinessTermVersion, oss.VwServiceProduct_EX.ServiceStatusId AS Expr1, oss.VwServiceProduct_EX.ServiceId AS Service_Id, 
                         invoice.MatVwIncrMRRNRR_EX_FY18.[MRR Expected] AS MRR_Expected, oss.VwOrderItemDetail_EX.OrderTypeId, oss.VwServiceProduct_EX.ServiceStatusId, oss.VwOrderItemDetail_EX.DateBillingStart, 
                         oss.VwOrderItemDetail_EX.DateBillingStopped, company.VwContractDetail.InstallEnforcementDate, oss.VwServiceProduct_EX.DateSvcLiveActual, oss.VwServiceProduct_EX.DateSvcLiveScheduled, 
                         ALSandbox.VwAOB_BillingFilter.[MRR Expected] AS MRR_Expected_wFilter, ALSandbox.VwAOB_BillingFilter.ServiceId
FROM            oss.VwServiceProduct_EX INNER JOIN
                         oss.VwOrderItemDetail_EX ON oss.VwServiceProduct_EX.OrderId = oss.VwOrderItemDetail_EX.OrderId INNER JOIN
                         company.VwAccount ON oss.VwServiceProduct_EX.AccountId = company.VwAccount.[Ac Id] INNER JOIN
                         company.VwContractDetail ON company.VwContractDetail.AccountId = oss.VwOrderItemDetail_EX.OrderAccountid AND 
                         company.VwContractDetail.StartDate <= oss.VwOrderItemDetail_EX.DateBillingStart INNER JOIN
                         invoice.MatVwIncrMRRNRR_EX_FY18 ON invoice.MatVwIncrMRRNRR_EX_FY18.ServiceId = oss.VwServiceProduct_EX.ServiceId LEFT OUTER JOIN
                         ALSandbox.VwAOB_BillingFilter ON ALSandbox.VwAOB_BillingFilter.ServiceId = oss.VwServiceProduct_EX.ServiceId
WHERE        (company.VwContractDetail.BusinessTermVersion IN ('3')) AND (company.VwAccount.IsBillable = '1') AND (oss.VwServiceProduct_EX.ServiceStatusId IN ('1', '16', '27')) AND 
                         (invoice.MatVwIncrMRRNRR_EX_FY18.InvoiceMonth > '2017-09-01') AND (oss.VwOrderItemDetail_EX.OrderItemTypeId IN ('0', '9'))

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[5] 2[55] 3) )"
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
         Begin Table = "VwServiceProduct_EX (oss)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 66
         End
         Begin Table = "VwOrderItemDetail_EX (oss)"
            Begin Extent = 
               Top = 6
               Left = 295
               Bottom = 136
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 36
         End
         Begin Table = "VwAccount (company)"
            Begin Extent = 
               Top = 6
               Left = 564
               Bottom = 136
               Right = 785
            End
            DisplayFlags = 280
            TopColumn = 45
         End
         Begin Table = "VwContractDetail (company)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 266
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MatVwIncrMRRNRR_EX_FY18 (invoice)"
            Begin Extent = 
               Top = 138
               Left = 304
               Bottom = 268
               Right = 523
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "VwAOB_BillingFilter"
            Begin Extent = 
               Top = 6
               Left = 829
               Bottom = 197
               Right = 993
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
      End', @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'vwAOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2250
         Alias = 2235
         Table = 2535
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
', @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'vwAOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'vwAOB';

