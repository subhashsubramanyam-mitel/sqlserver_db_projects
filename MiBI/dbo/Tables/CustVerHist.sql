CREATE TABLE [dbo].[CustVerHist] (
    [Id]            INT          IDENTITY (1, 1) NOT NULL,
    [Created]       DATETIME     CONSTRAINT [DF_CustVerHist_Created] DEFAULT (getdate()) NULL,
    [Sdate]         DATETIME     NULL,
    [theDay]        VARCHAR (10) NULL,
    [theMonth]      VARCHAR (10) NULL,
    [theYear]       SMALLINT     NULL,
    [DayOfMonth]    SMALLINT     NULL,
    [WeekOfYear]    SMALLINT     NULL,
    [MonthOfYear]   SMALLINT     NULL,
    [QuarterOfYear] VARCHAR (2)  NULL,
    [FQuarter]      VARCHAR (15) NULL,
    [ST_ID]         VARCHAR (50) NULL,
    [InstallDate]   DATETIME     NULL,
    [Version]       VARCHAR (50) NULL,
    CONSTRAINT [PK_CustVerHist] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CustVerHist] TO [TacEngRole]
    AS [dbo];

