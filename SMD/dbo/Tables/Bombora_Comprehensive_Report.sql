CREATE TABLE [dbo].[Bombora_Comprehensive_Report] (
    [Company Name]             NVARCHAR (255) NULL,
    [Domain]                   NVARCHAR (255) NULL,
    [Company Size]             NVARCHAR (255) NULL,
    [Industry]                 NVARCHAR (255) NULL,
    [Topic ID]                 FLOAT (53)     NULL,
    [Topic Name]               NVARCHAR (255) NULL,
    [Composite Score]          FLOAT (53)     NULL,
    [Shoretel ID]              FLOAT (53)     NULL,
    [Date]                     DATE           CONSTRAINT [DF_Bombora_Comprehensive_Report_Date] DEFAULT (getdate()) NULL,
    [Topic_Competitor_name]    VARCHAR (255)  NULL,
    [Composite Score Delta]    DECIMAL (18)   NULL,
    [Metro Area]               NVARCHAR (255) NULL,
    [MetroCompositeScore]      FLOAT (53)     NULL,
    [MetroCompositeScoreDelta] DECIMAL (18)   NULL
);

