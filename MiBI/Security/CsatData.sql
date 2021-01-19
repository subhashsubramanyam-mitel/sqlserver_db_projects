CREATE ROLE [CsatData]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\DCouchman';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\AHerrell';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\BPaddock';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\MEdwards';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'TACECC';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\IT';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\DWalter';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\elopez';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\CCunningham';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\khafner';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\DParrilli';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\bdavis';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\ITApps';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\medwards';


GO
EXECUTE sp_addrolemember @rolename = N'CsatData', @membername = N'CANDY\kharris';

