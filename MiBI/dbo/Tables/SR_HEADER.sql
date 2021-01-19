CREATE TABLE [dbo].[SR_HEADER] (
    [SR_NUM]              VARCHAR (64)   NOT NULL,
    [SR_TITLE]            VARCHAR (100)  NULL,
    [Parter_Csn]          VARCHAR (15)   NULL,
    [Partner]             VARCHAR (200)  NULL,
    [End_User_Csn]        VARCHAR (15)   NULL,
    [End_User]            VARCHAR (200)  NULL,
    [Support_Program]     VARCHAR (30)   NULL,
    [SR_DESC]             VARCHAR (2000) NULL,
    [SR_AREA]             VARCHAR (30)   NULL,
    [SR_SUB_AREA]         VARCHAR (30)   NULL,
    [Res_Stat]            VARCHAR (30)   NULL,
    [LOGIN]               VARCHAR (50)   NULL,
    [Date_Open]           DATETIME       NOT NULL,
    [ACT_CLOSE_DT]        DATETIME       NULL,
    [Commit_Time]         DATETIME       NULL,
    [SR_Version]          VARCHAR (30)   NULL,
    [Product]             VARCHAR (100)  NULL,
    [Phase]               VARCHAR (30)   NULL,
    [Source]              VARCHAR (30)   NULL,
    [Feature]             VARCHAR (30)   NULL,
    [Severity]            VARCHAR (30)   NULL,
    [Priority]            VARCHAR (30)   NULL,
    [Status]              VARCHAR (30)   NULL,
    [Sub_Status]          VARCHAR (30)   NULL,
    [FST_NAME]            VARCHAR (50)   NULL,
    [LAST_NAME]           VARCHAR (50)   NULL,
    [EMAIL_ADDR]          VARCHAR (100)  NULL,
    [Queue_Call]          CHAR (1)       NULL,
    [Searched_KB]         VARCHAR (50)   NULL,
    [LAST_UPD]            DATETIME       NOT NULL,
    [Res_By_KB]           VARCHAR (30)   NULL,
    [Support_Prog_for_SR] VARCHAR (50)   NULL,
    [SubFeatComp]         VARCHAR (50)   NULL,
    [SRVAR]               VARCHAR (15)   NULL,
    [SRVARNAME]           VARCHAR (200)  NULL,
    [SRVAD]               VARCHAR (15)   NULL,
    [SRVADNAME]           VARCHAR (200)  NULL,
    [SR_ROW_ID]           VARCHAR (15)   NULL,
    [Deflectable]         VARCHAR (1)    NULL,
    [ContactId]           VARCHAR (15)   NULL,
    [RmaId]               VARCHAR (50)   NULL,
    [Tier]                VARCHAR (50)   NULL,
    [AdvQCall]            CHAR (1)       CONSTRAINT [DF_SR_HEADER_AdvQCall] DEFAULT ('N') NULL,
    [Origin]              VARCHAR (50)   NULL,
    [Trunk_Provider__c]   VARCHAR (50)   NULL,
    [CreatedBy]           VARCHAR (50)   NULL,
    [LastModifiedBy]      VARCHAR (50)   NULL,
    [SROwner]             VARCHAR (50)   NULL,
    [WebResolution]       VARCHAR (50)   NULL,
    CONSTRAINT [PK_SR_HEADER] PRIMARY KEY CLUSTERED ([SR_NUM] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_SR_HEADER]
    ON [dbo].[SR_HEADER]([LOGIN] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_HEADER] TO [TacEngRole]
    AS [dbo];

