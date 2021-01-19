CREATE TABLE [dbo].[CUSTOMER_ASSETS] (
    [SfdcId]                VARCHAR (50)    NOT NULL,
    [ImpactNumber]          VARCHAR (50)    NULL,
    [CustomerName]          VARCHAR (200)   NULL,
    [PartnerName]           VARCHAR (200)   NULL,
    [PartnerSTID]           VARCHAR (50)    NULL,
    [CustomerSupportType]   VARCHAR (100)   NULL,
    [SKU]                   VARCHAR (200)   NULL,
    [Description]           VARCHAR (MAX)   NULL,
    [Status]                VARCHAR (50)    NULL,
    [ShipDate]              DATETIME        NULL,
    [ShipQty]               DECIMAL (18)    CONSTRAINT [DF_CUSTOMER_ASSETS_ShipQty] DEFAULT ((0)) NULL,
    [UserLic]               DECIMAL (18)    CONSTRAINT [DF_CUSTOMER_ASSETS_UserLic] DEFAULT ((0)) NULL,
    [LicQty]                DECIMAL (18)    CONSTRAINT [DF_CUSTOMER_ASSETS_LicQty] DEFAULT ((0)) NULL,
    [SerialNumber]          VARCHAR (100)   NULL,
    [ListPrice]             DECIMAL (18, 2) CONSTRAINT [DF_CUSTOMER_ASSETS_ListPrice] DEFAULT ((0)) NULL,
    [ProductLine]           VARCHAR (200)   NULL,
    [PONum]                 VARCHAR (200)   NULL,
    [CreatedDate]           DATETIME        CONSTRAINT [DF_CUSTOMER_ASSETS2_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [SfdcCreateDateUTC]     DATETIME        NULL,
    [SfdcLastUpdateDateUTC] DATETIME        NULL,
    [Name]                  VARCHAR (MAX)   NULL,
    [ItemSubType]           VARCHAR (100)   NULL,
    [CustomerId]            VARCHAR (50)    NULL,
    [BossServiceId]         VARCHAR (25)    NULL,
    [MRR]                   FLOAT (53)      CONSTRAINT [DF_CUSTOMER_ASSETS_MRR] DEFAULT ((0)) NULL,
    [NRR]                   FLOAT (53)      NULL,
    [DateLive]              DATETIME        NULL,
    [DateActivated]         DATETIME        NULL,
    [BillingStartDate]      DATETIME        NULL,
    [BillingCeaseDate]      DATETIME        NULL,
    [DateClosed]            DATETIME        NULL,
    [DateModified]          DATETIME        NULL,
    CONSTRAINT [PK_CUSTOMER_ASSETS2_1] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CUSTOMER_ASSETS]
    ON [dbo].[CUSTOMER_ASSETS]([ImpactNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CUSTOMER_ASSETS_1]
    ON [dbo].[CUSTOMER_ASSETS]([SKU] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\BPaddock]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\AMohandas]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\medwards]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\brobison]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\alossing]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [Reporting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\MBrondum]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\dorr]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_ASSETS] TO [CANDY\beswanson]
    AS [dbo];

