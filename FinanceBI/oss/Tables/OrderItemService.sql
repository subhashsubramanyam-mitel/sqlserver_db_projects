CREATE TABLE [oss].[OrderItemService] (
    [Id]                 INT           NOT NULL,
    [OrderItemId]        INT           NOT NULL,
    [ServiceId]          INT           NOT NULL,
    [DateModified]       DATETIME2 (4) NOT NULL,
    [DateCreated]        DATETIME2 (4) NOT NULL,
    [ModifiedBy]         NVARCHAR (50) NOT NULL,
    [NewServiceStatusId] INT           NULL,
    [LastMRR]            MONEY         NULL,
    [LastNRC]            MONEY         NULL,
    [CurrencyId]         INT           NULL,
    CONSTRAINT [PK_OrderItemService] PRIMARY KEY CLUSTERED ([Id] ASC)
);

