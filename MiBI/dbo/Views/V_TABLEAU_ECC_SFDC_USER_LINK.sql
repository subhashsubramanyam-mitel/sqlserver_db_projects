



/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[V_TABLEAU_ECC_SFDC_USER_LINK]
AS
-- MW 06132019 ECC Data with SFDC USER ID
-- to support join to Support datasources
SELECT u.ID AS SFDCUserID
	,a.Created
	,a.Date
	,a.PCTACDabandonedcallsofACDpresented
	,a.PCTCmltvidletimeformultiplegroups
	,a.PCTReleasetime
	,a.PCTReleasetimeformultiplegroups
	,a.ACDabandonedcalls
	,a.ACDansweredcalls
	,a.ACDpresentednotansweredcalls
	,a.AvgACDemailinteractiontime
	,a.AvgACDholdtime
	,a.AvgACDtalktime
	,a.AvgACDWrapuptime
	,a.AvgtalktimeofNACDincoming
	,a.AvgtalktimeofNACDoutgoing
	,a.Chatcontactsanswered
	,a.Cmltvlogintime
	,a.Cmltvreleasetimeformultiplegroups
	,a.CmltvtalktimeofNACDoutgoing
	,a.Emailcontactsanswered
	,a.NACDincomingcalls
	,a.Logintimeformultiplegroups
	,a.LongestACDtalktime
	,a.AgentID
	,a.AgentNumber
	,a.AgentName
	,a.ACDPresentedCalls
	,a.ChatContactsPresented
	,a.EmailContactsPresented
	,a.AvgACDChatInteractionTime
	,a.LongestACDChatInteractionTime
	,a.LongestACDEmailInteractionTime
	,a.ChatContactsPresentedNotAnswered
	,a.CmltvACDEmailInteractionTime
	,a.OutboundACDAnswered
	,a.CmltvIdleTimeForMultipleGroups
	,a.NACDOutgoingCalls
	,a.OutboundACDPresented
	,'ECC' as Source
FROM dbo.ECC_AGENTBYDATE a(NOLOCK)
INNER JOIN dbo.ECC_AGENT_LOOKUP b(NOLOCK) ON a.AgentID = b.AgentID
INNER JOIN (
	SELECT ID
		,Email
		,row_number() OVER (
			PARTITION BY Email ORDER BY CreatedDate DESC
 

			) rn
	FROM dbo.Users WITH(NOLOCK)

	) u ON lower(b.UserEmail) = lower(u.Email)
	AND u.rn = 1

UNION ALL
-- MW 07162020 hack hack hack for duplicate SFDC Emails/Users 
SELECT u.ID AS SFDCUserID
	,a.Created
	,a.Date
	,a.PCTACDabandonedcallsofACDpresented
	,a.PCTCmltvidletimeformultiplegroups
	,a.PCTReleasetime
	,a.PCTReleasetimeformultiplegroups
	,a.ACDabandonedcalls
	,a.ACDansweredcalls
	,a.ACDpresentednotansweredcalls
	,a.AvgACDemailinteractiontime
	,a.AvgACDholdtime
	,a.AvgACDtalktime
	,a.AvgACDWrapuptime
	,a.AvgtalktimeofNACDincoming
	,a.AvgtalktimeofNACDoutgoing
	,a.Chatcontactsanswered
	,a.Cmltvlogintime
	,a.Cmltvreleasetimeformultiplegroups
	,a.CmltvtalktimeofNACDoutgoing
	,a.Emailcontactsanswered
	,a.NACDincomingcalls
	,a.Logintimeformultiplegroups
	,a.LongestACDtalktime
	,a.AgentID
	,a.AgentNumber
	,a.AgentName
	,a.ACDPresentedCalls
	,a.ChatContactsPresented
	,a.EmailContactsPresented
	,a.AvgACDChatInteractionTime
	,a.LongestACDChatInteractionTime
	,a.LongestACDEmailInteractionTime
	,a.ChatContactsPresentedNotAnswered
	,a.CmltvACDEmailInteractionTime
	,a.OutboundACDAnswered
	,a.CmltvIdleTimeForMultipleGroups
	,a.NACDOutgoingCalls
	,a.OutboundACDPresented
	,'ECC' as Source
FROM dbo.ECC_AGENTBYDATE a(NOLOCK)
INNER JOIN (
 
select '0051A00000CvAsUQAV' as ID, 435 as AgentID 
UNION ALL
select '0051A00000C7KLzQAN' as ID, 346 as AgentID 
UNION ALL
select '0051A00000CXNfQQAX' as ID, 370  as AgentID 
UNION ALL
select '0051A00000DME2HQAX' as ID, 422  as AgentID 
UNION ALL
select '0050h00000Gp4zsAAB' as ID, 6975  as AgentID 
UNION ALL
select '005C0000005RXs5IAG' as ID, 52  as AgentID 
		
			) u on  a.AgentID = u.AgentID
UNION ALL
SELECT 
	 a.AgentSfdcId AS SFDCUserID
	,a.Created
	,a.Date
	,a.PCTACDabandonedcallsofACDpresented
	,a.PCTCmltvidletimeformultiplegroups
	,a.PCTReleasetime
	,a.PCTReleasetimeformultiplegroups
	,a.ACDabandonedcalls
	,a.ACDansweredcalls
	,a.ACDpresentednotansweredcalls
	,a.AvgACDemailinteractiontime
	,a.AvgACDholdtime
	,a.AvgACDtalktime
	,a.AvgACDWrapuptime
	,a.AvgtalktimeofNACDincoming
	,a.AvgtalktimeofNACDoutgoing
	,a.Chatcontactsanswered
	,a.Cmltvlogintime
	,a.Cmltvreleasetimeformultiplegroups
	,a.CmltvtalktimeofNACDoutgoing
	,a.Emailcontactsanswered
	,a.NACDincomingcalls
	,a.Logintimeformultiplegroups
	,a.LongestACDtalktime
	,a.AgentID
	,a.AgentNumber
	,a.AgentName
	,a.ACDPresentedCalls
	,a.ChatContactsPresented
	,a.EmailContactsPresented
	,a.AvgACDChatInteractionTime
	,a.LongestACDChatInteractionTime
	,a.LongestACDEmailInteractionTime
	,a.ChatContactsPresentedNotAnswered
	,a.CmltvACDEmailInteractionTime
	,a.OutboundACDAnswered
	,a.CmltvIdleTimeForMultipleGroups
	,a.NACDOutgoingCalls
	,a.OutboundACDPresented
	,'MiCC' as Source
FROM 
MiCC_Agent a
where a.Date > '2020-10-02'




GO
GRANT SELECT
    ON OBJECT::[dbo].[V_TABLEAU_ECC_SFDC_USER_LINK] TO [TACECC]
    AS [dbo];

