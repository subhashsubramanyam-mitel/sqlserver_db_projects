CREATE TABLE [Tableau].[ActivationsStaffing_01242020] (
    [Staffing_WorkdayName]              NVARCHAR (255) NULL,
    [Staffing_OrderPM_BOSS]             NVARCHAR (255) NOT NULL,
    [Staffing_OrderAssignee]            NVARCHAR (255) NULL,
    [Staffing_OrderAssigneeManager]     NVARCHAR (255) NULL,
    [Staffing_OrderAssigneeGroup]       NVARCHAR (255) NULL,
    [Staffing_OrderAssigneeCenter]      NVARCHAR (255) NULL,
    [Staffing_OrderAssigneeRegion]      NVARCHAR (255) NULL,
    [Staffing_OrderAssigneeStatus]      NVARCHAR (255) NULL,
    [Staffing_OrderAssigneePOD]         NVARCHAR (255) NULL,
    [Staffing_OrderAssigneeStartDate]   DATETIME       NULL,
    [Staffing_OrderAssigneeEndDate]     DATETIME       NULL,
    [Staffing_CalcPMMRRGoalfortheMonth] MONEY          NULL
);

