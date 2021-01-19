CREATE TABLE [dbo].[DEFECT_HEADER] (
    [DEFECT_NUM]       VARCHAR (64)  NOT NULL,
    [ROW_ID]           VARCHAR (30)  NOT NULL,
    [DeveloperId]      VARCHAR (100) NULL,
    [FI]               VARCHAR (100) NULL,
    [Priority]         VARCHAR (100) NULL,
    [ABSTRACT]         VARCHAR (MAX) NULL,
    [Area]             VARCHAR (100) NULL,
    [Version]          VARCHAR (100) NULL,
    [Ext_Desc]         TEXT          NULL,
    [Keywords]         VARCHAR (MAX) NULL,
    [Close_Date]       DATETIME      NULL,
    [Date_Open]        DATETIME      NOT NULL,
    [Created_By]       VARCHAR (100) NULL,
    [Type]             VARCHAR (100) NULL,
    [QA_OwnerId]       VARCHAR (100) NULL,
    [FoundIn]          VARCHAR (100) NULL,
    [TEST_CASES]       VARCHAR (MAX) NULL,
    [Res_Description]  TEXT          NULL,
    [Found_Via]        VARCHAR (100) NULL,
    [Sub_Area]         VARCHAR (100) NULL,
    [Notify_1Id]       VARCHAR (100) NULL,
    [Notify_2Id]       VARCHAR (100) NULL,
    [Severity]         VARCHAR (100) NULL,
    [Critical_Account] VARCHAR (10)  NULL,
    [DeveloperGroup]   VARCHAR (100) NULL,
    [WO]               VARCHAR (100) NULL,
    [Reason]           VARCHAR (100) NULL,
    [Automation]       VARCHAR (100) NULL,
    [CreatedBy]        VARCHAR (100) NULL,
    [CreatedDate]      DATETIME      NULL,
    [LastModifiedBy]   VARCHAR (100) NULL,
    [LastModifiedDate] DATETIME      NULL,
    [Developer]        VARCHAR (100) NULL,
    [QA_Owner]         VARCHAR (100) NULL,
    [Notify_1]         VARCHAR (100) NULL,
    [Notify_2]         VARCHAR (100) NULL,
    [Status]           VARCHAR (50)  NULL,
    [SubStatus]        VARCHAR (50)  NULL,
    CONSTRAINT [PK_DEFECT_HEADER2] PRIMARY KEY CLUSTERED ([DEFECT_NUM] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DEFECT_HEADER] TO [TacEngRole]
    AS [dbo];

