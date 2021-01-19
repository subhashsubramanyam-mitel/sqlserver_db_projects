CREATE ROLE [SKY_SFDC]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'SKY_SFDC', @membername = N'CANDY\bdavis';

