CREATE TABLE [dbo].[Employees] (
    [LastName]  NVARCHAR (255) NULL,
    [FirstName] NVARCHAR (255) NULL,
    [JobTitle]  NVARCHAR (255) NULL,
    [Login]     VARCHAR (100)  NULL,
    [Team]      NVARCHAR (255) NULL,
    [MrMs]      NVARCHAR (255) NULL,
    [WorkPhone] NVARCHAR (255) NULL,
    [WorkFax]   NVARCHAR (255) NULL,
    [Email]     NVARCHAR (255) NULL,
    [Division]  NVARCHAR (255) NULL,
    [EmpGroup]  NVARCHAR (255) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Employees] TO [TacEngRole]
    AS [dbo];

