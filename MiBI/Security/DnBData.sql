CREATE ROLE [DnBData]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'DnBData', @membername = N'CANDY\MEdwards';


GO
EXECUTE sp_addrolemember @rolename = N'DnBData', @membername = N'CANDY\ALee';


GO
EXECUTE sp_addrolemember @rolename = N'DnBData', @membername = N'Marketing';


GO
EXECUTE sp_addrolemember @rolename = N'DnBData', @membername = N'CANDY\lpedro';


GO
EXECUTE sp_addrolemember @rolename = N'DnBData', @membername = N'CANDY\SMcElderry';


GO
EXECUTE sp_addrolemember @rolename = N'DnBData', @membername = N'CANDY\msantos';


GO
EXECUTE sp_addrolemember @rolename = N'DnBData', @membername = N'CANDY\medwards';

