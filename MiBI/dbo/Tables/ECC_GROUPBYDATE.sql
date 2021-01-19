CREATE TABLE [dbo].[ECC_GROUPBYDATE] (
    [Created]                                       DATETIME       CONSTRAINT [DF_ECC_GROUPBYDATE_Created] DEFAULT (getdate()) NULL,
    [ReportRecordId]                                VARCHAR (50)   NOT NULL,
    [ReportDate]                                    DATETIME       NULL,
    [ACDCallsAccepted]                              FLOAT (53)     NULL,
    [ACDCallsAnswered]                              FLOAT (53)     NULL,
    [ChatContactsAccepted]                          FLOAT (53)     NULL,
    [ChatContactsAnswered]                          FLOAT (53)     NULL,
    [EmailContactsAccepted]                         FLOAT (53)     NULL,
    [EmailContactsAnswered]                         FLOAT (53)     NULL,
    [AvgWaitTimeBeforeAnswered]                     DATETIME       NULL,
    [AvgWaitTimeInQueueOfCallsRequestedCallback]    DATETIME       NULL,
    [LongestWaitTimeBeforeAnswered]                 DATETIME       NULL,
    [LongestWaitTimeInQueueOfCallRequestedCallback] DATETIME       NULL,
    [AvgWaitTimeBeforeAnsweredOfChatContacts]       DATETIME       NULL,
    [CmltvWaitTimeBeforeAnsweredOfChatContacts]     DATETIME       NULL,
    [OutboundACDCallsAsAConsequenceOfCallback]      FLOAT (53)     NULL,
    [GroupID]                                       FLOAT (53)     NULL,
    [GroupName]                                     NVARCHAR (255) NULL,
    [TSFForIncomingACDCalls]                        FLOAT (53)     NULL,
    [LongestWaitTimeBeforeAnsweredChatContacts]     DATETIME       NULL,
    [PCTACDCallsAbandonedOfAcceptedCalls]           FLOAT (53)     NULL,
    [AvgTalkTimeACDCalls]                           DATETIME       NULL,
    [AvgNumberLoggedinAgents]                       FLOAT (53)     NULL,
    [MaximumNumberAgentsLoggedInSimultaneously]     FLOAT (53)     NULL,
    [ACDCallsAbandoned]                             FLOAT (53)     NULL,
    [ACDCallsRequestedCallbackWhileWaitingInQueue]  FLOAT (53)     NULL,
    [ACDCallsOverflowedInAndAnswered]               FLOAT (53)     NULL,
    [NumberOfCallsAnsweredWithinTASA]               FLOAT (53)     NULL,
    [CumulativeTalkTimeOfIncomingACDCalls]          DATETIME       NULL,
    [CumulativeWaitTimeBeforeAnsweredOfACDIncoming] DATETIME       NULL,
    [AvgWaitTimeBeforeAnsweredEmailContacts]        DATETIME       NULL,
    [LongestQueueTimeBeforeAnsweredEmailContacts]   DATETIME       NULL,
    [AvgInteractionTimeEmailContacts]               DATETIME       NULL,
    [CmltvTalkTimeACDCalls]                         DATETIME       NULL,
    [GlobalAggCmltvInteractionTimeEmailContacts]    DATETIME       NULL,
    [TSFEmailContacts]                              FLOAT (53)     NULL,
    [CmltvIntTimeEmailContacts]                     DATETIME       NULL,
    CONSTRAINT [PK_ECC_GROUPBYDATE] PRIMARY KEY CLUSTERED ([ReportRecordId] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ECC_GROUPBYDATE] TO [TACECC]
    AS [dbo];

