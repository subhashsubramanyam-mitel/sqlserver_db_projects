CREATE TABLE [rate].[CarrierInternational] (
    [RateId]              INT           NOT NULL,
    [Carrier]             NVARCHAR (50) NULL,
    [DESTINATION GROUP]   NVARCHAR (50) NULL,
    [DESTINATION]         NVARCHAR (50) NULL,
    [Rate]                FLOAT (53)    NULL,
    [Billing Model]       NVARCHAR (50) NULL,
    [Effective From]      DATETIME      NULL,
    [INCR/DECR]           NVARCHAR (50) NULL,
    [COMMENTS]            NVARCHAR (50) NULL,
    [Code Effective Date] DATETIME      NULL,
    [Country Code]        NVARCHAR (10) NULL,
    [Area Code]           NVARCHAR (51) NULL,
    [Prefix]              NVARCHAR (64) NULL,
    [PrefixLen]           INT           NULL,
    [CountryCodeLen]      INT           NULL
);


GO
CREATE NONCLUSTERED INDEX [Idx_Prefix_AreaCode_Carrier]
    ON [rate].[CarrierInternational]([Prefix] ASC, [Area Code] ASC, [Carrier] ASC);

