CREATE TABLE [dbo].[TAC_UTIL_LIC] (
    [DistyRowId]   VARCHAR (15)  NULL,
    [DistyName]    VARCHAR (200) NULL,
    [PartnerRowId] VARCHAR (15)  NOT NULL,
    [ImpactNumber] VARCHAR (15)  NOT NULL,
    [PartnerName]  VARCHAR (200) NOT NULL,
    [CustomerName] VARCHAR (200) NOT NULL,
    [SKU]          VARCHAR (50)  NOT NULL,
    [Description]  VARCHAR (200) NULL,
    [Qty]          INT           NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_UTIL_LIC] TO [TacEngRole]
    AS [dbo];

