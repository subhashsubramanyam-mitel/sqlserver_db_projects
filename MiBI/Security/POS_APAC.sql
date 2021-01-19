CREATE ROLE [POS_APAC]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'POS_APAC', @membername = N'CANDY\BYeung';

