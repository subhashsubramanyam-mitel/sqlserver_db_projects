CREATE TABLE [ax].[LedgerTable] (
    [ACCOUNTNUM]           NVARCHAR (40)  NOT NULL,
    [ACCOUNTNAME]          NVARCHAR (60)  NOT NULL,
    [ACCOUNTPLTYPE]        INT            NOT NULL,
    [OFFSETACCOUNT]        NVARCHAR (40)  NOT NULL,
    [LEDGERCLOSING]        INT            NOT NULL,
    [TAXGROUP]             NVARCHAR (30)  NOT NULL,
    [BLOCKEDINJOURNAL]     INT            NOT NULL,
    [DEBCREDPROPOSAL]      INT            NOT NULL,
    [DIMENSION]            NVARCHAR (30)  NOT NULL,
    [DIMENSION2_]          NVARCHAR (30)  NOT NULL,
    [DIMENSION3_]          NVARCHAR (30)  NOT NULL,
    [CONVERSIONPRINCIPLE]  INT            NOT NULL,
    [OPENINGACCOUNT]       NVARCHAR (40)  NOT NULL,
    [COMPANYGROUPACCOUNT]  NVARCHAR (10)  NOT NULL,
    [DIMSPEC]              INT            NOT NULL,
    [TAXCODE]              NVARCHAR (30)  NOT NULL,
    [MANDATORYTAXCODE]     INT            NOT NULL,
    [CURRENCYCODE]         NVARCHAR (3)   NOT NULL,
    [MANDATORYCURRENCY]    INT            NOT NULL,
    [AUTOALLOCATE]         INT            NOT NULL,
    [POSTING]              INT            NOT NULL,
    [MANDATORYPOSTING]     INT            NOT NULL,
    [USER_]                NVARCHAR (5)   NOT NULL,
    [MANDATORYUSER]        INT            NOT NULL,
    [DEBCREDCHECK]         INT            NOT NULL,
    [REVERSESIGN]          INT            NOT NULL,
    [MANDATORYDIMENSION]   INT            NOT NULL,
    [MANDATORYDIMENSION2_] INT            NOT NULL,
    [MANDATORYDIMENSION3_] INT            NOT NULL,
    [COLUMN_]              INT            NOT NULL,
    [TAXDIRECTION]         INT            NOT NULL,
    [LINESUB]              INT            NOT NULL,
    [LINEEXCEED]           INT            NOT NULL,
    [UNDERLINENUMERALS]    INT            NOT NULL,
    [UNDERLINETXT]         INT            NOT NULL,
    [ITALIC]               INT            NOT NULL,
    [BOLDTYPEFACE]         INT            NOT NULL,
    [EXCHADJUSTED]         INT            NOT NULL,
    [ACCOUNTNAMEALIAS]     NVARCHAR (100) NOT NULL,
    [CLOSED]               INT            NOT NULL,
    [DEBCREDBALANCEDEMAND] INT            NOT NULL,
    [TAXFREE]              INT            NOT NULL,
    [TAXITEMGROUP]         NVARCHAR (30)  NOT NULL,
    [MONETARY]             INT            NOT NULL,
    [ACCOUNTCATEGORYREF]   INT            NOT NULL,
    [SEMPUBLISH]           INT            NOT NULL,
    [DATAAREAID]           NVARCHAR (4)   NOT NULL,
    [RECVERSION]           INT            NOT NULL,
    [RECID]                BIGINT         NOT NULL,
    [MODIFIEDDATETIME]     DATETIME2 (7)  NOT NULL,
    [MODIFIEDBY]           NVARCHAR (5)   NOT NULL,
    [CREATEDDATETIME]      DATETIME2 (7)  NOT NULL,
    [CREATEDBY]            NVARCHAR (5)   NOT NULL
);


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\alossing]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [Candy\amohandas]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\brobison]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [Candy\BPaddock]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\MBrondum]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\beswanson]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\dorr]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\eabramov]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\jkappes]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTable] TO [CANDY\bdavis]
    AS [dbo];

