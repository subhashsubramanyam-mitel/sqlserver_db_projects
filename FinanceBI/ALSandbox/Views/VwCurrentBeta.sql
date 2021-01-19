--DROP VIEW ALSandbox.VwCurrentBeta

CREATE VIEW ALSandbox.VwCurrentBeta AS

SELECT AccountId
FROM ALSandbox.BetaList
WHERE ExcStartDate <= GETDATE()
	AND (ExcEndDate > eomonth(GETDATE())
			OR ExcEndDate IS NULL)

--DELETE FROM ALSandbox.BetaList
--WHERE AccountId IN (15952, 16123)
--	AND ExcEndDate IS NULL

--INSERT INTO ALSandbox.BetaList
--(AccountId, ExcStartDate, ExcEndDate)
--VALUES
--(16123, '2016-01-01', '2016-10-31')
