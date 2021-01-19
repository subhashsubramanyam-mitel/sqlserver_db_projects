﻿CREATE TABLE [dbo].[INVENTTABLE] (
    [ITEMGROUPID]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMID]                         NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMNAME]                       NVARCHAR (100)   COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMTYPE]                       INT              NOT NULL,
    [PURCHMODEL]                     INT              NOT NULL,
    [HEIGHT]                         NUMERIC (28, 12) NOT NULL,
    [WIDTH]                          NUMERIC (28, 12) NOT NULL,
    [SALESMODEL]                     INT              NOT NULL,
    [COSTGROUPID]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [REQGROUPID]                     NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [EPCMANAGER]                     NUMERIC (28, 12) NOT NULL,
    [PRIMARYVENDORID]                NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [NETWEIGHT]                      NUMERIC (28, 12) NOT NULL,
    [DEPTH]                          NUMERIC (28, 12) NOT NULL,
    [UNITVOLUME]                     NUMERIC (28, 12) NOT NULL,
    [BOMUNITID]                      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMPRICETOLERANCEGROUPID]      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DENSITY]                        NUMERIC (28, 12) NOT NULL,
    [DIMENSION]                      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION2_]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSION3_]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [COSTMODEL]                      INT              NOT NULL,
    [USEALTITEMID]                   INT              NOT NULL,
    [ALTITEMID]                      NVARCHAR (40)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PRODFLUSHINGPRINCIP]            INT              NOT NULL,
    [PBAITEMAUTOGENERATED]           INT              NOT NULL,
    [WMSARRIVALHANDLINGTIME]         INT              NOT NULL,
    [BOMMANUALRECEIPT]               INT              NOT NULL,
    [STOPEXPLODE]                    INT              NOT NULL,
    [PHANTOM]                        INT              NOT NULL,
    [BOMLEVEL]                       INT              NOT NULL,
    [BATCHNUMGROUPID]                NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [AUTOREPORTFINISHED]             INT              NOT NULL,
    [ALTCONFIGID]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [STANDARDCONFIGID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PRODPOOLID]                     NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ABCTIEUP]                       INT              NOT NULL,
    [ABCREVENUE]                     INT              NOT NULL,
    [ABCVALUE]                       INT              NOT NULL,
    [ABCCONTRIBUTIONMARGIN]          INT              NOT NULL,
    [CONFIGURABLE]                   INT              NOT NULL,
    [SALESPERCENTMARKUP]             NUMERIC (28, 12) NOT NULL,
    [SALESCONTRIBUTIONRATIO]         NUMERIC (28, 12) NOT NULL,
    [SALESPRICEMODELBASIC]           INT              NOT NULL,
    [NAMEALIAS]                      NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PRODGROUPID]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [PROJCATEGORYID]                 NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [GROSSDEPTH]                     NUMERIC (28, 12) NOT NULL,
    [GROSSWIDTH]                     NUMERIC (28, 12) NOT NULL,
    [GROSSHEIGHT]                    NUMERIC (28, 12) NOT NULL,
    [SORTCODE]                       INT              NOT NULL,
    [CONFIGSIMILAR]                  INT              NOT NULL,
    [SERIALNUMGROUPID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMGROUPID]                     NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [MODELGROUPID]                   NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMBUYERGROUPID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [TAXPACKAGINGQTY]                NUMERIC (28, 12) NOT NULL,
    [TARAWEIGHT]                     NUMERIC (28, 12) NOT NULL,
    [PACKAGINGGROUPID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SCRAPVAR]                       NUMERIC (28, 12) NOT NULL,
    [SCRAPCONST]                     NUMERIC (28, 12) NOT NULL,
    [STANDARDINVENTCOLORID]          NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [STANDARDINVENTSIZEID]           NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ITEMDIMCOMBINATIONAUTOCREATE]   INT              NOT NULL,
    [ITEMDIMCOSTPRICE]               INT              NOT NULL,
    [ALTINVENTSIZEID]                NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [ALTINVENTCOLORID]               NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [BOMCALCGROUPID]                 NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMUSEROUTINGYIELD]             INT              NOT NULL,
    [SEMBOMOBSOLETE]                 INT              NOT NULL,
    [SEMBOMDESIGNATION]              INT              NOT NULL,
    [SEMFUSE]                        NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPUBLISH]                     INT              NOT NULL,
    [SEMMFGCOMMENTS]                 NTEXT            COLLATE Latin1_General_CI_AS_KS NULL,
    [SEMLASTORDERDATE]               DATETIME         NOT NULL,
    [SEMLASTSHIPDATE]                DATETIME         NOT NULL,
    [SEMPRODUCTLINE]                 NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMUSEBOMQTY]                   INT              NOT NULL,
    [SEMCOMPONENTISSUEQTY]           NUMERIC (28, 12) NOT NULL,
    [SEMINVENTDIMID]                 NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMAVLON]                       INT              NOT NULL,
    [SEMAVLSELECTION]                INT              NOT NULL,
    [SEMITEMPACKAGEID]               NVARCHAR (25)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMITEMFAMILYID]                NVARCHAR (25)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMTIMEDRIVENITEM]              INT              NOT NULL,
    [SEMBOMMANUALCONSUMP]            INT              NOT NULL,
    [SEMPRIMARYPARTFLAG]             INT              NOT NULL,
    [SEMDIEATTACH]                   INT              NOT NULL,
    [SEMCAPEX]                       INT              NOT NULL,
    [SEMBUSINESSUNIT]                NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMBUSINESSGROUP]               NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMLIFECYCLESTAGE]              INT              NOT NULL,
    [SEMVERSIONID]                   INT              NOT NULL,
    [SEMSAMPLESIZE]                  INT              NOT NULL,
    [SEMEXPENSE]                     INT              NOT NULL,
    [DATAAREAID]                     NVARCHAR (4)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RECVERSION]                     INT              NOT NULL,
    [RECID]                          BIGINT           NOT NULL,
    [INTRACODE]                      NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [INTRAUNIT]                      NUMERIC (28, 12) NOT NULL,
    [ORIGCOUNTRYREGIONID]            NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [STATISTICSFACTOR]               NUMERIC (28, 12) NOT NULL,
    [ORIGSTATEID]                    NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMPERCENTOFLIST]               NUMERIC (28, 12) NOT NULL,
    [SEMVSOEESTABLISHED]             INT              NOT NULL,
    [SEMCALCMEDIANPRICE]             INT              NOT NULL,
    [SEMVSOEGP]                      NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMREVENUETYPE]                 INT              NOT NULL,
    [SEMDEFAULTREVENUERECOGNIT40006] NVARCHAR (10)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMOVERWRITECALCMEDIAN]         INT              NOT NULL,
    [SEMDEMOKIT]                     INT              NOT NULL,
    [SEMSBE]                         INT              NOT NULL,
    [INVENTTAXABLE]                  INT              NOT NULL,
    [MODIFIEDDATETIME]               DATETIME         NOT NULL,
    [MODIFIEDBY]                     NVARCHAR (5)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CREATEDDATETIME]                DATETIME         NOT NULL,
    [CREATEDBY]                      NVARCHAR (5)     COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DMMCONCESSIONDISC]              INT              NOT NULL,
    [DMMECC]                         INT              NOT NULL,
    [STM5ITEMID]                     NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [STCLOUDITEMCLASSID]             NVARCHAR (30)    COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [SEMBUSUNITCCH]                  NVARCHAR (20)    COLLATE Latin1_General_CI_AS_KS NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[INVENTTABLE] TO [CANDY\etlprod]
    AS [dbo];

