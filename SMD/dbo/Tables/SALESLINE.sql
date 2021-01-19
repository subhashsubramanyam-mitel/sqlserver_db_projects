CREATE TABLE [dbo].[SALESLINE] (
    [SALESID]             NVARCHAR (20)    NOT NULL,
    [SEMLINENUM]          INT              NOT NULL,
    [SEMPOSTINGORDERTYPE] NVARCHAR (10)    NOT NULL,
    [SEMQMSLIST]          NUMERIC (28, 12) NOT NULL,
    [SEMSBECOMP]          INT              NOT NULL,
    [semsbeparent]        NVARCHAR (20)    NOT NULL,
    [ITEMID]              NVARCHAR (40)    NOT NULL,
    [INVENTTRANSID]       NVARCHAR (20)    NOT NULL
);

