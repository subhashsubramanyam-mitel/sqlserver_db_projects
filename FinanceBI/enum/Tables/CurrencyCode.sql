CREATE TABLE [enum].[CurrencyCode] (
    [id]            INT          NOT NULL,
    [CurrencyCode]  CHAR (3)     NOT NULL,
    [Description]   VARCHAR (50) NOT NULL,
    [ISO4217Num]    CHAR (3)     NOT NULL,
    [DecimalDigits] INT          NOT NULL
);

