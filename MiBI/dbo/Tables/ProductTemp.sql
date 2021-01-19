CREATE TABLE [dbo].[ProductTemp] (
    [Id]        VARCHAR (20)  NOT NULL,
    [IsActive]  VARCHAR (20)  NULL,
    [SKUNumber] VARCHAR (20)  NULL,
    [Status]    NCHAR (1)     CONSTRAINT [DF_ProductTemp_Status] DEFAULT ('N') NULL,
    [Error]     VARCHAR (500) NULL,
    [USD]       VARCHAR (20)  NULL,
    [USDAction] VARCHAR (20)  NULL,
    [USDStatus] NCHAR (1)     CONSTRAINT [DF_ProductTemp_USDStatus] DEFAULT ('N') NULL,
    [GBP]       VARCHAR (20)  NULL,
    [GBPAction] VARCHAR (20)  NULL,
    [GBPStatus] NCHAR (1)     CONSTRAINT [DF_ProductTemp_GBPStatus] DEFAULT ('N') NULL,
    [EUR]       VARCHAR (20)  NULL,
    [EURAction] VARCHAR (20)  NULL,
    [EURStatus] NCHAR (1)     CONSTRAINT [DF_ProductTemp_EURStatus] DEFAULT ('N') NULL,
    [CAD]       VARCHAR (20)  NULL,
    [CADAction] VARCHAR (20)  NULL,
    [CADStatus] NCHAR (1)     CONSTRAINT [DF_ProductTemp_CADStatus] DEFAULT ('N') NULL,
    [AUD]       VARCHAR (20)  NULL,
    [AUDAction] VARCHAR (20)  NULL,
    [AUDStatus] NCHAR (1)     CONSTRAINT [DF_ProductTemp_AUDStatus] DEFAULT ('N') NULL,
    CONSTRAINT [PK_ProductTemp] PRIMARY KEY CLUSTERED ([Id] ASC)
);

