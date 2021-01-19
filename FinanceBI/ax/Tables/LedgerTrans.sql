CREATE TABLE [ax].[LedgerTrans] (
    [ACCOUNTNUM]              NVARCHAR (40)    NOT NULL,
    [TRANSDATE]               DATETIME         NOT NULL,
    [VOUCHER]                 NVARCHAR (20)    NOT NULL,
    [TXT]                     NVARCHAR (100)   NOT NULL,
    [AMOUNTMST]               NUMERIC (28, 12) NOT NULL,
    [AMOUNTCUR]               NUMERIC (28, 12) NOT NULL,
    [CURRENCYCODE]            NVARCHAR (3)     NOT NULL,
    [TRANSTYPE]               INT              NOT NULL,
    [DIMENSION]               NVARCHAR (30)    NOT NULL,
    [DIMENSION2_]             NVARCHAR (30)    NOT NULL,
    [DIMENSION3_]             NVARCHAR (30)    NOT NULL,
    [QTY]                     NUMERIC (28, 12) NOT NULL,
    [DOCUMENTDATE]            DATETIME         NOT NULL,
    [JOURNALNUM]              NVARCHAR (10)    NOT NULL,
    [ALLOCATELEVEL]           INT              NOT NULL,
    [POSTING]                 INT              NOT NULL,
    [CORRECT]                 INT              NOT NULL,
    [CREDITING]               INT              NOT NULL,
    [DOCUMENTNUM]             NVARCHAR (20)    NOT NULL,
    [PAYMREFERENCE]           NVARCHAR (20)    NOT NULL,
    [PERIODCODE]              INT              NOT NULL,
    [OPERATIONSTAX]           INT              NOT NULL,
    [THIRDPARTYBANKACCOUNTID] NVARCHAR (10)    NOT NULL,
    [COMPANYBANKACCOUNTID]    NVARCHAR (10)    NOT NULL,
    [PAYMMODE]                NVARCHAR (30)    NOT NULL,
    [FURTHERPOSTINGTYPE]      INT              NOT NULL,
    [LEDGERPOSTINGJOURNALID]  NVARCHAR (30)    NOT NULL,
    [TAXREFID]                INT              NOT NULL,
    [CONSOLIDATEDCOMPANY]     NVARCHAR (4)     NOT NULL,
    [REASONREFRECID]          BIGINT           NOT NULL,
    [PROJID_SA]               NVARCHAR (10)    NOT NULL,
    [MODIFIEDDATETIME]        DATETIME         NOT NULL,
    [MODIFIEDBY]              NVARCHAR (5)     NOT NULL,
    [CREATEDDATETIME]         DATETIME         NOT NULL,
    [CREATEDBY]               NVARCHAR (5)     NOT NULL,
    [CREATEDTRANSACTIONID]    BIGINT           NOT NULL,
    [DATAAREAID]              NVARCHAR (4)     NOT NULL,
    [RECVERSION]              INT              NOT NULL,
    [RECID]                   BIGINT           NOT NULL
);


GO
CREATE CLUSTERED INDEX [TransDate_idx]
    ON [ax].[LedgerTrans]([TRANSDATE] ASC);


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\alossing]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [Candy\amohandas]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\brobison]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [Candy\BPaddock]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\MBrondum]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\beswanson]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\dorr]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\eabramov]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\jkappes]
    AS [dbo];


GO
DENY SELECT
    ON OBJECT::[ax].[LedgerTrans] TO [CANDY\bdavis]
    AS [dbo];

