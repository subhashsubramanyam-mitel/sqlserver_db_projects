CREATE TABLE [ax].[TaxTable] (
    [SALESID]               NVARCHAR (20)    NOT NULL,
    [SUCCESSFUL]            INT              NOT NULL,
    [RESPONSECODE]          NVARCHAR (4)     NOT NULL,
    [HEADERMESSAGE]         NVARCHAR (30)    NOT NULL,
    [CLIENTTRACKING]        NVARCHAR (20)    NOT NULL,
    [TOTALTAX]              NUMERIC (28, 12) NOT NULL,
    [TRANSID]               NVARCHAR (10)    NOT NULL,
    [REFRECID]              BIGINT           NOT NULL,
    [CONSUMETYPE]           INT              NOT NULL,
    [DATETIMEPROCESSED]     DATETIME         NOT NULL,
    [DATETIMEPROCESSEDTZID] INT              NOT NULL,
    [DATAAREAID]            NVARCHAR (4)     NOT NULL,
    [RECVERSION]            INT              NOT NULL,
    [RECID]                 BIGINT           NOT NULL,
    [CANCELLED]             INT              NOT NULL
);

