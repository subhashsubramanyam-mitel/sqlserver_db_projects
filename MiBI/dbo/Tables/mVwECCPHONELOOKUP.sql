CREATE TABLE [dbo].[mVwECCPHONELOOKUP] (
    [PhoneNumber]  VARCHAR (11)  NOT NULL,
    [CustomerType] VARCHAR (100) NULL,
    [Platform]     VARCHAR (50)  NULL,
    [Instance]     VARCHAR (100) NULL,
    CONSTRAINT [PK_dbo_mVwECCPHONELOOKUP] PRIMARY KEY CLUSTERED ([PhoneNumber] ASC)
);

