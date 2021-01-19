CREATE VIEW ALSandbox.VwInstanceCap_Global AS

SELECT 'North America' AS BOSS_Instance,
	*
FROM ALSandbox.VwInstanceCap_NA

UNION ALL
SELECT 'AU' AS BOSS_Instance,
	*
FROM AU_FinanceBI.FinanceBI.ALSandbox.VwInstanceCap_AU

UNION ALL
SELECT 'EU' AS BOSS_Instance,
	*
FROM EU_FinanceBI.FinanceBI.ALSandbox.VwInstanceCap_EU