CREATE TABLE [dbo].[SFDC_TASKFEED_TIME] (
    [Created]                         DATETIME      CONSTRAINT [DF_SFDC_TASKFEED_TIME_Created] DEFAULT (getdate()) NULL,
    [Id]                              VARCHAR (25)  NOT NULL,
    [taskfeed1__Task__c]              VARCHAR (25)  NULL,
    [taskfeed1__DateTime_Recorded__c] DATETIME      NULL,
    [taskfeed1__Description__c]       VARCHAR (MAX) NULL,
    CONSTRAINT [PK_SFDC_TASKFEED_TIME] PRIMARY KEY CLUSTERED ([Id] ASC)
);

