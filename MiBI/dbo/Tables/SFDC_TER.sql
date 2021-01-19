CREATE TABLE [dbo].[SFDC_TER] (
    [SfdcId]               NVARCHAR (255) NULL,
    [ST_Territory_Code__c] NVARCHAR (255) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SFDC_TER] TO [SalesOps]
    AS [dbo];

