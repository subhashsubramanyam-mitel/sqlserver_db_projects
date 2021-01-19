CREATE TABLE [dbo].[AX_EXCHRATE_ALL] (
    [FromDate]     DATETIME         NOT NULL,
    [ToDate]       DATETIME         NOT NULL,
    [currencycode] NVARCHAR (3)     NOT NULL,
    [exchrate]     NUMERIC (28, 12) NOT NULL
);

