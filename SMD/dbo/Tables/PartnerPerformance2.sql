CREATE TABLE [dbo].[PartnerPerformance2] (
    [ST_ID]           VARCHAR (15)    NOT NULL,
    [Name]            VARCHAR (100)   NOT NULL,
    [PY]              DATE            NULL,
    [Rank]            NVARCHAR (50)   NULL,
    [Pts]             NVARCHAR (50)   NULL,
    [MrrPts]          NVARCHAR (50)   NULL,
    [OnsitePts]       NVARCHAR (50)   NULL,
    [Rev]             NUMERIC (38, 2) NULL,
    [MrrRev]          NUMERIC (38, 2) NULL,
    [OnsiteRev]       NUMERIC (38, 2) NULL,
    [Growth]          NVARCHAR (50)   NULL,
    [MrrGrowth]       NVARCHAR (50)   NULL,
    [OnsiteGrowth]    NVARCHAR (50)   NULL,
    [CountryCategory] NVARCHAR (50)   NULL
);

