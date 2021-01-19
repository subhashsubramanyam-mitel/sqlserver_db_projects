CREATE TABLE [dbo].[MITEL_PRODUCT_MAP] (
    [StockCode]          NVARCHAR (255) NULL,
    [PartDescription]    NVARCHAR (255) NULL,
    [MitelSubFamilyA]    NVARCHAR (255) NULL,
    [MitelSubFamilyB]    NVARCHAR (255) NULL,
    [MitelHierarchyName] NVARCHAR (255) NULL,
    [STDBfamily]         NVARCHAR (255) NULL,
    [STGMFamily]         NVARCHAR (255) NULL,
    [STReportFamily]     NVARCHAR (255) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[MITEL_PRODUCT_MAP] TO [POS]
    AS [dbo];

