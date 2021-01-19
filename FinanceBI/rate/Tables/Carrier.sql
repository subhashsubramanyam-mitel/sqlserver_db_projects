CREATE TABLE [rate].[Carrier] (
    [CarrierId]           INT           NOT NULL,
    [CarrierAccountId]    INT           NULL,
    [CarrierName]         NVARCHAR (50) NOT NULL,
    [CarrierShortName]    NVARCHAR (16) NULL,
    [IsTNCarrier]         BIT           NOT NULL,
    [HasOutboundUSD]      BIT           NOT NULL,
    [HasOutboundINTL]     BIT           NOT NULL,
    [HasInboundTollFree]  BIT           NOT NULL,
    [InboundRate]         FLOAT (53)    NULL,
    [InboundTollfreeRate] FLOAT (53)    NULL
);

