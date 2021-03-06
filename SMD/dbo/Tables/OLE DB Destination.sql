﻿CREATE TABLE [dbo].[OLE DB Destination] (
    [/BIC/YSO_TID]   NVARCHAR (20)   NULL,
    [RECORDMODE]     NVARCHAR (1)    NULL,
    [CALYEAR]        NVARCHAR (4)    NULL,
    [CALWEEK]        NVARCHAR (6)    NULL,
    [CALQUARTER]     NVARCHAR (5)    NULL,
    [CALQUART1]      NVARCHAR (1)    NULL,
    [CALMONTH2]      NVARCHAR (2)    NULL,
    [CALMONTH]       NVARCHAR (6)    NULL,
    [REGION]         NVARCHAR (3)    NULL,
    [/BIC/YSO_DISTR] NVARCHAR (10)   NULL,
    [/BIC/YSALESOFF] NVARCHAR (4)    NULL,
    [/BIC/YSORSTATE] NVARCHAR (40)   NULL,
    [/BIC/YSO_RCONT] NVARCHAR (40)   NULL,
    [COUNTRY]        NVARCHAR (3)    NULL,
    [/BIC/YSO_RPST]  NVARCHAR (10)   NULL,
    [/BIC/YSO_FMAT]  NVARCHAR (18)   NULL,
    [/BIC/YSO_FRE]   NVARCHAR (10)   NULL,
    [/BIC/YSO_FEU]   NVARCHAR (10)   NULL,
    [/BIC/YSOCLUP]   NUMERIC (17, 2) NULL,
    [/BIC/YSOORDNO]  NVARCHAR (20)   NULL,
    [/BIC/YSOINVNO]  NVARCHAR (20)   NULL,
    [/BIC/YSOTRADT]  NVARCHAR (8)    NULL,
    [/BIC/YSO_PO]    NVARCHAR (25)   NULL,
    [/BIC/YSORENM]   NVARCHAR (100)  NULL,
    [/BIC/YSORE_PC]  NVARCHAR (12)   NULL,
    [/BIC/YSORCNT]   NVARCHAR (30)   NULL,
    [/BIC/YSORS_ID]  NVARCHAR (10)   NULL,
    [/BIC/YSOE_CID]  NVARCHAR (10)   NULL,
    [/BIC/YSOCUSNM]  NVARCHAR (50)   NULL,
    [/BIC/YSOEADD1]  NVARCHAR (100)  NULL,
    [/BIC/YSOEADD2]  NVARCHAR (100)  NULL,
    [/BIC/YSOEADD3]  NVARCHAR (100)  NULL,
    [/BIC/YEUCUSTC]  NVARCHAR (35)   NULL,
    [/BIC/YSOE_CST]  NVARCHAR (30)   NULL,
    [/BIC/YSOE_ZC]   NVARCHAR (12)   NULL,
    [/BIC/YSOECCNT]  NVARCHAR (30)   NULL,
    [/BIC/YSOECTNM]  NVARCHAR (30)   NULL,
    [/BIC/YSOEPHNO]  NVARCHAR (20)   NULL,
    [/BIC/YSOEMLAD]  NVARCHAR (50)   NULL,
    [/BIC/YSOEPONO]  NVARCHAR (25)   NULL,
    [/BIC/YSOC_TY]   NVARCHAR (50)   NULL,
    [/BIC/YSOCONT]   NVARCHAR (20)   NULL,
    [/BIC/YSOEOPID]  NVARCHAR (40)   NULL,
    [/BIC/YSOSNM]    NVARCHAR (50)   NULL,
    [/BIC/YSOSADD1]  NVARCHAR (100)  NULL,
    [/BIC/YSOSADD2]  NVARCHAR (100)  NULL,
    [/BIC/YSOSADD3]  NVARCHAR (100)  NULL,
    [/BIC/YSOS_CTY]  NVARCHAR (30)   NULL,
    [/BIC/YSOS_STE]  NVARCHAR (30)   NULL,
    [/BIC/YSOSZPCD]  NVARCHAR (12)   NULL,
    [/BIC/YSOS_CNT]  NVARCHAR (30)   NULL,
    [/BIC/YSOMATID]  NVARCHAR (30)   NULL,
    [/BIC/YSOM_DPT]  NVARCHAR (150)  NULL,
    [/BIC/YSO_SR]    NVARCHAR (1)    NULL,
    [/BIC/YSO_OTY]   NVARCHAR (3)    NULL,
    [/BIC/YSOSPAID]  NVARCHAR (18)   NULL,
    [/BIC/YSO_PID]   NVARCHAR (20)   NULL,
    [/BIC/YSORVADI]  NVARCHAR (20)   NULL,
    [/BIC/YSORDNM]   NVARCHAR (70)   NULL,
    [/BIC/YSOVSKU]   NVARCHAR (30)   NULL,
    [/BIC/YSO_FSD]   NVARCHAR (8)    NULL,
    [/BIC/YSO_FED]   NVARCHAR (8)    NULL,
    [/BIC/YSO_FSW]   NVARCHAR (7)    NULL,
    [/BIC/YSO_FSY]   NVARCHAR (4)    NULL,
    [/BIC/YSO_FSM]   NVARCHAR (10)   NULL,
    [/BIC/YSO_FSQ]   NVARCHAR (2)    NULL,
    [/BIC/YSO_NRC]   NVARCHAR (3)    NULL,
    [/BIC/YSONRZIP]  NVARCHAR (10)   NULL,
    [/BIC/YSOEUCTY]  NVARCHAR (40)   NULL,
    [/BIC/YSOEUSTE]  NVARCHAR (40)   NULL,
    [/BIC/YSONEUZP]  NVARCHAR (10)   NULL,
    [/BIC/YSONEUCT]  NVARCHAR (3)    NULL,
    [/BIC/YSOVEUNM]  NVARCHAR (100)  NULL,
    [/BIC/YSOVEAD1]  NVARCHAR (100)  NULL,
    [/BIC/YSOVEAD2]  NVARCHAR (100)  NULL,
    [/BIC/YSOVEUCY]  NVARCHAR (40)   NULL,
    [/BIC/YSOVEUST]  NVARCHAR (40)   NULL,
    [/BIC/YSOVEZIP]  NVARCHAR (10)   NULL,
    [/BIC/YSOVECT]   NVARCHAR (40)   NULL,
    [/BIC/YSOVESPN]  NVARCHAR (10)   NULL,
    [/BIC/YSOVESID]  NVARCHAR (20)   NULL,
    [/BIC/YSOEACCO]  NVARCHAR (60)   NULL,
    [/BIC/YSOEACTH]  NVARCHAR (30)   NULL,
    [/BIC/YSOEACCR]  NVARCHAR (30)   NULL,
    [/BIC/YSOEUSR]   NVARCHAR (30)   NULL,
    [/BIC/YSOEUT]    NVARCHAR (60)   NULL,
    [/BIC/YSOPR]     NVARCHAR (60)   NULL,
    [/BIC/YSOSICD]   NVARCHAR (20)   NULL,
    [/BIC/YSO_SICD]  NVARCHAR (60)   NULL,
    [/BIC/YSOZBLID]  NVARCHAR (10)   NULL,
    [/BIC/YSOZINID]  NVARCHAR (10)   NULL,
    [/BIC/YSOVRES]   NVARCHAR (40)   NULL,
    [/BIC/YSOVRSPN]  NVARCHAR (10)   NULL,
    [/BIC/YSOVRNM]   NVARCHAR (100)  NULL,
    [/BIC/YSOVRAD1]  NVARCHAR (100)  NULL,
    [/BIC/YSOVRAD2]  NVARCHAR (100)  NULL,
    [/BIC/YSOVRPC]   NVARCHAR (10)   NULL,
    [/BIC/YSOVRCTY]  NVARCHAR (40)   NULL,
    [/BIC/YSOVRSTE]  NVARCHAR (40)   NULL,
    [/BIC/YSOVRCNT]  NVARCHAR (40)   NULL,
    [/BIC/YSO_PL]    NVARCHAR (30)   NULL,
    [/BIC/YSOCAM]    NVARCHAR (60)   NULL,
    [/BIC/YSORTH]    NVARCHAR (30)   NULL,
    [/BIC/YSORRG]    NVARCHAR (30)   NULL,
    [/BIC/YSORSRG]   NVARCHAR (30)   NULL,
    [/BIC/YSORTTY]   NVARCHAR (60)   NULL,
    [/BIC/YSO_RTY]   NVARCHAR (30)   NULL,
    [/BIC/YSOZRIID]  NVARCHAR (10)   NULL,
    [/BIC/YSOVEUS]   NVARCHAR (20)   NULL,
    [/BIC/YSORACID]  NVARCHAR (18)   NULL,
    [/BIC/YSODACID]  NVARCHAR (18)   NULL,
    [/BIC/YSO_LDFG]  NVARCHAR (1)    NULL,
    [/BIC/YSOLICNO]  NVARCHAR (18)   NULL,
    [/BIC/YSO_DRID]  NVARCHAR (18)   NULL,
    [/BIC/YSOVRSID]  NVARCHAR (10)   NULL,
    [/BIC/YSODCAM]   NVARCHAR (40)   NULL,
    [/BIC/YSO_CSF]   NVARCHAR (1)    NULL,
    [/BIC/YSO_SLNO]  NVARCHAR (30)   NULL,
    [/BIC/YSO_LUTP]  NUMERIC (17, 2) NULL,
    [/BIC/YSO_SUTP]  NUMERIC (17, 2) NULL,
    [/BIC/YSO_SEXP]  NUMERIC (17, 2) NULL,
    [/BIC/YSO_NBUP]  NUMERIC (17, 2) NULL,
    [/BIC/YSO_NBEP]  NUMERIC (17, 2) NULL,
    [/BIC/YSO_RBEP]  NUMERIC (17, 2) NULL,
    [/BIC/YSO_OCCV]  NUMERIC (17, 2) NULL,
    [/BIC/YSO_TCCV]  NUMERIC (17, 2) NULL,
    [CURRENCY]       NVARCHAR (5)    NULL,
    [/BIC/YSOCSUP]   NUMERIC (17, 2) NULL,
    [/BIC/YSOCSEP]   NUMERIC (17, 2) NULL,
    [/BIC/YSOCNBUP]  NUMERIC (17, 2) NULL,
    [/BIC/YSOCRBUP]  NUMERIC (17, 2) NULL,
    [/BIC/YSOCNBEP]  NUMERIC (17, 2) NULL,
    [/BIC/YSOCOCCV]  NUMERIC (17, 2) NULL,
    [/BIC/YSOCTCCV]  NUMERIC (17, 2) NULL,
    [/BIC/YSOCCRBE]  NUMERIC (17, 2) NULL,
    [/BIC/YSOCRBEP]  NUMERIC (17, 2) NULL,
    [/BIC/YSOCRCURR] NVARCHAR (5)    NULL,
    [/BIC/YSO_QUAN]  NUMERIC (17, 3) NULL
);

