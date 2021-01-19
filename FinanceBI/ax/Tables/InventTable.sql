﻿CREATE TABLE [ax].[InventTable] (
    [ITEMGROUPID]                    NVARCHAR (30)    NOT NULL,
    [ITEMID]                         NVARCHAR (40)    NOT NULL,
    [ITEMNAME]                       NVARCHAR (100)   NOT NULL,
    [ITEMTYPE]                       INT              NOT NULL,
    [PURCHMODEL]                     INT              NOT NULL,
    [HEIGHT]                         NUMERIC (28, 12) NOT NULL,
    [WIDTH]                          NUMERIC (28, 12) NOT NULL,
    [SALESMODEL]                     INT              NOT NULL,
    [COSTGROUPID]                    NVARCHAR (30)    NOT NULL,
    [REQGROUPID]                     NVARCHAR (10)    NOT NULL,
    [EPCMANAGER]                     NUMERIC (28, 12) NOT NULL,
    [PRIMARYVENDORID]                NVARCHAR (40)    NOT NULL,
    [NETWEIGHT]                      NUMERIC (28, 12) NOT NULL,
    [DEPTH]                          NUMERIC (28, 12) NOT NULL,
    [UNITVOLUME]                     NUMERIC (28, 12) NOT NULL,
    [BOMUNITID]                      NVARCHAR (30)    NOT NULL,
    [ITEMPRICETOLERANCEGROUPID]      NVARCHAR (30)    NOT NULL,
    [DENSITY]                        NUMERIC (28, 12) NOT NULL,
    [DIMENSION]                      NVARCHAR (30)    NOT NULL,
    [DIMENSION2_]                    NVARCHAR (30)    NOT NULL,
    [DIMENSION3_]                    NVARCHAR (30)    NOT NULL,
    [COSTMODEL]                      INT              NOT NULL,
    [USEALTITEMID]                   INT              NOT NULL,
    [ALTITEMID]                      NVARCHAR (40)    NOT NULL,
    [PRODFLUSHINGPRINCIP]            INT              NOT NULL,
    [PBAITEMAUTOGENERATED]           INT              NOT NULL,
    [WMSARRIVALHANDLINGTIME]         INT              NOT NULL,
    [BOMMANUALRECEIPT]               INT              NOT NULL,
    [STOPEXPLODE]                    INT              NOT NULL,
    [PHANTOM]                        INT              NOT NULL,
    [BOMLEVEL]                       INT              NOT NULL,
    [BATCHNUMGROUPID]                NVARCHAR (30)    NOT NULL,
    [AUTOREPORTFINISHED]             INT              NOT NULL,
    [ALTCONFIGID]                    NVARCHAR (30)    NOT NULL,
    [STANDARDCONFIGID]               NVARCHAR (30)    NOT NULL,
    [PRODPOOLID]                     NVARCHAR (30)    NOT NULL,
    [ABCTIEUP]                       INT              NOT NULL,
    [ABCREVENUE]                     INT              NOT NULL,
    [ABCVALUE]                       INT              NOT NULL,
    [ABCCONTRIBUTIONMARGIN]          INT              NOT NULL,
    [CONFIGURABLE]                   INT              NOT NULL,
    [SALESPERCENTMARKUP]             NUMERIC (28, 12) NOT NULL,
    [SALESCONTRIBUTIONRATIO]         NUMERIC (28, 12) NOT NULL,
    [SALESPRICEMODELBASIC]           INT              NOT NULL,
    [NAMEALIAS]                      NVARCHAR (20)    NOT NULL,
    [PRODGROUPID]                    NVARCHAR (30)    NOT NULL,
    [PROJCATEGORYID]                 NVARCHAR (10)    NOT NULL,
    [GROSSDEPTH]                     NUMERIC (28, 12) NOT NULL,
    [GROSSWIDTH]                     NUMERIC (28, 12) NOT NULL,
    [GROSSHEIGHT]                    NUMERIC (28, 12) NOT NULL,
    [SORTCODE]                       INT              NOT NULL,
    [CONFIGSIMILAR]                  INT              NOT NULL,
    [SERIALNUMGROUPID]               NVARCHAR (30)    NOT NULL,
    [DIMGROUPID]                     NVARCHAR (10)    NOT NULL,
    [MODELGROUPID]                   NVARCHAR (30)    NOT NULL,
    [ITEMBUYERGROUPID]               NVARCHAR (30)    NOT NULL,
    [TAXPACKAGINGQTY]                NUMERIC (28, 12) NOT NULL,
    [TARAWEIGHT]                     NUMERIC (28, 12) NOT NULL,
    [PACKAGINGGROUPID]               NVARCHAR (30)    NOT NULL,
    [SCRAPVAR]                       NUMERIC (28, 12) NOT NULL,
    [SCRAPCONST]                     NUMERIC (28, 12) NOT NULL,
    [STANDARDINVENTCOLORID]          NVARCHAR (30)    NOT NULL,
    [STANDARDINVENTSIZEID]           NVARCHAR (30)    NOT NULL,
    [ITEMDIMCOMBINATIONAUTOCREATE]   INT              NOT NULL,
    [ITEMDIMCOSTPRICE]               INT              NOT NULL,
    [ALTINVENTSIZEID]                NVARCHAR (30)    NOT NULL,
    [ALTINVENTCOLORID]               NVARCHAR (30)    NOT NULL,
    [BOMCALCGROUPID]                 NVARCHAR (30)    NOT NULL,
    [SEMUSEROUTINGYIELD]             INT              NOT NULL,
    [SEMBOMOBSOLETE]                 INT              NOT NULL,
    [SEMBOMDESIGNATION]              INT              NOT NULL,
    [SEMFUSE]                        NVARCHAR (10)    NOT NULL,
    [SEMPUBLISH]                     INT              NOT NULL,
    [SEMMFGCOMMENTS]                 NTEXT            NULL,
    [SEMLASTORDERDATE]               DATETIME2 (7)    NOT NULL,
    [SEMLASTSHIPDATE]                DATETIME2 (7)    NOT NULL,
    [SEMPRODUCTLINE]                 NVARCHAR (10)    NOT NULL,
    [SEMUSEBOMQTY]                   INT              NOT NULL,
    [SEMCOMPONENTISSUEQTY]           NUMERIC (28, 12) NOT NULL,
    [SEMINVENTDIMID]                 NVARCHAR (20)    NOT NULL,
    [SEMAVLON]                       INT              NOT NULL,
    [SEMAVLSELECTION]                INT              NOT NULL,
    [SEMITEMPACKAGEID]               NVARCHAR (25)    NOT NULL,
    [SEMITEMFAMILYID]                NVARCHAR (25)    NOT NULL,
    [SEMTIMEDRIVENITEM]              INT              NOT NULL,
    [SEMBOMMANUALCONSUMP]            INT              NOT NULL,
    [SEMPRIMARYPARTFLAG]             INT              NOT NULL,
    [SEMDIEATTACH]                   INT              NOT NULL,
    [SEMCAPEX]                       INT              NOT NULL,
    [SEMBUSINESSUNIT]                NVARCHAR (10)    NOT NULL,
    [SEMBUSINESSGROUP]               NVARCHAR (10)    NOT NULL,
    [SEMLIFECYCLESTAGE]              INT              NOT NULL,
    [SEMVERSIONID]                   INT              NOT NULL,
    [SEMSAMPLESIZE]                  INT              NOT NULL,
    [SEMEXPENSE]                     INT              NOT NULL,
    [DATAAREAID]                     NVARCHAR (4)     NOT NULL,
    [RECVERSION]                     INT              NOT NULL,
    [RECID]                          BIGINT           NOT NULL,
    [INTRACODE]                      NVARCHAR (30)    NOT NULL,
    [INTRAUNIT]                      NUMERIC (28, 12) NOT NULL,
    [ORIGCOUNTRYREGIONID]            NVARCHAR (30)    NOT NULL,
    [STATISTICSFACTOR]               NUMERIC (28, 12) NOT NULL,
    [ORIGSTATEID]                    NVARCHAR (30)    NOT NULL,
    [SEMPERCENTOFLIST]               NUMERIC (28, 12) NOT NULL,
    [SEMVSOEESTABLISHED]             INT              NOT NULL,
    [SEMCALCMEDIANPRICE]             INT              NOT NULL,
    [SEMVSOEGP]                      NVARCHAR (10)    NOT NULL,
    [SEMREVENUETYPE]                 INT              NOT NULL,
    [SEMDEFAULTREVENUERECOGNIT40006] NVARCHAR (10)    NOT NULL,
    [SEMOVERWRITECALCMEDIAN]         INT              NOT NULL,
    [SEMDEMOKIT]                     INT              NOT NULL,
    [SEMSBE]                         INT              NOT NULL,
    [INVENTTAXABLE]                  INT              NOT NULL,
    [MODIFIEDDATETIME]               DATETIME2 (7)    NOT NULL,
    [MODIFIEDBY]                     NVARCHAR (5)     NOT NULL,
    [CREATEDDATETIME]                DATETIME2 (7)    NOT NULL,
    [CREATEDBY]                      NVARCHAR (5)     NOT NULL,
    [DMMCONCESSIONDISC]              INT              NOT NULL,
    [DMMECC]                         INT              NOT NULL,
    [STM5ITEMID]                     NVARCHAR (30)    NOT NULL,
    [STCLOUDITEMCLASSID]             NVARCHAR (30)    NOT NULL,
    [SEMBUSUNITCCH]                  NVARCHAR (20)    NOT NULL,
    [ST3WAYRECEIPT]                  INT              NOT NULL,
    [STMULTIPLEYEARANNUALBILLING]    INT              NOT NULL,
    [STTRAININGSKU]                  INT              NOT NULL,
    [STFEE]                          INT              NOT NULL,
    [STFEEUSAGE]                     INT              NOT NULL,
    [STNONRECURRING]                 INT              NOT NULL,
    [STINVENTORYBACKLOG]             INT              NOT NULL
);

