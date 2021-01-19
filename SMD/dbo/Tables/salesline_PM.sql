CREATE TABLE [dbo].[salesline_PM] (
    [salesid]         NVARCHAR (20)    NOT NULL,
    [semsbeparent]    NVARCHAR (20)    NOT NULL,
    [LineNum]         NUMERIC (28, 12) NOT NULL,
    [SalesPrice]      NUMERIC (28, 12) NOT NULL,
    [inventtransid]   NVARCHAR (20)    NOT NULL,
    [semsbeqty]       NUMERIC (28, 12) NOT NULL,
    [semsbenetamount] NUMERIC (28, 12) NOT NULL,
    [semQMSDisc]      NUMERIC (28, 12) NOT NULL,
    [itemid]          NVARCHAR (40)    NOT NULL,
    [SEMQMSLIST]      NUMERIC (28, 12) NOT NULL,
    [salesstatus]     INT              NOT NULL,
    [lineamount]      NUMERIC (28, 12) NOT NULL
);

