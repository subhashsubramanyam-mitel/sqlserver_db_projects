CREATE TABLE [dbo].[CUSTOMER_ASSETS_SFDC] (
    [SfdcId]              VARCHAR (50)    NOT NULL,
    [ImpactNumber]        VARCHAR (15)    NULL,
    [CustomerName]        VARCHAR (200)   NULL,
    [PartnerSTID]         VARCHAR (50)    NULL,
    [CustomerSupportType] VARCHAR (50)    NULL,
    [SKU]                 VARCHAR (50)    NULL,
    [Status]              VARCHAR (50)    NULL,
    [ShipDate]            DATETIME        NULL,
    [ShipQty]             INT             NULL,
    [UserLic]             INT             NULL,
    [LicQty]              INT             NULL,
    [SerialNumber]        VARCHAR (100)   NULL,
    [ListPrice]           DECIMAL (18, 2) NULL,
    [PONum]               VARCHAR (50)    NULL,
    CONSTRAINT [PK_CUSTOMER_ASSETS_SFDC] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);

