CREATE ROLE [Reporting]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\BPaddock';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\MEdwards';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\AMohandas';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\medwards';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\brobison';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\aneuman';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\alossing';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\MBrondum';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\dorr';


GO
EXECUTE sp_addrolemember @rolename = N'Reporting', @membername = N'CANDY\beswanson';

