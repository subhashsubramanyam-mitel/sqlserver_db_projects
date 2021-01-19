


-- =============================================
-- JO 11192014 trunc SkySFDCAccount table for SkySFDCAccount Sync
-- ============================================= 

CREATE PROCEDURE   [dbo].[TruncSkySFDCAccount_AU] AS

truncate table SkySFDCAccount_AU






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[TruncSkySFDCAccount_AU] TO [ITApps]
    AS [dbo];

