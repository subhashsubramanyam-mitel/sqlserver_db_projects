CREATE TABLE [dbo].[COVID_CasesByCounty] (
    [date]   DATETIME      NULL,
    [county] NVARCHAR (50) NULL,
    [state]  NVARCHAR (50) NULL,
    [fips]   NVARCHAR (50) NULL,
    [cases]  REAL          NULL,
    [deaths] REAL          NULL
);

