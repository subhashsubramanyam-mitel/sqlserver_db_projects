CREATE TABLE [dbo].[LEDGERTABLE] (
    [ACCOUNTNUM]           NVARCHAR (40)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ACCOUNTNAME]          NVARCHAR (60)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ACCOUNTPLTYPE]        INT            NOT NULL,
    [OFFSETACCOUNT]        NVARCHAR (40)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [LEDGERCLOSING]        INT            NOT NULL,
    [TAXGROUP]             NVARCHAR (30)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [BLOCKEDINJOURNAL]     INT            NOT NULL,
    [DEBCREDPROPOSAL]      INT            NOT NULL,
    [DIMENSION]            NVARCHAR (30)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION2_]          NVARCHAR (30)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION3_]          NVARCHAR (30)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CONVERSIONPRINCIPLE]  INT            NOT NULL,
    [OPENINGACCOUNT]       NVARCHAR (40)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [COMPANYGROUPACCOUNT]  NVARCHAR (10)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMSPEC]              INT            NOT NULL,
    [TAXCODE]              NVARCHAR (30)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [MANDATORYTAXCODE]     INT            NOT NULL,
    [CURRENCYCODE]         NVARCHAR (3)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [MANDATORYCURRENCY]    INT            NOT NULL,
    [AUTOALLOCATE]         INT            NOT NULL,
    [POSTING]              INT            NOT NULL,
    [MANDATORYPOSTING]     INT            NOT NULL,
    [USER_]                NVARCHAR (5)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
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
    [ACCOUNTNAMEALIAS]     NVARCHAR (100) COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CLOSED]               INT            NOT NULL,
    [DEBCREDBALANCEDEMAND] INT            NOT NULL,
    [TAXFREE]              INT            NOT NULL,
    [TAXITEMGROUP]         NVARCHAR (30)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [MONETARY]             INT            NOT NULL,
    [ACCOUNTCATEGORYREF]   INT            NOT NULL,
    [SEMPUBLISH]           INT            NOT NULL,
    [DATAAREAID]           NVARCHAR (4)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RECVERSION]           INT            NOT NULL,
    [RECID]                BIGINT         NOT NULL,
    [MODIFIEDDATETIME]     DATETIME       NOT NULL,
    [MODIFIEDBY]           NVARCHAR (5)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CREATEDDATETIME]      DATETIME       NOT NULL,
    [CREATEDBY]            NVARCHAR (5)   COLLATE Latin1_General_CI_AS_KS NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[LEDGERTABLE] TO [CANDY\dherskovich]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LEDGERTABLE] TO [CANDY\etlprod]
    AS [dbo];

