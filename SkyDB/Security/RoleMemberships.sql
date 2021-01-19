ALTER ROLE [db_owner] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_owner] ADD MEMBER [CANDY\tgoradia];


GO
ALTER ROLE [db_accessadmin] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_securityadmin] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [app_skydb];


GO
ALTER ROLE [db_backupoperator] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CANDY\tgoradia];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CANDY\mike];


GO
ALTER ROLE [db_datareader] ADD MEMBER [app_skydb];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CANDY\tabserver];


GO
ALTER ROLE [db_datareader] ADD MEMBER [app_megasilo];


GO
ALTER ROLE [db_datareader] ADD MEMBER [CANDY\ssubramanyam];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [CANDY\tgoradia];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [app_skydb];


GO
ALTER ROLE [db_denydatareader] ADD MEMBER [CANDY\administrator];


GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [CANDY\administrator];

