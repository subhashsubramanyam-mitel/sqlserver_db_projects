CREATE TABLE [dbo].[ECC_AGENTBYDATE] (
    [ReportRecordId]                     VARCHAR (50)   NOT NULL,
    [Created]                            DATETIME       CONSTRAINT [DF_ECC_AGENTBYDATE_Created] DEFAULT (getdate()) NULL,
    [Date]                               DATETIME       NULL,
    [PCTACDabandonedcallsofACDpresented] FLOAT (53)     NULL,
    [PCTCmltvidletimeformultiplegroups]  FLOAT (53)     NULL,
    [PCTReleasetime]                     FLOAT (53)     NULL,
    [PCTReleasetimeformultiplegroups]    FLOAT (53)     NULL,
    [ACDabandonedcalls]                  FLOAT (53)     NULL,
    [ACDansweredcalls]                   FLOAT (53)     NULL,
    [ACDpresentednotansweredcalls]       FLOAT (53)     NULL,
    [AgentNameDel]                       NVARCHAR (255) NULL,
    [AgentNumberDel]                     FLOAT (53)     NULL,
    [AvgACDemailinteractiontime]         DATETIME       NULL,
    [AvgACDholdtime]                     DATETIME       NULL,
    [AvgACDtalktime]                     DATETIME       NULL,
    [AvgACDWrapuptime]                   DATETIME       NULL,
    [AvgtalktimeofNACDincoming]          DATETIME       NULL,
    [AvgtalktimeofNACDoutgoing]          DATETIME       NULL,
    [Chatcontactsanswered]               FLOAT (53)     NULL,
    [Cmltvlogintime]                     DATETIME       NULL,
    [Cmltvreleasetimeformultiplegroups]  DATETIME       NULL,
    [CmltvtalktimeofNACDoutgoing]        DATETIME       NULL,
    [Emailcontactsanswered]              FLOAT (53)     NULL,
    [NACDincomingcalls]                  FLOAT (53)     NULL,
    [Logintimeformultiplegroups]         DATETIME       NULL,
    [LongestACDtalktime]                 DATETIME       NULL,
    [AgentID]                            FLOAT (53)     NULL,
    [AgentNumber]                        FLOAT (53)     NULL,
    [AgentName]                          NVARCHAR (255) NULL,
    [ACDPresentedCalls]                  FLOAT (53)     NULL,
    [ChatContactsPresented]              FLOAT (53)     NULL,
    [EmailContactsPresented]             FLOAT (53)     NULL,
    [AvgACDChatInteractionTime]          DATETIME       NULL,
    [LongestACDChatInteractionTime]      DATETIME       NULL,
    [LongestACDEmailInteractionTime]     DATETIME       NULL,
    [ChatContactsPresentedNotAnswered]   FLOAT (53)     NULL,
    [CmltvACDEmailInteractionTime]       DATETIME       NULL,
    [OutboundACDAnswered]                FLOAT (53)     NULL,
    [CmltvIdleTimeForMultipleGroups]     DATETIME       NULL,
    [NACDOutgoingCalls]                  FLOAT (53)     NULL,
    [OutboundACDPresented]               FLOAT (53)     CONSTRAINT [DF_ECC_AGENTBYDATE_OutboundACDPresented] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ECC_AGENTBYDATE] PRIMARY KEY CLUSTERED ([ReportRecordId] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[ECC_AGENTBYDATE] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ECC_AGENTBYDATE] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ECC_AGENTBYDATE] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ECC_AGENTBYDATE] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[ECC_AGENTBYDATE] TO [TACECC]
    AS [dbo];

