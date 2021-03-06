﻿CREATE SCHEMA [tmp]
	AUTHORIZATION dbo;

GO
GRANT DELETE
    ON SCHEMA::[tmp] TO [TACECC];


GO
GRANT EXECUTE
    ON SCHEMA::[tmp] TO [TACECC];


GO
GRANT INSERT
    ON SCHEMA::[tmp] TO [TACECC];


GO
GRANT SELECT
    ON SCHEMA::[tmp] TO [TACECC];


GO
GRANT UPDATE
    ON SCHEMA::[tmp] TO [TACECC];

GO
GRANT CONTROL 
    ON SCHEMA::[tmp] TO TACECC
WITH GRANT OPTION 
GO;
