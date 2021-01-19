CREATE TABLE [dbo].[SFDC_SKY_XSELL_TRK] (
    [Created]              DATETIME     CONSTRAINT [DF_SFDC_SKY_XSELL_TRK_Created] DEFAULT (getdate()) NULL,
    [CrossSellId]          VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [OrderDate]            DATETIME     NULL,
    [OrderId]              INT          NOT NULL,
    [AccountId]            INT          NOT NULL,
    [PartnerOfRecordCloud] VARCHAR (25) COLLATE Latin1_General_BIN NULL,
    [CrossSellBookings]    MONEY        NULL,
    [OppId]                VARCHAR (50) NULL,
    [Status]               VARCHAR (5)  CONSTRAINT [DF_SFDC_SKY_XSELL_TRK_Status] DEFAULT ('N') NULL,
    [Error]                TEXT         NULL,
    CONSTRAINT [PK_SFDC_SKY_XSELL_TRK] PRIMARY KEY CLUSTERED ([CrossSellId] ASC)
);

