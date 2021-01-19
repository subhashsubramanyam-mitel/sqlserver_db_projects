CREATE TABLE [support].[UserProfile] (
    [UserId]       INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]    NVARCHAR (100) NULL,
    [LastName]     NVARCHAR (100) NULL,
    [EmployeeId]   NVARCHAR (100) NULL,
    [UserName]     VARCHAR (50)   NULL,
    [Password]     VARCHAR (50)   NULL,
    [IsActive]     BIT            NULL,
    [ModifiedDate] DATETIME       NULL,
    [ModifiedBy]   NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC)
);

