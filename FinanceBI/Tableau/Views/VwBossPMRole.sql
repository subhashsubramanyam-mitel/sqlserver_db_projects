Create view tableau.VwBossPMRole as
-- MW 05312019  For Evo Pipeline report

select 
		'US' as Instance
		,a.Id,
		CASE WHEN	[+PM] Is not null then 'PM' 
			 WHEN	[+PM Manager] Is not null then 'PM' 
			 WHEN   [+Support] Is not null then 'Support' 
			 WHEN   [+Support Manager] Is not null then 'Support' 
			 WHEN   a.AccountId = 1 then 'Other Mitel Groups' 
		ELSE 'End User' END as BOSSPMRole
from
people.VwPerson a left outer join
 
(
			select PersonId, 			
			
			[+PM],
			[+PM Manager],
			[+Provisioning],
			[+Support],
			[+Support Manager]
			from
			(
			Select
				 g.MemberPersonId as PersonId
				,gg.Name -- gg.Description
			From	
				M5DB.m5db.dbo.access_GroupMember g inner join
				M5DB.m5db.dbo.access_Group gg on g.GroupId = gg.Id
			Where 
				 gg.Name like '+%'
			) g 
			PIVOT
				(  min(Name) for Name in 
					(	

			[+PM],
			[+PM Manager],
			[+Provisioning],
			[+Support],
			[+Support Manager]

					) 
			) b
) g on a.Id = g.PersonId
where --a.AccountId = 1 and
 a.IsActive = 1
 UNION ALL
 select 
		'EU' as Instance
		,a.Id,
		CASE WHEN	[+PM] Is not null then 'PM' 
			 WHEN	[+PM Manager] Is not null then 'PM' 
			 WHEN   [+Support] Is not null then 'Support' 
			 WHEN   [+Support Manager] Is not null then 'Support' 
			 WHEN   a.AccountId = 1 then 'Other Mitel Groups' 
		ELSE 'End User' END as BOSSPMRole
from
EU_FinanceBI.FinanceBI.people.VwPerson a left outer join
EU_FinanceBI.FinanceBI.people.VwEmployeeGroup  g on a.Id = g.PersonId
where --a.AccountId = 1 and
 a.IsActive = 1
 UNION ALL
 select 
		'AU' as Instance
		,a.Id,
		CASE WHEN	[+PM] Is not null then 'PM' 
			 WHEN	[+PM Manager] Is not null then 'PM' 
			 WHEN   [+Support] Is not null then 'Support' 
			 WHEN   [+Support Manager] Is not null then 'Support' 
			 WHEN   a.AccountId = 1 then 'Other Mitel Groups' 
		ELSE 'End User' END as BOSSPMRole
from
AU_FinanceBI.FinanceBI.people.VwPerson a left outer join
AU_FinanceBI.FinanceBI.people.VwEmployeeGroup  g on a.Id = g.PersonId
where --a.AccountId = 1 and
 a.IsActive = 1