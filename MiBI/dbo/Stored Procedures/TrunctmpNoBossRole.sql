 

-- =============================================
-- MW 07252016  Boss Contacts with No Role
-- ============================================= 

create PROCEDURE   [dbo].[TrunctmpNoBossRole] AS
-- =============================================
-- MW 07252016  Boss Contacts with No Role [BOSS_SYNCS_OC]
-- ============================================= 
truncate table tmpNoBossRole





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[TrunctmpNoBossRole] TO [ITApps]
    AS [dbo];

