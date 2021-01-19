

CREATE VIEW [dbo].[V_ECC_INFO]
AS
select 
			a.SR_NUM, 
			a.Status,
			a.Feature,
			a.LOGIN AS Owner,
			a.Priority,
			a.Date_Open,
			a.ACT_CLOSE_DT,
			--SRX.ATTRIB_04 as SupportProgram,	--Not found
			--a.INIT_CUST_SEV_CD as SubFeatComp, --NOT found
			a.Severity,
			a.EndUser,
			a.SR_TITLE, 
			a.Sub_Status,
			a.SR_AREA,
			a.SfdcId,
			a.SLAFlag as InSLA,
			a.LastActivity  --placeholder need Last_SLA_Update_TAC_Agent__c

from dbo.SR_HEADER_SVY a -- need to change it back
Where a.Status != 'Closed'

/*
select 
			a.SR_NUM, 
			a.SR_STAT_ID as Status ,
			SRX.ATTRIB_05 as Feature,
			U.LOGIN AS Owner,
			a.SR_PRIO_CD as Priority,
			a.CREATED as Date_Open,
			a.ACT_CLOSE_DT,
			SRX.ATTRIB_04 as SupportProgram,
			a.INIT_CUST_SEV_CD as SubFeatComp,
			a.SR_SEV_CD as Severity,
			SRX.ATTRIB_06 as End_User_Csn ,
			a.SR_TITLE, 
			a.SR_SUB_STAT_ID as Sub_Status,
			a.SR_AREA,
			a.ROW_ID as SR_ROW_ID,
			isnull (s.InSLA, case when DATEDIFF(hour, a.CREATED ,getdate()) <= 24 then 'Yes' Else 'No' END) as InSLA,
			s.LastActivity
			
from 
		SVLCORPSIEBDB.SiebelDB.dbo.S_SRV_REQ a (nolock) INNER JOIN 
		SVLCORPSIEBDB.SiebelDB.dbo.S_SRV_REQ_X SRX (NOLOCK) on a.ROW_ID = SRX.ROW_ID LEFT OUTER JOIN 
		SVLCORPSIEBDB.SiebelDB.dbo.S_USER U  (nolock) on a.OWNER_EMP_ID = U.ROW_ID left outer join
		SR_SLA s on a.SR_NUM = s.SR_NUM
	Where a.SR_STAT_ID != 'Closed'

*/
GO
GRANT SELECT
    ON OBJECT::[dbo].[V_ECC_INFO] TO [CANDY\MEdwards]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_ECC_INFO] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_ECC_INFO] TO [CANDY\CStewart]
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
         Begin Table = "SR_HEADER"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 223
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_ECC_INFO';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_ECC_INFO';

