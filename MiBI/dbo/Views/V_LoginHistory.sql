

CREATE VIEW [dbo].[V_LoginHistory]
AS

--JO 12122016 per MattBrondum/Andrew Lossing created Login History Details for ShoreTel Community=Trust
SELECT        a.ID, a.UserId, b.AccountId, a.LoginTime, b.RoleName --NetworkId, Status
from LoginHistory a Left Outer Join
Users b on a.UserId=b.ID

Where a.Status='Success'
--order by 4



GO
GRANT SELECT
    ON OBJECT::[dbo].[V_LoginHistory] TO [CANDY\alossing]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_LoginHistory] TO [CANDY\MBrondum]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_LoginHistory] TO [CANDY\dorr]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_LoginHistory] TO [CANDY\beswanson]
    AS [dbo];

