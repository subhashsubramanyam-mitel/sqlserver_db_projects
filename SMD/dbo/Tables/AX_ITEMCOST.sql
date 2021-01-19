CREATE TABLE [dbo].[AX_ITEMCOST] (
    [ItemId]         NVARCHAR (40)    NOT NULL,
    [SKU]            NVARCHAR (20)    NOT NULL,
    [Price]          NUMERIC (28, 12) NOT NULL,
    [ActivationDate] DATETIME         NOT NULL
);

