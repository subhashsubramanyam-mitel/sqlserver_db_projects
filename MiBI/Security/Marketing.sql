CREATE ROLE [Marketing]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\MEdwards';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\ALee';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\dkurian';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\tbrown';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\lpedro';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\SMcElderry';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\msantos';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\ldinard';


GO
EXECUTE sp_addrolemember @rolename = N'Marketing', @membername = N'CANDY\medwards';

