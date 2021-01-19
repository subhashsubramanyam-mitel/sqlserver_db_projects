CREATE TABLE [cdr].[TdxTrunk] (
    [TdxTrunkId]       INT           NOT NULL,
    [Alias]            NVARCHAR (50) NOT NULL,
    [IP]               NCHAR (24)    NOT NULL,
    [IsTest]           BIT           NULL,
    [IsCarrier]        BIT           NULL,
    [CarrierShortName] NVARCHAR (50) NULL
);

