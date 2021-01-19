



--select * from [V_SKY_SERVICESYNC] where m5db__Account__c = '14084'

CREATE VIEW [dbo].[V_SKY_SERVICESYNC]
AS
SELECT  -- top 10 
Id,  
CiId,
Owner						as OwnerId,
--M5DBCompanyId				as m5db__Account__c,
Accountid as m5db__Account__c,
Class as m5db__Class__c,
CASE WHEN CloseOrderId = 0 
then null
else CloseOrderId END
							as CLOSE_m5db__order_id__c,
CAST (DateCreatedOriginal as datetime	)			as m5db__Date_Created__c,
CAST (DateOrdered as datetime	)					as m5db__Date_Ordered__c,
CAST (DateFoc	 as datetime	)					as m5db__FOC_Date__c,
Invoiced					as m5db__Invoiced__c,
LocationId					as m5db__Location__c,
MRR							as m5db__MRR__c,
NRC							as m5db__NRR__c,
-- lots of invalid orders/products
case when OrderId = 0	then null		else OrderId	end		as m5db__order_id__c,
--CAST (ProductId	 as varchar) as m5db__product_id__c,  --JO 11252014 per Scott changed this since SFDC field is now txt
	CASE -- 3 digit ids MW 05132015
		WHEN  ProductId	   =0 then null
		When LEN(CAST (ProductId	 as varchar)) =1 THEN '00'+ CAST (ProductId	 as varchar)
		WHEN LEN(CAST (ProductId	 as varchar)) =2 then  '0'+ CAST (ProductId	 as varchar)
		WHEN  ProductId	   =0 then null
	ELSE CAST (ProductId	 as varchar) END as m5db__product_id__c,
--case when ProductId		= 0 then null else 	ProductId end	as m5db__product_id__c,
--
Name						as m5db__Service_Name__c,
Status						as m5db__Status__c,
CAST (DateBillingStopped as datetime	)			as m5db__datebillingcease__c,
CAST (DateBillingStart as datetime	)				as m5db__datebillingstart__c,
CAST (DateClosed as datetime	)					as m5db__dateclosed__c,
CAST (DateLiveActual as datetime	)				as m5db__dateliveactl__c,
STR(M5DBServiceId)				as m5db__service_id__c,
CarrierName as m5db_CarrierName__c,
--CarrierId as m5db_CarrierId__c,
null as  m5db_CarrierId__c,
CAST (ForecastDate as datetime ) as m5db__ForecastDate__c,
ErrStatus,
ErrorTxt
--, 'NEW' as ViId
FROM         
		SKY_SFDC_SERVICES
--where Accountid = '14084'
--where (DateOrdered != '10/03/0207') --or DateOrdered is NULL Or DateOrdered != '08/21/0085')

--where  ( DateLiveActual not like '%0001' OR DateOrdered not like '%0085'  
   --OR DateOrdered not like '%0207'  )
   
   
-- delete from 
 -- select   from  SKY_SFDC_SERVICES where CiId 
--where DateOrdered in ( '08/21/0085', '10/03/0207')






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
         Begin Table = "SKY_SFDC_SERVICES"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SKY_SERVICESYNC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_SKY_SERVICESYNC';

