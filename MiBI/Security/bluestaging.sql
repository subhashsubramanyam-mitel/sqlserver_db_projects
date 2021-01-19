﻿CREATE SCHEMA [BlueStaging]
    AUTHORIZATION [dbo];


GO
GRANT DELETE
    ON SCHEMA::[BlueStaging] TO [TACECC];


GO
GRANT EXECUTE
    ON SCHEMA::[BlueStaging] TO [TACECC];


GO
GRANT INSERT
    ON SCHEMA::[BlueStaging] TO [TACECC];


GO
GRANT SELECT
    ON SCHEMA::[BlueStaging] TO [TACECC];


GO
GRANT UPDATE
    ON SCHEMA::[BlueStaging] TO [TACECC];
