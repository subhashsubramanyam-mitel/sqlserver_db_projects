CREATE TABLE [dbo].[ECC_RELEASECODE] (
    [Created]                    DATETIME      CONSTRAINT [DF_ECC_RELEASECODE_Created] DEFAULT (getdate()) NULL,
    [ReportDate]                 DATETIME      NULL,
    [ReportRecordId]             VARCHAR (50)  NOT NULL,
    [ReleaseCode]                VARCHAR (50)  NULL,
    [GroupIndependentRT]         DATETIME      NULL,
    [TimesCodeWasUsed]           FLOAT (53)    NOT NULL,
    [ShortestGroupIndependantRT] DATETIME      NULL,
    [AgentId]                    FLOAT (53)    NULL,
    [AgentName]                  VARCHAR (100) NULL,
    CONSTRAINT [PK_ECC_RELEASECODE] PRIMARY KEY CLUSTERED ([ReportRecordId] ASC)
);

