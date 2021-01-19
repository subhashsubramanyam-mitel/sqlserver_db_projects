CREATE TABLE [dbo].[Coaching] (
    [Created]                           DATETIME      CONSTRAINT [DF_Coaching_Created] DEFAULT (getdate()) NULL,
    [Id]                                VARCHAR (18)  NOT NULL,
    [Name]                              VARCHAR (50)  NULL,
    [Team__c]                           VARCHAR (100) NULL,
    [Case_Number__c]                    VARCHAR (50)  NULL,
    [Evaluated_By__c]                   VARCHAR (250) NULL,
    [Evaluation_Date__c]                DATETIME      NULL,
    [Total_Communication_Score__c]      INT           NULL,
    [Total_Communication_Score2__c]     INT           NULL,
    [Total_Process_Score__c]            INT           NULL,
    [Total_Process_Score2__c]           INT           NULL,
    [Total_Product_Technical_Score__c]  INT           NULL,
    [Total_Product_Technical_Score2__c] INT           NULL,
    [Total_Product_Score__c]            INT           NULL,
    [Overall_QA_Score__c]               INT           NULL,
    [Overall_QA_Score2__c]              INT           NULL,
    [Customer_Experience_Score__c]      INT           NULL,
    [Customer_Experience_Score1__c]     INT           NULL,
    [Areas_for_Improvement__c]          TEXT          NULL,
    [Areas_of_Improvement__c]           VARCHAR (100) NULL,
    [General_Scoring_Comments__c]       TEXT          NULL,
    [FinalScore]                        INT           NULL,
    [Areas_of_Excellence__c]            VARCHAR (250) NULL,
    [FinalScoreT1T2]                    INT           NULL,
    [CaseOwner]                         VARCHAR (255) NULL,
    CONSTRAINT [PK_Coaching] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Coaching]
    ON [dbo].[Coaching]([Case_Number__c] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Coaching] TO [TACECC]
    AS [dbo];

