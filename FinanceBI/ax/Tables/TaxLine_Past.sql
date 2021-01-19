CREATE TABLE [ax].[TaxLine_Past] (
    [SALESID]                 NVARCHAR (20)    NOT NULL,
    [LINENUM]                 NUMERIC (28, 12) NOT NULL,
    [STATE]                   NVARCHAR (30)    NOT NULL,
    [CUSTINVOICEID]           NVARCHAR (20)    NOT NULL,
    [CUSTACCOUNT]             NVARCHAR (40)    NOT NULL,
    [TAXTYPECODE]             NVARCHAR (3)     NOT NULL,
    [TAXTYPEDESC]             NVARCHAR (50)    NOT NULL,
    [COUNTY]                  NVARCHAR (60)    NOT NULL,
    [TAXAMOUNT]               NUMERIC (28, 12) NOT NULL,
    [REVENUE]                 NUMERIC (28, 12) NOT NULL,
    [CITY]                    NVARCHAR (100)   NOT NULL,
    [TAXRATE]                 NUMERIC (28, 12) NOT NULL,
    [PERCENTTAXABLE]          INT              NOT NULL,
    [REVENUEBASE]             NUMERIC (28, 12) NOT NULL,
    [TAXONTAX]                NUMERIC (28, 12) NOT NULL,
    [CONSUMETYPE]             INT              NOT NULL,
    [ITEMID]                  NVARCHAR (40)    NOT NULL,
    [REFRECID]                BIGINT           NOT NULL,
    [FEERATE]                 NUMERIC (28, 12) NOT NULL,
    [VALUE]                   NUMERIC (28, 12) NOT NULL,
    [TAXCODE]                 INT              NOT NULL,
    [TRANSID]                 NVARCHAR (10)    NOT NULL,
    [DELIVERYCOUNTRYREGIONID] NVARCHAR (30)    NOT NULL,
    [PARMID]                  NVARCHAR (20)    NOT NULL,
    [DATAAREAID]              NVARCHAR (4)     NOT NULL,
    [RECVERSION]              INT              NOT NULL,
    [RECID]                   BIGINT           NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-CUST-SalesID-LineNum]
    ON [ax].[TaxLine_Past]([CUSTACCOUNT] ASC, [SALESID] ASC, [LINENUM] ASC);

