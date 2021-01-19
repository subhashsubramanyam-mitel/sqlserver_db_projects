
-- =============================================
-- JO 10272014 trunc Arena Eco Dump temp table for Item import
-- ============================================= 

CREATE PROCEDURE   [dbo].[TruncArenaEcoUploadCheck] AS

truncate table ArenaEcoUploadCheck;





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[TruncArenaEcoUploadCheck] TO [CRAdmin]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[TruncArenaEcoUploadCheck] TO [ITApps]
    AS [dbo];

