CREATE TABLE [ax].[MatVwExchRatePeriod_Base] (
    [CURRENCYCODE] NVARCHAR (3)     NOT NULL,
    [EXCHRATE]     NUMERIC (28, 12) NOT NULL,
    [DateFrom]     DATETIME         NULL,
    [DateTo]       DATETIME         NULL,
    [RECID]        BIGINT           NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160619-181138]
    ON [ax].[MatVwExchRatePeriod_Base]([DateFrom] ASC, [DateTo] ASC, [CURRENCYCODE] ASC);

