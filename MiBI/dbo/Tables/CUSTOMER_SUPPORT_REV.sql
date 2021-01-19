CREATE TABLE [dbo].[CUSTOMER_SUPPORT_REV] (
    [InvoiceDate] DATETIME        NULL,
    [CustomerId]  VARCHAR (50)    NULL,
    [PartnerId]   VARCHAR (50)    NULL,
    [Sku]         VARCHAR (50)    NULL,
    [SkuDesc]     VARCHAR (300)   NULL,
    [NetUSD]      DECIMAL (18, 2) NULL,
    [PoNumber]    VARCHAR (100)   NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_SUPPORT_REV] TO [TacEngRole]
    AS [dbo];

