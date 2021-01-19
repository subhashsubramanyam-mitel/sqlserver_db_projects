CREATE TABLE [dbo].[SFDC_TERRITORY] (
    [Created]       DATETIME       NULL,
    [SfdcId]        VARCHAR (50)   COLLATE Latin1_General_BIN NOT NULL,
    [AXCode]        NVARCHAR (261) COLLATE Latin1_General_BIN NULL,
    [Region]        NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [TerritoryName] NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [Subregion]     NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [Theatre]       NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [CSM]           NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [ASM]           NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [SE]            NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [RVP]           NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [RD]            NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [ASR]           NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [DualCSEPBM]    NVARCHAR (50)  COLLATE Latin1_General_BIN NULL,
    [CloudCSR]      NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [GOV]           NVARCHAR (255) COLLATE Latin1_General_BIN NULL
);

