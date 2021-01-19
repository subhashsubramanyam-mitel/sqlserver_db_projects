CREATE SCHEMA [analytics]
    AUTHORIZATION [dbo];


GO
GRANT ALTER
    ON SCHEMA::[analytics] TO [app_megasilo];


GO
GRANT DELETE
    ON SCHEMA::[analytics] TO [app_megasilo];


GO
GRANT INSERT
    ON SCHEMA::[analytics] TO [app_megasilo];


GO
GRANT SELECT
    ON SCHEMA::[analytics] TO [app_megasilo];


GO
GRANT UPDATE
    ON SCHEMA::[analytics] TO [app_megasilo];

