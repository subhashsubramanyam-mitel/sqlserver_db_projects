CREATE TABLE [dbo].[B_SFDC_DNB] (
    [Created]     DATETIME      CONSTRAINT [DF_B_SFDC_DNB_Created] DEFAULT (getdate()) NULL,
    [AccountId]   VARCHAR (25)  NOT NULL,
    [Employees]   FLOAT (53)    NULL,
    [SalesVolume] FLOAT (53)    NULL,
    [SICCode]     VARCHAR (50)  NULL,
    [SICDesc]     VARCHAR (300) NULL,
    CONSTRAINT [PK_B_SFDC_DNB] PRIMARY KEY CLUSTERED ([AccountId] ASC)
);

