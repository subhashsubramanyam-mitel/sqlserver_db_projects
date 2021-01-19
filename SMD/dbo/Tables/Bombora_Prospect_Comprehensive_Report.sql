CREATE TABLE [dbo].[Bombora_Prospect_Comprehensive_Report] (
    [Company Name]                NVARCHAR (255) NULL,
    [Domain]                      NVARCHAR (255) NULL,
    [Company Size]                NVARCHAR (255) NULL,
    [Industry]                    NVARCHAR (255) NULL,
    [Topic ID]                    FLOAT (53)     NULL,
    [Topic Name]                  NVARCHAR (255) NULL,
    [Composite Score]             FLOAT (53)     NULL,
    [Composite Score Delta]       FLOAT (53)     NULL,
    [Metro Area]                  NVARCHAR (255) NULL,
    [Metro Composite Score]       FLOAT (53)     NULL,
    [Metro Compisite Score Delta] NVARCHAR (255) NULL,
    [Country]                     NVARCHAR (255) NULL,
    [Zip Code]                    FLOAT (53)     NULL,
    [Date]                        DATE           CONSTRAINT [DF_Bombora_Prospect_Comprehensive_Report_Date] DEFAULT (getdate()) NULL
);

