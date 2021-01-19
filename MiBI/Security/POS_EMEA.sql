CREATE ROLE [POS_EMEA]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'POS_EMEA', @membername = N'CANDY\pdrew';

