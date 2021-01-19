



CREATE VIEW [dbo].[V_CUST_INFO]
AS
--JO 07172014  Replaced SE_ID references
SELECT     dbo.CUSTOMERS.SECreatedDate, dbo.DNB_DATA.SE_ID, dbo.CUSTOMERS.ImpactNumber as CustomerId, dbo.CUSTOMERS.NAME, dbo.CUSTOMERS.Region, 
                      dbo.CUSTOMERS.Country, dbo.CUSTOMERS.Partner_Csn, dbo.DNB_DATA.[Total Employees] AS Employees, dbo.SIC_LOOKUP.DivDesc AS Industry, 
                      ISNULL(dbo.DNB_DATA.SIC1, '0') AS SIC, CASE WHEN DNB_DATA.[Total Employees] < 51 THEN '0-50' WHEN DNB_DATA.[Total Employees] > 50 AND 
                      DNB_DATA.[Total Employees] < 501 THEN '51-500' WHEN DNB_DATA.[Total Employees] > 500 AND 
                      DNB_DATA.[Total Employees] < 2001 THEN '501-2000' WHEN DNB_DATA.[Total Employees] > 2000 THEN '2000+' END AS Size, b.Licenses, b.UserLic, 
                      b.SumOfList, dbo.CUSTOMERS.VersionFromSR, t.FQuarter AS CustCreateQtr,
                      isnull(sbe.SystemType,'No') as SbeCustomer, ph.InstallDate as InstallDate_ph, ph.Version as Version_ph, 'Use CustomerId' as ImpactNumber
                      ,se.Support as SupportEnd
FROM         dbo.CUSTOMERS LEFT OUTER JOIN
                      dbo.DNB_DATA ON dbo.CUSTOMERS.End_User_Csn = dbo.DNB_DATA.SE_ID LEFT OUTER JOIN
                      dbo.SIC_LOOKUP ON dbo.DNB_DATA.[Major Industry Category] = dbo.SIC_LOOKUP.Div LEFT OUTER JOIN
                          (SELECT     ImpactNumber, SUM(LicQty) AS Licenses, SUM(UserLic) AS UserLic, SUM(ListPrice * ShipQty) AS SumOfList
                            FROM          dbo.CUSTOMER_ASSETS AS a
                            GROUP BY ImpactNumber) AS b ON dbo.CUSTOMERS.ImpactNumber = b.ImpactNumber LEFT OUTER JOIN
                      V_SBE_CUSTOMERS sbe on dbo.CUSTOMERS.ImpactNumber = sbe.ST_ID LEFT OUTER JOIN
                      CUSTOMER_VERSION_PH ph on dbo.CUSTOMERS.ImpactNumber = ph.ST_ID left outer join
                      
                      dbo.TimeLookup AS t ON CONVERT(char(10), dbo.CUSTOMERS.Created, 101) = CONVERT(char(10), t.theDate, 101) left outer join
                      V_SUPPORT_END se on dbo.CUSTOMERS.ImpactNumber = se.ST_ID



/*  --07172014 Remarked out
SELECT     dbo.CUSTOMERS.Created, dbo.DNB_DATA.SE_ID, dbo.CUSTOMERS.ImpactNumber as CustomerId, dbo.CUSTOMERS.NAME, dbo.CUSTOMERS.Region, 
                      dbo.CUSTOMERS.Country, dbo.CUSTOMERS.Partner_Csn, dbo.DNB_DATA.[Total Employees] AS Employees, dbo.SIC_LOOKUP.DivDesc AS Industry, 
                      ISNULL(dbo.DNB_DATA.SIC1, '0') AS SIC, CASE WHEN DNB_DATA.[Total Employees] < 51 THEN '0-50' WHEN DNB_DATA.[Total Employees] > 50 AND 
                      DNB_DATA.[Total Employees] < 501 THEN '51-500' WHEN DNB_DATA.[Total Employees] > 500 AND 
                      DNB_DATA.[Total Employees] < 2001 THEN '501-2000' WHEN DNB_DATA.[Total Employees] > 2000 THEN '2000+' END AS Size, b.Licenses, b.UserLic, 
                      b.SumOfList, dbo.CUSTOMERS.VersionFromSR, t.FQuarter AS CustCreateQtr,
                      isnull(sbe.SystemType,'No') as SbeCustomer, ph.InstallDate as InstallDate_ph, ph.Version as Version_ph, 'Use CustomerId' as ImpactNumber
                      ,se.Support as SupportEnd
FROM         dbo.CUSTOMERS LEFT OUTER JOIN
                      dbo.DNB_DATA ON dbo.CUSTOMERS.End_User_Csn = dbo.DNB_DATA.SE_ID LEFT OUTER JOIN
                      dbo.SIC_LOOKUP ON dbo.DNB_DATA.[Major Industry Category] = dbo.SIC_LOOKUP.Div LEFT OUTER JOIN
                          (SELECT     CustomerRowId, SUM(LicQty) AS Licenses, SUM(UserLic) AS UserLic, SUM(ListPrice * ShipQty) AS SumOfList
                            FROM          dbo.CUSTOMER_ASSETS AS a
                            GROUP BY CustomerRowId) AS b ON dbo.CUSTOMERS.End_User_Csn = b.CustomerRowId LEFT OUTER JOIN
                      V_SBE_CUSTOMERS sbe on dbo.CUSTOMERS.End_User_Csn = sbe.SE_ID LEFT OUTER JOIN
                      CUSTOMER_VERSION_PH ph on dbo.CUSTOMERS.End_User_Csn = ph.SE_ID left outer join
                      
                      dbo.TimeLookup AS t ON CONVERT(char(10), dbo.CUSTOMERS.Created, 101) = CONVERT(char(10), t.theDate, 101) left outer join
                      V_SUPPORT_END se on dbo.CUSTOMERS.End_User_Csn = se.SE_ID
*/
/* 
 SELECT     DNB_DATA.SE_ID, CUSTOMERS.NAME, CUSTOMERS.Region, CUSTOMERS.Partner_Csn, DNB_DATA.[Total Employees] AS Employees, 
        SIC_LOOKUP.DivDesc AS Industry, isnull(DNB_DATA.SIC1, '0') as SIC,
       CASE WHEN DNB_DATA.[Total Employees]   <51 then '0-50'
			WHEN DNB_DATA.[Total Employees]   > 50 and DNB_DATA.[Total Employees] <501 then '51-500'   
			WHEN DNB_DATA.[Total Employees]   > 500 and DNB_DATA.[Total Employees] <2001 then '501-2000'  
			WHEN DNB_DATA.[Total Employees]   > 2000  then '2000+'  
				END as Size     ,  b.Licenses, b.SumOfList, CUSTOMERS.VersionFromSR

FROM         DNB_DATA INNER JOIN
                      CUSTOMERS ON DNB_DATA.SE_ID = CUSTOMERS.End_User_Csn LEFT OUTER JOIN
                      SIC_LOOKUP ON DNB_DATA.[Major Industry Category] = SIC_LOOKUP.Div INNER JOIN
                      (
						select  a.CustomerRowId, SUM(a.LicQty) Licenses, SUM(a.ListPrice*a.ShipQty) as SumOfList
						  from CUSTOMER_ASSETS a 
						group by a.CustomerRowId
					) b ON CUSTOMERS.End_User_Csn = b.CustomerRowId
*/









GO
GRANT SELECT
    ON OBJECT::[dbo].[V_CUST_INFO] TO [CANDY\HAlfaro]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_CUST_INFO] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_CUST_INFO] TO [CANDY\ALee]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_CUST_INFO] TO [PMData]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_CUST_INFO] TO [Marketing]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[17] 4[45] 2[20] 3) )"
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
         Begin Table = "CUSTOMERS"
            Begin Extent = 
               Top = 6
               Left = 357
               Bottom = 114
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DNB_DATA"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 319
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SIC_LOOKUP"
            Begin Extent = 
               Top = 6
               Left = 546
               Bottom = 84
               Right = 697
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 114
               Left = 233
               Bottom = 222
               Right = 385
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
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_CUST_INFO';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_CUST_INFO';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_CUST_INFO';

