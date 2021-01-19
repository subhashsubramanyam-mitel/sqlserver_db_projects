CREATE ROLE [LmsData]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'LmsData', @membername = N'CANDY\AHerrell';


GO
EXECUTE sp_addrolemember @rolename = N'LmsData', @membername = N'CANDY\jmcneill';


GO
EXECUTE sp_addrolemember @rolename = N'LmsData', @membername = N'CANDY\mbridges';


GO
EXECUTE sp_addrolemember @rolename = N'LmsData', @membername = N'CANDY\csharp';


GO
EXECUTE sp_addrolemember @rolename = N'LmsData', @membername = N'CANDY\medwards';

