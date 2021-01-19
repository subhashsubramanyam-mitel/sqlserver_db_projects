CREATE TABLE [dbo].[AX_QCOGS_ARENA] (
    [Created]        DATETIME         CONSTRAINT [DF_AX_QCOGS_ARENA_Created] DEFAULT (getdate()) NOT NULL,
    [ITEMID]         NVARCHAR (50)    NOT NULL,
    [QCOGS]          NUMERIC (28, 12) NULL,
    [ACTIVATIONDATE] DATETIME         NULL,
    [ITEMNAME]       NVARCHAR (100)   NULL,
    [ITEMGROUPID]    NVARCHAR (50)    NULL,
    [NAMEALIAS]      NVARCHAR (50)    NULL,
    [DATAAREAID]     NVARCHAR (10)    NULL,
    [RECVERSION]     INT              NULL,
    [RECID]          BIGINT           NULL,
    [CostPrice]      NUMERIC (28, 12) CONSTRAINT [DF_AX_QCOGS_ARENA_CostPrice] DEFAULT ((0)) NULL,
    [SalesPrice]     NUMERIC (28, 12) CONSTRAINT [DF_AX_QCOGS_ARENA_SalesPrice] DEFAULT ((0)) NULL,
    [Status]         CHAR (1)         CONSTRAINT [DF_AX_QCOGS_ARENA_SyncStatus] DEFAULT ('N') NULL,
    [LastModified]   DATETIME         NULL,
    CONSTRAINT [PK_AX_QCOGS_ARENA] PRIMARY KEY CLUSTERED ([ITEMID] ASC)
);

