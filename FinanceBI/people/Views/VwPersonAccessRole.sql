create VIEW people.VwPersonAccessRole
AS
SELECT     CONVERT(varchar, coalesce(AccountId,0)) + '.' 
	+ CONVERT(varchar, coalesce(LocationId,0)) 	+ '.'
	+ CONVERT(varchar, PersonId) + '.' 
	+ CONVERT(varchar, RoleId)  as UniqueId, 
                      AccountId AS RoleAccountId, LocationId AS RoleLocationId, PersonId, RoleId, 1 AS Num
FROM         people.AccessRoleMember
