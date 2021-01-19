CREATE TABLE [dbo].[TimeLookup] (
    [TimeID]        INT          NOT NULL,
    [theDate]       DATETIME     NULL,
    [theDay]        VARCHAR (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [theMonth]      VARCHAR (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [theYear]       SMALLINT     NULL,
    [DayOfMonth]    SMALLINT     NULL,
    [WeekOfYear]    SMALLINT     NULL,
    [MonthOfYear]   SMALLINT     NULL,
    [QuarterOfYear] VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FQuarter]      VARCHAR (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FYear]         SMALLINT     NULL,
    [CWeek]         VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CMonth]        VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_TimeLookup] PRIMARY KEY CLUSTERED ([TimeID] ASC)
);

