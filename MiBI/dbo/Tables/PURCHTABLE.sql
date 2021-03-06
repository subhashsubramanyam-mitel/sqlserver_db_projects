﻿CREATE TABLE [dbo].[PURCHTABLE] (
    [PURCHID]                        NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHNAME]                      NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ORDERACCOUNT]                   NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INVOICEACCOUNT]                 NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [FREIGHTZONE]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [EMAIL]                          NVARCHAR (80)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYDATE]                   DATETIME         NOT NULL,
    [DELIVERYTYPE]                   INT              NOT NULL,
    [ADDRESSREFRECID]                BIGINT           NOT NULL,
    [ADDRESSREFTABLEID]              INT              NOT NULL,
    [INTERCOMPANYORIGINALSALESID]    NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INTERCOMPANYORIGINALCUSTACCO12] NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CURRENCYCODE]                   NVARCHAR (3)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PAYMENT]                        NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CASHDISC]                       NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHPLACER]                    NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [VENDGROUP]                      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [LINEDISC]                       NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DISCPERCENT]                    NUMERIC (28, 12) NOT NULL,
    [DIMENSION]                      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION2_]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION3_]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PRICEGROUPID]                   NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [MULTILINEDISC]                  NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ENDDISC]                        NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INTERCOMPANYCUSTPURCHORDERFO26] NVARCHAR (50)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYADDRESS]                NVARCHAR (250)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TAXGROUP]                       NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DLVTERM]                        NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DLVMODE]                        NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHSTATUS]                    INT              NOT NULL,
    [MARKUPGROUP]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHASETYPE]                   INT              NOT NULL,
    [URL]                            NVARCHAR (255)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [POSTINGPROFILE]                 NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYZIPCODE]                NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DLVCOUNTY]                      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DLVCOUNTRYREGIONID]             NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DLVSTATE]                       NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SETTLEVOUCHER]                  INT              NOT NULL,
    [CASHDISCPERCENT]                NUMERIC (28, 12) NOT NULL,
    [DELIVERYNAME]                   NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [COVSTATUS]                      INT              NOT NULL,
    [PAYMENTSCHED]                   NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INVENTSITEID]                   NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ONETIMEVENDOR]                  INT              NOT NULL,
    [RETURNITEMNUM]                  NVARCHAR (15)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [FREIGHTSLIPTYPE]                INT              NOT NULL,
    [DOCUMENTSTATUS]                 INT              NOT NULL,
    [CONTACTPERSONID]                NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INVENTLOCATIONID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMBUYERGROUPID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJID]                         NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PURCHPOOLID]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [VATNUM]                         NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INCLTAX]                        INT              NOT NULL,
    [NUMBERSEQUENCEGROUP]            NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [LANGUAGEID]                     NVARCHAR (7)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [AUTOSUMMARYMODULETYPE]          INT              NOT NULL,
    [PAYMMODE]                       NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PAYMSPEC]                       NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [FIXEDDUEDATE]                   DATETIME         NOT NULL,
    [DELIVERYCITY]                   NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DELIVERYSTREET]                 NVARCHAR (250)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [VENDORREF]                      NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RETURNREASONCODEID]             NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RETURNREPLACEMENTCREATED]       INT              NOT NULL,
    [REQATTENTION]                   NVARCHAR (255)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [REQUISITIONER]                  NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CONTRACTNUM_SA]                 NVARCHAR (60)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMCOPYPURCHASEORDERS]          INT              NOT NULL,
    [SEMSSICUSTOMER]                 NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMINVENTREFID]                 NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMCOMMITDATE]                  DATETIME         NOT NULL,
    [SEMDOCDATE]                     DATETIME         NOT NULL,
    [SEMREQUESTOREMAIL]              NVARCHAR (80)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPUBLISHREQMANAGER]           INT              NOT NULL,
    [SEMREFERENCE]                   NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPREVIOUSTOTALAMOUNTOLD]      INT              NOT NULL,
    [SEMPREVIOUSTOTALAMOUNT]         NUMERIC (28, 12) NOT NULL,
    [SEMORDERTYPEID]                 NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMBLANKRELEASEDPURCHORDERS]    INT              NOT NULL,
    [SEMBLANKTOTALAMOUNT]            NUMERIC (28, 12) NOT NULL,
    [SEMUNAPPROVEDBY]                NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMORDEREDBY]                   NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPOFREIGHTTERMS]              NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMINVENTREFTYPE]               INT              NOT NULL,
    [SEMNAME]                        NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPOSTINGDATE]                 DATETIME         NOT NULL,
    [SEMREQUESTOR]                   NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMREQUISITIONID]               NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPOREQUISITIONSTATUS]         INT              NOT NULL,
    [SEMNEXTAPPROVER]                NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMDISPLAYPURCHID]              NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CREATEDDATETIME]                DATETIME         NOT NULL,
    [CREATEDBY]                      NVARCHAR (5)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DATAAREAID]                     NVARCHAR (4)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RECVERSION]                     INT              NOT NULL,
    [RECID]                          BIGINT           NOT NULL,
    [TRANSACTIONCODE]                NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PORT]                           NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TRANSPORT]                      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [STATPROCID]                     NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMISUPDATEDSINCEPURCHPOSTED]   INT              NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PURCHTABLE] TO [CANDY\dherskovich]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PURCHTABLE] TO [CANDY\etlprod]
    AS [dbo];

