CREATE TABLE [dbo].[_tmp_Date] (
    [Date]                  DATETIME      NOT NULL,
    [Date_Name]             NVARCHAR (50) NULL,
    [Year]                  DATETIME      NULL,
    [Year_Name]             NVARCHAR (50) NULL,
    [Quarter]               DATETIME      NULL,
    [Quarter_Name]          NVARCHAR (50) NULL,
    [Month]                 DATETIME      NULL,
    [Month_Name]            NVARCHAR (50) NULL,
    [Week]                  DATETIME      NULL,
    [Week_Name]             NVARCHAR (50) NULL,
    [Day_Of_Year]           INT           NULL,
    [Day_Of_Year_Name]      NVARCHAR (50) NULL,
    [Day_Of_Quarter]        INT           NULL,
    [Day_Of_Quarter_Name]   NVARCHAR (50) NULL,
    [Day_Of_Month]          INT           NULL,
    [Day_Of_Month_Name]     NVARCHAR (50) NULL,
    [Day_Of_Week]           INT           NULL,
    [Day_Of_Week_Name]      NVARCHAR (50) NULL,
    [Week_Of_Year]          INT           NULL,
    [Week_Of_Year_Name]     NVARCHAR (50) NULL,
    [Month_Of_Year]         INT           NULL,
    [Month_Of_Year_Name]    NVARCHAR (50) NULL,
    [Month_Of_Quarter]      INT           NULL,
    [Month_Of_Quarter_Name] NVARCHAR (50) NULL,
    [Quarter_Of_Year]       INT           NULL,
    [Quarter_Of_Year_Name]  NVARCHAR (50) NULL,
    CONSTRAINT [PK_Date] PRIMARY KEY CLUSTERED ([Date] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date';


GO
EXECUTE sp_addextendedproperty @name = N'DSVTable', @value = 'Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date';


GO
EXECUTE sp_addextendedproperty @name = N'Project', @value = 'c6a32874-963a-4ca8-b4f6-e44e05ec1d08', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Date_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Date_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Date_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Year';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Year';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Year_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Quarter', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Quarter_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Month', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Month_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Week', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Week_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Year_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Quarter', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Quarter_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Quarter_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Quarter_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Month';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Month', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Month';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Month_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Month_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Month_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Week';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Week', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Week';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Week_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Day_Of_Week_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Day_Of_Week_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Week_Of_Year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Week_Of_Year_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Week_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Month_Of_Year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Month_Of_Year_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Month_Of_Quarter', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Quarter_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Month_Of_Quarter_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Month_Of_Quarter_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Quarter_Of_Year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter_Of_Year';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'DSVColumn', @value = 'Quarter_Of_Year_Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'COLUMN', @level2name = N'Quarter_Of_Year_Name';


GO
EXECUTE sp_addextendedproperty @name = N'AllowGen', @value = 'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'_tmp_Date', @level2type = N'CONSTRAINT', @level2name = N'PK_Date';

