CREATE TABLE [Tableau].[CustomerSegments] (
    [AccountId]                    INT         NOT NULL,
    [NumProfiles]                  INT         NULL,
    [CustomerSegmentByProfileSize] VARCHAR (7) NULL,
    CONSTRAINT [PK_CustomerSegments] PRIMARY KEY CLUSTERED ([AccountId] ASC)
);

