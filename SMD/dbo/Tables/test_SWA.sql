﻿CREATE TABLE [dbo].[test_SWA] (
    [SNAPSHOT_DATE]     NVARCHAR (8)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CURRENTYEARMONTH]  NVARCHAR (6)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PRODUCT_FAMILY]    NVARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ACTIVE_USERS]      INT            NULL,
    [EXPIRED_USERS]     INT            NULL,
    [EXPIREDYEARMONTH]  NVARCHAR (6)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [MAX_DATE]          NVARCHAR (8)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CARRIERS_SWA_EMON] NVARCHAR (6)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);

