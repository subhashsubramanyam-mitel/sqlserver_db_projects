create view secure.VwUserLedgerAccount as
select distinct OU.Id OlapUserId, A.[GL AccountNum] from enum.AxLedgerAccount A
inner join secure.OlapGroup OG on 
	(OG.GroupCategory = 'Unrestricted') OR
	(--OG.GroupCategory <> 'Unrestricted' and 
	A.[GL Area] in ('Direct Cost','Headcount','Operating Expense'))
inner join secure.GroupMember GM on GM.OlapGroupId = OG.Id
inner join secure.OlapUser OU on OU.Id = GM.OlapUserId
--order by OU.Id, A.[GL AccountNum]
