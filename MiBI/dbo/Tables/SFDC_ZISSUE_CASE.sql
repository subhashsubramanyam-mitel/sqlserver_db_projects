﻿CREATE TABLE [dbo].[SFDC_ZISSUE_CASE] (
    [Created]  DATETIME       CONSTRAINT [DF_SFDC_ZISSUE_CASE_Created] DEFAULT (getdate()) NULL,
    [Id]       VARCHAR (25)   NOT NULL,
    [CaseId]   NVARCHAR (255) NULL,
    [ZIssueId] NVARCHAR (255) NULL,
    CONSTRAINT [PK_SFDC_ZISSUE_CASE] PRIMARY KEY CLUSTERED ([Id] ASC)
);

