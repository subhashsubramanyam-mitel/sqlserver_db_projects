

-- =============================================
-- JO 11192014 trunc SkySFDCAccount table for SkySFDCAccount Sync
-- ============================================= 

CREATE PROCEDURE   [dbo].[TruncSkySFDCAccount_EU] AS

truncate table SkySFDCAccount_EU





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[TruncSkySFDCAccount_EU] TO [ITApps]
    AS [dbo];

