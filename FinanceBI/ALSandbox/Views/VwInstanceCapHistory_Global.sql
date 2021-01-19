
CREATE VIEW ALSandbox.VwInstanceCapHistory_Global AS

SELECT 'North America' AS BOSS_Instance,
	*
FROM ALSandbox.VwInstanceCapHistory_NA

UNION ALL
SELECT 'AU' AS BOSS_Instance,
	*
FROM AU_FinanceBI.FinanceBI.ALSandbox.VwInstanceCapHistory_AU

UNION ALL
SELECT 'EU' AS BOSS_Instance,
	*
FROM EU_FinanceBI.FinanceBI.ALSandbox.VwInstanceCapHistory_EU