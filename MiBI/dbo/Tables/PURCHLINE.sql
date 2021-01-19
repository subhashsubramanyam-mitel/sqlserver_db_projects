﻿CREATE TABLE [dbo].[PURCHLINE] (
    [PURCHID]                      NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [LINENUM]                      NUMERIC (28, 12) NOT NULL,
    [ITEMID]                       NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHSTATUS]                  INT              NOT NULL,
    [SHIPPINGDATEREQUESTED]        DATETIME         NOT NULL,
    [LEDGERACCOUNT]                NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYDATE]                 DATETIME         NOT NULL,
    [NAME]                         NVARCHAR (1000)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TAXGROUP]                     NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [QTYORDERED]                   NUMERIC (28, 12) NOT NULL,
    [PURCHRECEIVEDNOW]             NUMERIC (28, 12) NOT NULL,
    [REMAINPURCHPHYSICAL]          NUMERIC (28, 12) NOT NULL,
    [REMAINPURCHFINANCIAL]         NUMERIC (28, 12) NOT NULL,
    [PRICEUNIT]                    NUMERIC (28, 12) NOT NULL,
    [PURCHPRICE]                   NUMERIC (28, 12) NOT NULL,
    [CURRENCYCODE]                 NVARCHAR (3)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [LINEPERCENT]                  NUMERIC (28, 12) NOT NULL,
    [LINEDISC]                     NUMERIC (28, 12) NOT NULL,
    [LINEAMOUNT]                   NUMERIC (28, 12) NOT NULL,
    [EXTERNALITEMID]               NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHUNIT]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION2_]                  NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION3_]                  NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CONFIRMEDDLV]                 DATETIME         NOT NULL,
    [ADDRESSREFRECID]              BIGINT           NOT NULL,
    [INVENTTRANSID]                NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [VENDGROUP]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [VENDACCOUNT]                  NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ADDRESSREFTABLEID]            INT              NOT NULL,
    [PURCHQTY]                     NUMERIC (28, 12) NOT NULL,
    [PURCHMARKUP]                  NUMERIC (28, 12) NOT NULL,
    [INVENTRECEIVEDNOW]            NUMERIC (28, 12) NOT NULL,
    [MULTILNDISC]                  NUMERIC (28, 12) NOT NULL,
    [MULTILNPERCENT]               NUMERIC (28, 12) NOT NULL,
    [PURCHASETYPE]                 INT              NOT NULL,
    [COVREF]                       INT              NOT NULL,
    [REMAININVENTPHYSICAL]         NUMERIC (28, 12) NOT NULL,
    [TAXITEMGROUP]                 NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SHIPPINGDATECONFIRMED]        DATETIME         NOT NULL,
    [TAXAUTOGENERATED]             INT              NOT NULL,
    [UNDERDELIVERYPCT]             NUMERIC (28, 12) NOT NULL,
    [OVERDELIVERYPCT]              NUMERIC (28, 12) NOT NULL,
    [TAX1099BOX]                   NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TAX1099AMOUNT]                NUMERIC (28, 12) NOT NULL,
    [BARCODE]                      NVARCHAR (80)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [BARCODETYPE]                  NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INVENTREFID]                  NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INVENTREFTRANSID]             NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMREFTYPE]                  INT              NOT NULL,
    [PROJTRANSID]                  NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [BLOCKED]                      INT              NOT NULL,
    [COMPLETE]                     INT              NOT NULL,
    [REQPLANIDSCHED]               NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [REQPOID]                      NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMROUTEID]                  NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMBOMID]                    NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [LINEHEADER]                   NVARCHAR (80)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SCRAP]                        INT              NOT NULL,
    [RETURNACTIONID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJCATEGORYID]               NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJID]                       NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INVENTDIMID]                  NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ASSETID]                      NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ASSETTRANSTYPEPURCH]          INT              NOT NULL,
    [ASSETBOOKID]                  NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJLINEPROPERTYID]           NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJTAXITEMGROUPID]           NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJTAXGROUPID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJSALESPRICE]               NUMERIC (28, 12) NOT NULL,
    [PROJSALESCURRENCYID]          NVARCHAR (3)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJSALESUNITID]              NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYADDRESS]              NVARCHAR (250)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYNAME]                 NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYSTREET]               NVARCHAR (250)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYZIPCODE]              NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYCITY]                 NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYCOUNTY]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYSTATE]                NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYCOUNTRYREGIONID]      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYTYPE]                 INT              NOT NULL,
    [CUSTOMERREF]                  NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CUSTPURCHASEORDERFORMNUM]     NVARCHAR (50)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [BLANKETREFTRANSID]            NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TAX1099STATE]                 NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TAX1099STATEAMOUNT]           NUMERIC (28, 12) NOT NULL,
    [REMAININVENTFINANCIAL]        NUMERIC (28, 12) NOT NULL,
    [PURCHREQLINEREFID]            UNIQUEIDENTIFIER NOT NULL,
    [ACTIVITYNUMBER]               NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RETURNSTATUS]                 INT              NOT NULL,
    [RETURNDISPOSITIONCODEID]      NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CREATEFIXEDASSET]             INT              NOT NULL,
    [ASSETGROUP]                   NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [REQUISITIONER]                NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [REQATTENTION]                 NVARCHAR (255)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHREQID]                   NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMLINENUMREF]                NUMERIC (28, 12) NOT NULL,
    [SEMCOMMENTS]                  NVARCHAR (50)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMSERVICELOT]                NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMLINENUM]                   INT              NOT NULL,
    [SEMSCHEDULENUM]               INT              NOT NULL,
    [SEMLINEQTY]                   NUMERIC (28, 12) NOT NULL,
    [SEMVENDSCHEDULENUM]           NVARCHAR (25)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMOVERLINEAMOUNT]            NUMERIC (28, 12) NOT NULL,
    [SEMBOMROUTE]                  INT              NOT NULL,
    [SEMITEMIDREF]                 NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPONOTES]                   NVARCHAR (60)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMINSPECTIONREQ]             INT              NOT NULL,
    [SEMSALESLINEINVENTTRANSID]    NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPARENTSALESINVENTTRANSID]  NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CREATEDDATETIME]              DATETIME         NOT NULL,
    [DATAAREAID]                   NVARCHAR (4)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RECVERSION]                   INT              NOT NULL,
    [RECID]                        BIGINT           NOT NULL,
    [TRANSACTIONCODE]              NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TRANSPORT]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [STATPROCID]                   NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PORT]                         NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [STATTRIANGULARDEAL]           INT              NOT NULL,
    [INVENTTAXABLE]                INT              NOT NULL,
    [SEMISUPDATEDSINCEPURCHPOSTED] INT              NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PURCHLINE] TO [CANDY\dherskovich]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PURCHLINE] TO [CANDY\etlprod]
    AS [dbo];

