CREATE TABLE [dbo].[TimeLookup] (
    [TimeID]        INT          NOT NULL,
    [theDate]       DATETIME     NULL,
    [theDay]        VARCHAR (10) NULL,
    [theMonth]      VARCHAR (10) NULL,
    [theYear]       SMALLINT     NULL,
    [DayOfMonth]    SMALLINT     NULL,
    [WeekOfYear]    SMALLINT     NULL,
    [MonthOfYear]   SMALLINT     NULL,
    [QuarterOfYear] VARCHAR (2)  NULL,
    [FQuarter]      VARCHAR (10) NULL,
    CONSTRAINT [PK_TimeLookup] PRIMARY KEY CLUSTERED ([TimeID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[TimeLookup] TO [TacEngRole]
    AS [dbo];

