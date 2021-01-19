CREATE TABLE [enum].[CdrSource] (
    [CdrSsource]  NCHAR (10)    NOT NULL,
    [Description] NVARCHAR (50) NULL,
    CONSTRAINT [PK_CdrSource] PRIMARY KEY CLUSTERED ([CdrSsource] ASC)
);

