CREATE TABLE [dbo].[DEFECT_DETAIL] (
    [SfdcId]             VARCHAR (30)  NOT NULL,
    [DEFECT_NUM]         VARCHAR (64)  NOT NULL,
    [Status]             VARCHAR (30)  NULL,
    [Sub_Status]         VARCHAR (30)  NULL,
    [X_QAA_QAC_DATE]     DATETIME      NULL,
    [Due_Date]           DATETIME      NULL,
    [Risk]               VARCHAR (30)  NULL,
    [Correct_In]         VARCHAR (50)  NULL,
    [Change_List]        VARCHAR (200) NULL,
    [Resolved_Date]      DATETIME      NULL,
    [MRT_LAST_UPDATE]    DATETIME      NULL,
    [TargetRel]          VARCHAR (100) NULL,
    [Test_Engineer]      VARCHAR (50)  NULL,
    [Reviewed_by]        VARCHAR (50)  NULL,
    [Verified_Date]      DATETIME      NULL,
    [RejectDate]         DATETIME      NULL,
    [Verified_In]        VARCHAR (50)  NULL,
    [Effort]             VARCHAR (50)  NULL,
    [X_DELIVERY_VEHICLE] VARCHAR (50)  NULL,
    [X_KNOWLEDGE_BASE]   VARCHAR (50)  NULL,
    [X_REVIEW_DATE]      DATETIME      NULL,
    [CreatedBy]          VARCHAR (50)  NULL,
    [CreatedDate]        DATETIME      NULL,
    [LastModifiedBy]     VARCHAR (50)  NULL,
    [LastModifiedDate]   DATETIME      NULL,
    CONSTRAINT [PK_DEFECT_DETAIL2] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DEFECT_DETAIL] TO [TacEngRole]
    AS [dbo];

