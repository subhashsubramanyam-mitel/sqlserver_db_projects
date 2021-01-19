/****** Script for SelectTopNRows command from SSMS  ******/

CREATE view V_STAFFING_LOOKUP  as
-- MW 06172020 bringing here to link to walker datasource
SELECT [Staffing_WorkdayName]
      ,[Staffing_OrderPM_BOSS] collate database_default as Staffing_OrderPM_BOSS
      ,[Staffing_OrderAssignee]
      ,[Staffing_OrderAssigneeManager]
      ,[Staffing_OrderAssigneeGroup]
      ,[Staffing_OrderAssigneeCenter]
      ,[Staffing_OrderAssigneeRegion]
      ,[Staffing_OrderAssigneeStatus]
      ,[Staffing_OrderAssigneePOD]
      ,[Staffing_OrderAssigneeStartDate]
      ,[Staffing_OrderAssigneeEndDate]
      ,[Staffing_CalcPMMRRGoalfortheMonth]
  FROM SVLBIDB.[FinanceBI].[Tableau].[ActivationsStaffing]