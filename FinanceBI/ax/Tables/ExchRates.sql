CREATE TABLE [ax].[ExchRates] (
    [FROMDATE]           DATETIME         NOT NULL,
    [EXCHRATE]           NUMERIC (28, 12) NOT NULL,
    [TODATE]             DATETIME         NOT NULL,
    [CURRENCYCODE]       NVARCHAR (3)     NOT NULL,
    [DATAAREAID]         NVARCHAR (4)     NOT NULL,
    [RECVERSION]         INT              NOT NULL,
    [RECID]              BIGINT           NOT NULL,
    [GOVERNMENTEXCHRATE] INT              NOT NULL
);

