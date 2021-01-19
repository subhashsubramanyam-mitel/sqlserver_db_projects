CREATE TABLE [dbo].[tmpStaffing] (
    [Workday Name]                   NVARCHAR (255) NULL,
    [OrderPM_BOSS]                   NVARCHAR (255) NULL,
    [Order Assignee]                 NVARCHAR (255) NULL,
    [Order Assignee Manager]         NVARCHAR (255) NULL,
    [Order Assignee Group]           NVARCHAR (255) NULL,
    [Order Assignee Center]          NVARCHAR (255) NULL,
    [Order Assignee Region]          NVARCHAR (255) NULL,
    [Order Assignee Status]          NVARCHAR (255) NULL,
    [Order Assignee POD]             NVARCHAR (255) NULL,
    [Order Assignee Start Date]      DATETIME       NULL,
    [Order Assignee End Date]        DATETIME       NULL,
    [Calc PM MRR Goal for the Month] MONEY          NULL
);


GO
GRANT ALTER
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT TAKE OWNERSHIP
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];


GO
GRANT VIEW CHANGE TRACKING
    ON OBJECT::[dbo].[tmpStaffing] TO [app_megasilo]
    AS [dbo];

