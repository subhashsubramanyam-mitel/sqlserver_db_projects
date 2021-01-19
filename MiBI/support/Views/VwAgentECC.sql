create view support.VwAgentECC as
select b.UserEmail,
cast(sum(a.ACDPresentedCalls) as decimal(10,1)) as [ACD Queue],
cast(sum(a.ACDansweredcalls) as decimal(10,1)) as [ACD Handled Calls],
cast(sum(a.NACDincomingcalls) as decimal(10,1)) as [NACD Incoming Calls],
cast(sum(a.NACDOutgoingCalls) as decimal(10,1)) as [NACD Outgoing Calls],
cast(sum(a.OutboundACDAnswered) as decimal(10,1)) as [OACD Handled Calls],
cast(sum(a.Emailcontactsanswered) as decimal(10,1)) as [Emails]

from ECC_AGENTBYDATE (nolock) a
inner join
ECC_AGENT_LOOKUP b on a.AgentID = b.AgentID inner join
              (select 
               ID
              ,Email
              ,row_number() over (partition by Email order by CreatedDate desc) rn
              from Users
              ) u on b.UserEmail = u.Email and u.rn = 1
where MONTH(a.Date) = MONTH(dateadd(dd, -1, GetDate()))
AND YEAR(a.Date) = YEAR(dateadd(dd, -1, GetDate()))
GROUP BY b.UserEmail
