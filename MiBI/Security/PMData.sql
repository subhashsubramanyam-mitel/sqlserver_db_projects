CREATE ROLE [PMData]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\BPaddock';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\KGollapudi';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\NKagramanova';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\shogan';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\lpedro';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\SMcElderry';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\msantos';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\ldinard';


GO
EXECUTE sp_addrolemember @rolename = N'PMData', @membername = N'CANDY\KKruger';

