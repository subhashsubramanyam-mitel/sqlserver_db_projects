CREATE TABLE [Santana].[mVwSalesReport_SuggestedHW] (
    [tn]                         VARCHAR (32)   NOT NULL,
    [Suggested Connect Hardware] NVARCHAR (128) NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[Santana].[mVwSalesReport_SuggestedHW] TO [SkyImp]
    AS [dbo];

