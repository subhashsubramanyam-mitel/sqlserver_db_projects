
CREATE view  [secure].[VwUserDepartment] as
select distinct OU.Id OlapUserId, D.[Dept Id] from enum.AxDepartment D
inner join secure.OlapGroup OG on 
	(OG.GroupCategory = 'Unrestricted') OR
	(OG.GroupCategory = 'Dept Level1' and OG.CategoryValue = D.[Dept Level1]) OR
	(OG.GroupCategory = 'Dept Level2' and OG.CategoryValue = D.[Dept Level2]) OR
	(OG.GroupCategory = 'Dept Level3' and OG.CategoryValue = D.[Dept Level3]) OR
	(OG.GroupCategory = 'Dept Id' and OG.CategoryValue = D.[Dept Id]) 
inner join secure.GroupMember GM on GM.OlapGroupId = OG.Id
inner join secure.OlapUser OU on OU.Id = GM.OlapUserId
--order by OU.Id, D.[Dept Id]

