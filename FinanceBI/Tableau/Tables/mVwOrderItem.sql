CREATE TABLE [Tableau].[mVwOrderItem] (
    [ServiceId]        INT           NULL,
    [OrderId]          INT           NOT NULL,
    [DateProcessed]    DATE          NULL,
    [DateBillingStart] DATE          NULL,
    [Quantity]         INT           NULL,
    [OrderItemType]    NVARCHAR (50) NOT NULL
);

