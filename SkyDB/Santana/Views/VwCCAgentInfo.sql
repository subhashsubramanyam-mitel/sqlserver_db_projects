

CREATE view [Santana].[VwCCAgentInfo] as
-- MW 05272020 SHow Agent Info
with scc as
(SELECt *
,row_number() over (partition by username order by instance) rn
  FROM [SkyTeamSandbox].[sccUserDetail]
)

select * from (
select  p.Tn, null as PersonId, scc.agent as isCCAgent, scc.supervisor as isCCSupervisor
	,row_number() over (partition by p.tn order by p.AccountId desc) rn 
FROM
--[$(FinanceBI)].people.VwPerson a 
[$(FinanceBI)].provision.VwProfile p inner join --on a.AccountId = p.AccountID and a.ProfileTN = p.Tn  and p.IsActive = 1  inner join
scc on p.Tn = scc.username and scc.rn = 1
) a where rn =1 
