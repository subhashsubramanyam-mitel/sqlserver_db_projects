CREATE TABLE [dbo].[SFDC_TERRITORY] (
    [Created]       DATETIME       CONSTRAINT [DF_SFDC_TERRITORY_Created] DEFAULT (getdate()) NULL,
    [SfdcId]        VARCHAR (50)   NOT NULL,
    [AXCode]        NVARCHAR (255) NOT NULL,
    [Region]        NVARCHAR (255) NULL,
    [TerritoryName] NVARCHAR (255) NULL,
    [Subregion]     NVARCHAR (255) NULL,
    [Theatre]       NVARCHAR (255) NULL,
    [CSM]           NVARCHAR (255) NULL,
    [ASM]           NVARCHAR (255) NULL,
    [SE]            NVARCHAR (255) NULL,
    [RVP]           NVARCHAR (255) NULL,
    [RD]            NVARCHAR (255) NULL,
    [ASR]           NVARCHAR (255) NULL,
    [DualCSEPBM]    NVARCHAR (50)  NULL,
    [CloudCSR]      NVARCHAR (255) NULL,
    [GOV]           NVARCHAR (255) NULL,
    [ISE]           NVARCHAR (255) NULL,
    [ISRRegion]     VARCHAR (255)  NULL,
    CONSTRAINT [PK_SFDC_TERRITORY] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);

