CREATE TABLE [dbo].[TmpOcProductSync] (
    [Sku]       VARCHAR (50)   NOT NULL,
    [M5DBId]    NVARCHAR (255) NULL,
    [ProductId] NVARCHAR (255) NULL,
    [BMNumber]  NVARCHAR (255) NULL,
    [SfdcId]    VARCHAR (50)   NULL,
    [Status]    VARCHAR (5)    CONSTRAINT [DF_TmpOcProductSync_Status] DEFAULT (N'N') NOT NULL,
    [Info]      TEXT           NULL,
    CONSTRAINT [PK_TmpOcProductSync] PRIMARY KEY CLUSTERED ([Sku] ASC)
);

