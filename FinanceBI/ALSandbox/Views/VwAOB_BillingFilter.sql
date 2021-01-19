CREATE VIEW ALSandbox.VwAOB_BillingFilter
AS
SELECT        oss.VwServiceProduct_EX.ServiceId, invoice.MatVwIncrMRRNRR_EX_FY18.[MRR Expected], invoice.MatVwIncrMRRNRR_EX_FY18.LocationId, invoice.MatVwIncrMRRNRR_EX_FY18.OrderProjectManagerId, 
                         invoice.MatVwIncrMRRNRR_EX_FY18.orderedById, oss.VwOrderItemDetail_EX.OrderId, oss.VwOrderItemDetail_EX.OrderItemId, oss.VwOrderItemDetail_EX.DateBillingStart, 
                         oss.VwOrderItemDetail_EX.DateBillingStopped, oss.VwOrderItemDetail_EX.DateLiveScheduled, oss.VwOrderItemDetail_EX.DateLiveScheduledOriginal, oss.VwOrderItemDetail_EX.OrderLocationId, 
                         oss.VwServiceProduct_EX.ProductId, oss.VwServiceProduct_EX.DateSvcCreated, oss.VwServiceProduct_EX.DateSvcLiveActual, oss.VwServiceProduct_EX.DateSvcLiveScheduled, 
                         oss.VwServiceProduct_EX.DateSvcModified, oss.VwServiceProduct_EX.DateSvcClosed, oss.VwServiceProduct_EX.DateBillingValidFrom, oss.VwServiceProduct_EX.DateBillingValidTo, 
                         oss.VwServiceProduct_EX.DateSvcSetToActive, oss.VwServiceProduct_EX.SvcCluster, oss.VwServiceProduct_EX.SvcPlatform, oss.VwServiceProduct_EX.DateLocLiveForecast, company.VwAccount.[Ac Id], 
                         company.VwAccount.[Ac Name], company.VwAccount.Platform, company.VwAccount.Cluster, company.VwContractDetail.InstallEnforcementDate, company.VwContractDetail.Id, company.VwContractDetail.StartDate, 
                         company.VwContractDetail.EndDate, company.VwContractDetail.ProfileAmount, company.VwContractDetail.ContractType, invoice.MatVwIncrMRRNRR_EX_FY18.ServiceStatusId
FROM            oss.VwServiceProduct_EX INNER JOIN
                         oss.VwOrderItemDetail_EX ON oss.VwServiceProduct_EX.OrderId = oss.VwOrderItemDetail_EX.OrderId INNER JOIN
                         company.VwAccount ON oss.VwServiceProduct_EX.AccountId = company.VwAccount.[Ac Id] INNER JOIN
                         company.VwContractDetail ON company.VwContractDetail.AccountId = oss.VwOrderItemDetail_EX.OrderAccountid AND company.VwContractDetail.StartDate <= oss.VwOrderItemDetail_EX.DateBillingStart AND 
                         oss.VwOrderItemDetail_EX.DateBillingStart < company.VwContractDetail.InstallEnforcementDate INNER JOIN
                         invoice.MatVwIncrMRRNRR_EX_FY18 ON invoice.MatVwIncrMRRNRR_EX_FY18.ServiceId = oss.VwServiceProduct_EX.ServiceId
WHERE        (company.VwContractDetail.BusinessTermVersion IN ('3')) AND (company.VwAccount.IsBillable = '1') AND (oss.VwServiceProduct_EX.ServiceStatusId IN ('1', '16', '27')) AND 
                         (invoice.MatVwIncrMRRNRR_EX_FY18.InvoiceMonth > '2017-09-01')
GROUP BY oss.VwServiceProduct_EX.ServiceId, invoice.MatVwIncrMRRNRR_EX_FY18.[MRR Expected], invoice.MatVwIncrMRRNRR_EX_FY18.LocationId, invoice.MatVwIncrMRRNRR_EX_FY18.OrderProjectManagerId, 
                         invoice.MatVwIncrMRRNRR_EX_FY18.orderedById, oss.VwOrderItemDetail_EX.OrderId, oss.VwOrderItemDetail_EX.OrderItemId, oss.VwOrderItemDetail_EX.DateBillingStart, 
                         oss.VwOrderItemDetail_EX.DateBillingStopped, oss.VwOrderItemDetail_EX.DateLiveScheduled, oss.VwOrderItemDetail_EX.DateLiveScheduledOriginal, oss.VwOrderItemDetail_EX.OrderLocationId, 
                         oss.VwServiceProduct_EX.ProductId, oss.VwServiceProduct_EX.DateSvcCreated, oss.VwServiceProduct_EX.DateSvcLiveActual, oss.VwServiceProduct_EX.DateSvcLiveScheduled, 
                         oss.VwServiceProduct_EX.DateSvcModified, oss.VwServiceProduct_EX.DateSvcClosed, oss.VwServiceProduct_EX.DateBillingValidFrom, oss.VwServiceProduct_EX.DateBillingValidTo, 
                         oss.VwServiceProduct_EX.DateSvcSetToActive, oss.VwServiceProduct_EX.SvcCluster, oss.VwServiceProduct_EX.SvcPlatform, oss.VwServiceProduct_EX.DateLocLiveForecast, company.VwAccount.[Ac Id], 
                         company.VwAccount.[Ac Name], company.VwAccount.Platform, company.VwAccount.Cluster, company.VwContractDetail.InstallEnforcementDate, company.VwContractDetail.Id, company.VwContractDetail.StartDate, 
                         company.VwContractDetail.EndDate, company.VwContractDetail.ProfileAmount, company.VwContractDetail.ContractType, invoice.MatVwIncrMRRNRR_EX_FY18.ServiceStatusId

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[77] 4[8] 2[15] 3) )"
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
         Configuration = "(H (4[44] 2[26] 3) )"
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
               Top = 138
               Left = 38
               Bottom = 268
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VwOrderItemDetail_EX (oss)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VwAccount (company)"
            Begin Extent = 
               Top = 6
               Left = 307
               Bottom = 136
               Right = 528
            End
            DisplayFlags = 280
            TopColumn = 45
         End
         Begin Table = "VwContractDetail (company)"
            Begin Extent = 
               Top = 6
               Left = 566
               Bottom = 136
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "MatVwIncrMRRNRR_EX_FY18 (invoice)"
            Begin Extent = 
               Top = 138
               Left = 295
               Bottom = 370
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 23
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
      Begin ColumnWidths = 12
         Column = 2115
         Alias = 2835
         Table = 2205
         Output = 1080
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         Gr', @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'VwAOB_BillingFilter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'oupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'VwAOB_BillingFilter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'ALSandbox', @level1type = N'VIEW', @level1name = N'VwAOB_BillingFilter';

