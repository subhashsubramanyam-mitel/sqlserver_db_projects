
CREATE VIEW [dbo].[V_SKY_ORDERSYNC]
AS
-- MW 10152013 FOR SKY - SFDC order sync
SELECT
Id,
CiId,

--Default Shoretel
isnull(Owner, '00500000006xybxAAA') as OwnerId,
 
M5DBAccountId as m5db__Account__c,

ActivatedNRC as m5db__Activated_NRR__c,
ActiveMRR as m5db__Active_MRR__c,
ChangedMRR as m5db__Changed_MRR__c,
ClosedMRR as m5db__Closed_MRR__c,  --m5db__Contact__r 
Contact as  m5db__contact__c,
CreatedBy as m5db__Creator__c,

Name as m5db__Description__c,
InitialMRR as m5db__InitialMRR__c,
InitialNRC as m5db__InitialNRR__c,

--InitialM5dbOrderId as INIT_m5db__order_id__c,
CASE WHEN InitialM5dbOrderId = 0  --m5db__Initial_Order__r
then null
else InitialM5dbOrderId END
							as INIT_m5db__order_id__c,

LocationId as m5db__location__c,

OrderType as m5db__Order_Type__c,
DateBillingStopped as m5db__Order_datebillingcease__c,
PendingMRR as m5db__Pending_MRR__c,
PendingNRC as m5db__Pending_NRR__c,
Status as m5db__Status__c,
VoidMRR as m5db__VOID_MRR__c,
VoidNRC as m5db__VOID_NRR__c,
DateBillingStart as m5db__order_datelive__c,
DateLiveScheduled as m5db__order_dateschd__c,
M5DBOrderId as m5db__order_id__c,
OrderDateClosed as m5db__orders_dateclosed__c,
DateCreatedOriginal as m5db__orders_datecreated__c,
ErrStatus 


FROM         dbo.SKY_SFDC_ORDERS

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[18] 4[43] 2[20] 3) )"
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
         Begin Table = "SKY_SFDC_ORDERS"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 216
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SKY_ORDERSYNC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SKY_ORDERSYNC';

