﻿CREATE TABLE [ax].[PurchLine] (
    [PURCHID]                      NVARCHAR (20)    NOT NULL,
    [LINENUM]                      NUMERIC (28, 12) NOT NULL,
    [ITEMID]                       NVARCHAR (40)    NOT NULL,
    [PURCHSTATUS]                  INT              NOT NULL,
    [SHIPPINGDATEREQUESTED]        DATETIME         NOT NULL,
    [LEDGERACCOUNT]                NVARCHAR (40)    NOT NULL,
    [DELIVERYDATE]                 DATETIME         NOT NULL,
    [NAME]                         NVARCHAR (1000)  NOT NULL,
    [TAXGROUP]                     NVARCHAR (30)    NOT NULL,
    [QTYORDERED]                   NUMERIC (28, 12) NOT NULL,
    [PURCHRECEIVEDNOW]             NUMERIC (28, 12) NOT NULL,
    [REMAINPURCHPHYSICAL]          NUMERIC (28, 12) NOT NULL,
    [REMAINPURCHFINANCIAL]         NUMERIC (28, 12) NOT NULL,
    [PRICEUNIT]                    NUMERIC (28, 12) NOT NULL,
    [PURCHPRICE]                   NUMERIC (28, 12) NOT NULL,
    [CURRENCYCODE]                 NVARCHAR (3)     NOT NULL,
    [LINEPERCENT]                  NUMERIC (28, 12) NOT NULL,
    [LINEDISC]                     NUMERIC (28, 12) NOT NULL,
    [LINEAMOUNT]                   NUMERIC (28, 12) NOT NULL,
    [EXTERNALITEMID]               NVARCHAR (20)    NOT NULL,
    [PURCHUNIT]                    NVARCHAR (30)    NOT NULL,
    [DIMENSION]                    NVARCHAR (30)    NOT NULL,
    [DIMENSION2_]                  NVARCHAR (30)    NOT NULL,
    [DIMENSION3_]                  NVARCHAR (30)    NOT NULL,
    [CONFIRMEDDLV]                 DATETIME         NOT NULL,
    [ADDRESSREFRECID]              BIGINT           NOT NULL,
    [INVENTTRANSID]                NVARCHAR (20)    NOT NULL,
    [VENDGROUP]                    NVARCHAR (30)    NOT NULL,
    [VENDACCOUNT]                  NVARCHAR (40)    NOT NULL,
    [ADDRESSREFTABLEID]            INT              NOT NULL,
    [PURCHQTY]                     NUMERIC (28, 12) NOT NULL,
    [PURCHMARKUP]                  NUMERIC (28, 12) NOT NULL,
    [INVENTRECEIVEDNOW]            NUMERIC (28, 12) NOT NULL,
    [MULTILNDISC]                  NUMERIC (28, 12) NOT NULL,
    [MULTILNPERCENT]               NUMERIC (28, 12) NOT NULL,
    [PURCHASETYPE]                 INT              NOT NULL,
    [COVREF]                       INT              NOT NULL,
    [REMAININVENTPHYSICAL]         NUMERIC (28, 12) NOT NULL,
    [TAXITEMGROUP]                 NVARCHAR (30)    NOT NULL,
    [SHIPPINGDATECONFIRMED]        DATETIME         NOT NULL,
    [TAXAUTOGENERATED]             INT              NOT NULL,
    [UNDERDELIVERYPCT]             NUMERIC (28, 12) NOT NULL,
    [OVERDELIVERYPCT]              NUMERIC (28, 12) NOT NULL,
    [TAX1099BOX]                   NVARCHAR (30)    NOT NULL,
    [TAX1099AMOUNT]                NUMERIC (28, 12) NOT NULL,
    [BARCODE]                      NVARCHAR (80)    NOT NULL,
    [BARCODETYPE]                  NVARCHAR (30)    NOT NULL,
    [INVENTREFID]                  NVARCHAR (20)    NOT NULL,
    [INVENTREFTRANSID]             NVARCHAR (20)    NOT NULL,
    [ITEMREFTYPE]                  INT              NOT NULL,
    [PROJTRANSID]                  NVARCHAR (20)    NOT NULL,
    [BLOCKED]                      INT              NOT NULL,
    [COMPLETE]                     INT              NOT NULL,
    [REQPLANIDSCHED]               NVARCHAR (10)    NOT NULL,
    [REQPOID]                      NVARCHAR (20)    NOT NULL,
    [ITEMROUTEID]                  NVARCHAR (40)    NOT NULL,
    [ITEMBOMID]                    NVARCHAR (40)    NOT NULL,
    [LINEHEADER]                   NVARCHAR (80)    NOT NULL,
    [SCRAP]                        INT              NOT NULL,
    [RETURNACTIONID]               NVARCHAR (30)    NOT NULL,
    [PROJCATEGORYID]               NVARCHAR (10)    NOT NULL,
    [PROJID]                       NVARCHAR (10)    NOT NULL,
    [INVENTDIMID]                  NVARCHAR (20)    NOT NULL,
    [ASSETID]                      NVARCHAR (40)    NOT NULL,
    [ASSETTRANSTYPEPURCH]          INT              NOT NULL,
    [ASSETBOOKID]                  NVARCHAR (10)    NOT NULL,
    [PROJLINEPROPERTYID]           NVARCHAR (10)    NOT NULL,
    [PROJTAXITEMGROUPID]           NVARCHAR (30)    NOT NULL,
    [PROJTAXGROUPID]               NVARCHAR (30)    NOT NULL,
    [PROJSALESPRICE]               NUMERIC (28, 12) NOT NULL,
    [PROJSALESCURRENCYID]          NVARCHAR (3)     NOT NULL,
    [PROJSALESUNITID]              NVARCHAR (30)    NOT NULL,
    [DELIVERYADDRESS]              NVARCHAR (250)   NOT NULL,
    [DELIVERYNAME]                 NVARCHAR (100)   NOT NULL,
    [DELIVERYSTREET]               NVARCHAR (250)   NOT NULL,
    [DELIVERYZIPCODE]              NVARCHAR (10)    NOT NULL,
    [DELIVERYCITY]                 NVARCHAR (100)   NOT NULL,
    [DELIVERYCOUNTY]               NVARCHAR (30)    NOT NULL,
    [DELIVERYSTATE]                NVARCHAR (30)    NOT NULL,
    [DELIVERYCOUNTRYREGIONID]      NVARCHAR (30)    NOT NULL,
    [DELIVERYTYPE]                 INT              NOT NULL,
    [CUSTOMERREF]                  NVARCHAR (100)   NOT NULL,
    [CUSTPURCHASEORDERFORMNUM]     NVARCHAR (50)    NOT NULL,
    [BLANKETREFTRANSID]            NVARCHAR (20)    NOT NULL,
    [TAX1099STATE]                 NVARCHAR (30)    NOT NULL,
    [TAX1099STATEAMOUNT]           NUMERIC (28, 12) NOT NULL,
    [REMAININVENTFINANCIAL]        NUMERIC (28, 12) NOT NULL,
    [PURCHREQLINEREFID]            UNIQUEIDENTIFIER NOT NULL,
    [ACTIVITYNUMBER]               NVARCHAR (10)    NOT NULL,
    [RETURNSTATUS]                 INT              NOT NULL,
    [RETURNDISPOSITIONCODEID]      NVARCHAR (10)    NOT NULL,
    [CREATEFIXEDASSET]             INT              NOT NULL,
    [ASSETGROUP]                   NVARCHAR (30)    NOT NULL,
    [REQUISITIONER]                NVARCHAR (40)    NOT NULL,
    [REQATTENTION]                 NVARCHAR (255)   NOT NULL,
    [PURCHREQID]                   NVARCHAR (20)    NOT NULL,
    [SEMLINENUMREF]                NUMERIC (28, 12) NOT NULL,
    [SEMCOMMENTS]                  NVARCHAR (50)    NOT NULL,
    [SEMSERVICELOT]                NVARCHAR (20)    NOT NULL,
    [SEMLINENUM]                   INT              NOT NULL,
    [SEMSCHEDULENUM]               INT              NOT NULL,
    [SEMLINEQTY]                   NUMERIC (28, 12) NOT NULL,
    [SEMVENDSCHEDULENUM]           NVARCHAR (25)    NOT NULL,
    [SEMOVERLINEAMOUNT]            NUMERIC (28, 12) NOT NULL,
    [SEMBOMROUTE]                  INT              NOT NULL,
    [SEMITEMIDREF]                 NVARCHAR (40)    NOT NULL,
    [SEMPONOTES]                   NVARCHAR (60)    NOT NULL,
    [SEMINSPECTIONREQ]             INT              NOT NULL,
    [SEMSALESLINEINVENTTRANSID]    NVARCHAR (20)    NOT NULL,
    [SEMPARENTSALESINVENTTRANSID]  NVARCHAR (20)    NOT NULL,
    [CREATEDDATETIME]              DATETIME         NOT NULL,
    [DATAAREAID]                   NVARCHAR (4)     NOT NULL,
    [RECVERSION]                   INT              NOT NULL,
    [RECID]                        BIGINT           NOT NULL,
    [TRANSACTIONCODE]              NVARCHAR (30)    NOT NULL,
    [TRANSPORT]                    NVARCHAR (30)    NOT NULL,
    [STATPROCID]                   NVARCHAR (10)    NOT NULL,
    [PORT]                         NVARCHAR (30)    NOT NULL,
    [STATTRIANGULARDEAL]           INT              NOT NULL,
    [INVENTTAXABLE]                INT              NOT NULL,
    [SEMISUPDATEDSINCEPURCHPOSTED] INT              NOT NULL,
    [MODIFIEDDATETIME]             DATETIME         NULL,
    [MODIFIEDBY]                   NVARCHAR (5)     NULL,
    [CREATEDBY]                    NVARCHAR (5)     NULL
);

