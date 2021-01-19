CREATE TABLE [Santana].[mVwSalesReport_SuggestedProfiles] (
    [TN]                        NVARCHAR (4000) NULL,
    [Suggested Connect Profile] NVARCHAR (128)  NULL
);


GO
GRANT SELECT
    ON OBJECT::[Santana].[mVwSalesReport_SuggestedProfiles] TO [SkyImp]
    AS [dbo];

