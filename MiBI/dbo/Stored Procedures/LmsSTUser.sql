

-- =============================================
-- JO 02022017 Reset TermStatusDate for ReHires
-- ============================================= 

CREATE PROCEDURE   [dbo].[LmsSTUser] AS

update LmsSTUsers set TermStatusDate=NULL
Where Status='Active'
and TermStatusDate is not NULL



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[LmsSTUser] TO [CANDY\ITApps]
    AS [dbo];

