/*
CREATE VIEW V_PH_CONNECT_AX_SYNC
AS
--View for connect Customer sync to AX.  SHows AX accounts that are not marked as connect MW 09012015
SELECT a.ST_ID AS ShoretelId
FROM dbo.V_PH_CONNECT_CUSTOMER a
INNER JOIN SVLCORPAXDB1.PROD.dbo.CUSTTABLE b ON a.ST_ID = b.ACCOUNTNUM collate database_default
-- AX is out of sync:
WHERE b.STCONNECTCUSTOMER = 0
*/