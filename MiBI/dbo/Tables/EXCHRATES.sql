CREATE TABLE [dbo].[EXCHRATES] (
    [FROMDATE]           DATETIME         NOT NULL,
    [EXCHRATE]           NUMERIC (28, 12) NOT NULL,
    [TODATE]             DATETIME         NOT NULL,
    [CURRENCYCODE]       NVARCHAR (3)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DATAAREAID]         NVARCHAR (4)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RECVERSION]         INT              NOT NULL,
    [RECID]              BIGINT           NOT NULL,
    [GOVERNMENTEXCHRATE] INT              NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[EXCHRATES] TO [CANDY\dherskovich]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EXCHRATES] TO [CANDY\etlprod]
    AS [dbo];

