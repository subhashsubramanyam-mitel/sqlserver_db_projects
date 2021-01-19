


CREATE view [Tableau].[VwPMInfo] as
-- Employees  MW 05162019
select 
		'US' as Instance
		,a.Id,
		a.Email,
		a.UserName,
		a.FirstName
		,a.LastName 
		,a.FullName
		,b.Name as LocationName, 
		b.Address 
			,[+AA],
			[+AM],
			[+Billing],
			[+Billing Director/Manager],
			[+Carrier],
			[+Collections],
			[+Everyone],
			[+Inventory],
			[+IT],
			[+Networks-Systems],
			[+NOC],
			[+PM],
			[+PM Manager],
			[+Provisioning],
			[+QA],
			[+SA],
			[+Sales],
			[+Support],
			[+Support Manager]

from
people.VwPerson a left outer join
company.Location b on a.LocationId = b.Id left outer join
(
			select PersonId, 			
			[+AA],
			[+AM],
			[+Billing],
			[+Billing Director/Manager],
			[+Carrier],
			[+Collections],
			[+Everyone],
			[+Inventory],
			[+IT],
			[+Networks-Systems],
			[+NOC],
			[+PM],
			[+PM Manager],
			[+Provisioning],
			[+QA],
			[+SA],
			[+Sales],
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
			[+AA],
			[+AM],
			[+Billing],
			[+Billing Director/Manager],
			[+Carrier],
			[+Collections],
			[+Everyone],
			[+Inventory],
			[+IT],
			[+Networks-Systems],
			[+NOC],
			[+PM],
			[+PM Manager],
			[+Provisioning],
			[+QA],
			[+SA],
			[+Sales],
			[+Support],
			[+Support Manager]

					) 
			) b
) g on a.Id = g.PersonId


where a.AccountId = 1 and a.IsActive = 1

 
UNION ALL
select 
		'EU' as Instance
		,a.Id,
		a.Email,
		a.UserName,
		a.FirstName
		,a.LastName 
		,a.FullName
		,b.Name as LocationName, 
		b.Address 
		,[+AA],
			[+AM],
			[+Billing],
			[+Billing Director/Manager],
			[+Carrier],
			[+Collections],
			[+Everyone],
			[+Inventory],
			[+IT],
			[+Networks-Systems],
			[+NOC],
			[+PM],
			[+PM Manager],
			[+Provisioning],
			[+QA],
			[+SA],
			[+Sales],
			[+Support],
			[+Support Manager]
from
EU_FinanceBI.FinanceBI.people.VwPerson a left outer join
EU_FinanceBI.FinanceBI.company.Location b on a.LocationId = b.Id left outer join
EU_FinanceBI.FinanceBI.people.VwEmployeeGroup  g on a.Id = g.PersonId

where a.AccountId = 1 and a.IsActive = 1
UNION ALL
select 
		'AU' as Instance
		,a.Id,
		a.Email,
		a.UserName,
		a.FirstName
		,a.LastName 
		,a.FullName
		,b.Name as LocationName, 
		b.Address 
				,[+AA],
			[+AM],
			[+Billing],
			[+Billing Director/Manager],
			[+Carrier],
			[+Collections],
			[+Everyone],
			[+Inventory],
			[+IT],
			[+Networks-Systems],
			[+NOC],
			[+PM],
			[+PM Manager],
			[+Provisioning],
			[+QA],
			[+SA],
			[+Sales],
			[+Support],
			[+Support Manager]
 
from
AU_FinanceBI.FinanceBI.people.VwPerson a left outer join
AU_FinanceBI.FinanceBI.company.Location b on a.LocationId = b.Id left outer join
AU_FinanceBI.FinanceBI.people.VwEmployeeGroup  g on a.Id = g.PersonId
where a.AccountId = 1 and a.IsActive = 1
 
