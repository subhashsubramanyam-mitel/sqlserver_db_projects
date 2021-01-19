CREATE TABLE [dbo].[TzZoneRule] (
    [Id]                INT            NOT NULL,
    [ZoneId]            INT            NOT NULL,
    [ZoneName]          NVARCHAR (100) NOT NULL,
    [GmtOffset]         TIME (7)       NOT NULL,
    [GmtOffsetNegative] BIT            NOT NULL,
    [RuleName]          NVARCHAR (100) NOT NULL,
    [Format]            NVARCHAR (100) NOT NULL,
    [Until]             DATETIME       NOT NULL
);

