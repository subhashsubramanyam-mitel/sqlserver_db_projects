CREATE TABLE [dbo].[AX_ARENA_QCOGS] (
    [Created]                 DATETIME        CONSTRAINT [DF_AX_ARENA_QCOGS_Created] DEFAULT (getdate()) NOT NULL,
    [ItemNumber]              NVARCHAR (50)   NOT NULL,
    [ItemGroup]               NVARCHAR (50)   NULL,
    [ItemForm]                NVARCHAR (50)   NULL,
    [CostingType]             NVARCHAR (100)  NULL,
    [ActivationDate]          DATE            NULL,
    [QCOGS]                   NUMERIC (14, 2) NULL,
    [CostPrice]               NUMERIC (14, 2) CONSTRAINT [DF_AX_ARENA_QCOGS_CostPrice] DEFAULT ((0)) NULL,
    [SalesPrice]              NUMERIC (14, 2) CONSTRAINT [DF_AX_ARENA_QCOGS_SalesPrice] DEFAULT ((0)) NULL,
    [Revision]                INT             NULL,
    [ProfitCenter]            NVARCHAR (50)   NULL,
    [ProfitCenterDescription] NVARCHAR (255)  NULL,
    [RevType]                 NVARCHAR (100)  NULL,
    [CloudItemId]             NVARCHAR (100)  NULL,
    [RevSchedule]             NVARCHAR (50)   NULL,
    [Status]                  CHAR (1)        CONSTRAINT [DF_AX_ARENA_QCOGS_SyncStatus] DEFAULT ('N') NULL,
    [LastModified]            DATETIME        NULL,
    CONSTRAINT [PK_AX_ARENA_QCOGS] PRIMARY KEY CLUSTERED ([ItemNumber] ASC)
);

