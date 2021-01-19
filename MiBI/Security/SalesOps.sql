CREATE ROLE [SalesOps]
    AUTHORIZATION [dbo];


GO
EXECUTE sp_addrolemember @rolename = N'SalesOps', @membername = N'CANDY\msantos';

