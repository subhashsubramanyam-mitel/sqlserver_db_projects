CREATE TABLE [enum].[CdrServiceType] (
    [ID]            INT          NOT NULL,
    [CallDirection] NVARCHAR (9) NULL,
    [Name]          VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_CdrServiceType] PRIMARY KEY CLUSTERED ([ID] ASC)
);

