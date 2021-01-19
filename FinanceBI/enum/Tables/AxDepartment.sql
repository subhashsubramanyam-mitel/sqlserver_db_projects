CREATE TABLE [enum].[AxDepartment] (
    [Dept Id]        NVARCHAR (8)  NOT NULL,
    [DepartmentName] NVARCHAR (64) NULL,
    [L1 Owner]       NVARCHAR (64) NULL,
    [L2 Owner]       NVARCHAR (64) NULL,
    [Dept Level1]    NVARCHAR (64) NULL,
    [Dept Level2]    NVARCHAR (64) NULL,
    [Dept Level3]    NVARCHAR (64) NULL,
    [Dept Level4]    NVARCHAR (64) NULL,
    [Dept Level5]    NVARCHAR (64) NULL,
    [IS Level1]      NVARCHAR (64) NULL,
    [IS Level2]      NVARCHAR (64) NULL,
    [Department]     AS            (([Dept Id]+' - ')+[DepartmentName]),
    CONSTRAINT [PK_AxDepartment] PRIMARY KEY CLUSTERED ([Dept Id] ASC)
);

