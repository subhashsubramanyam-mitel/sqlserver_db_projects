CREATE View ALSandbox.VwNetVoidData AS 

--WITH NetVoidData AS 
--	(
	SELECT Voids.*
		,LA.*
		,CASE WHEN VoidedInitialOrderMRR >= LinkedAddMRR THEN VoidedInitialOrderMRR-LinkedAddMRR
			  WHEN VoidedInitialOrderMRR < LinkedAddMRR THEN 0
			  END AS NetVoidedMRR
	FROM 
		(
		SELECT AccountId
			,SUM(MonthlyCharge) AS InitialOrderMRR
			,SUM(CASE WHEN ServiceStatusId = 25 THEN MonthlyCharge ELSE 0 END) AS VoidedInitialOrderMRR
		FROM oss.VwServiceProduct_EX SP
		WHERE OrderTypeId = 0
			AND IsMRRZero = 'NonZero'
		GROUP BY AccountId
		) Voids
	LEFT JOIN
		(
		SELECT AccountId AS LAAccountId
			,SUM(MonthlyCharge) AS LinkedAddMRR
		FROM oss.VwServiceProduct_EX SP
		WHERE OrderTypeId = 9
			AND ServiceStatusId != 25
			AND IsMRRZero = 'NonZero'
		GROUP BY AccountId
		) LA
	ON Voids.AccountId = LA.LAAccountId