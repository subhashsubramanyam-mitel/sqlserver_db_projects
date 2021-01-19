CREATE VIEW ALSandbox.VwSHV_MRRD AS

WITH MonthlyLineMRR AS
(
SELECT AccountID
	,ParentGroupID
	,[Account Name]
	,ParentGroup
	,[Description]
	,dateadd(month, -1,ServiceMonth) AS InvMonth
	,SUM(Charge) AS MRR_LC
	,SUM(Quantity) as Quantity
	,SUM(Charge)/SUM(Quantity) as UnitPrice_LC
  FROM [SMD].[SMD].[dbo].[Australia_SHV_BillingsData] SHV
  WHERE ChargeType = 'MRR'
  GROUP BY ServiceMonth, ParentGroup, [Account Name], [Description], AccountID, ParentGroupID

),

MonthlyAcMRR AS
(
SELECT 
	dateadd(month,-1,ServiceMonth) AS InvMonth
	,ParentGroup
	,SUM(Charge) AS MRR_LC
  FROM [SMD].[SMD].[dbo].[Australia_SHV_BillingsData] SHV
  WHERE ChargeType = 'MRR'
  GROUP BY ServiceMonth, ParentGroup

),

MRRDelta as 
(
SELECT MRRD.*
	,dateadd(month,-1,MRRD.InvMonth) AS ChangeMonth
	,NewAcMRR.MRR_LC AS NewAcMRR_LC
	,PrvAcMRR.MRR_LC AS PrvAcMRR_LC
	,CASE WHEN MRRDelta_LC = 0 THEN 'NoChange'
		WHEN PrvAcMRR.MRR_LC IS NULL OR PrvAcMRR.MRR_LC = 0 THEN 'Install'
		WHEN NewAcMRR.MRR_LC IS NULL OR NewAcMRR.MRR_LC = 0 THEN 'Cancel - Ac Close'
		WHEN (NewUnitPrice_LC = PrvUnitPrice_LC OR PrvUnitPrice_LC IS NULL)
				AND NewQty > PrvQty THEN 'Add'
		WHEN (NewUnitPrice_LC = PrvUnitPrice_LC OR NewUnitPrice_LC IS NULL)
				AND NewQty < PrvQty THEN 'Cancel - Downsize'
		WHEN NewUnitPrice_LC > PrvUnitPrice_LC THEN 'PriceIncr'
		WHEN NewUnitPrice_LC < PrvUnitPrice_LC THEN 'PriceDecr'
		ELSE 'Anomaly'
	END AS MRR_Category
FROM
	(
	SELECT coalesce(New.AccountID,prv.AccountID) AS AccountID
		,coalesce(New.ParentGroupID,prv.ParentGroupID) AS ParentGroupID
		,coalesce(New.[Account Name],prv.[Account Name]) AS 'Account Name'
		,coalesce(New.ParentGroup,prv.ParentGroup) AS ParentGroup
		--,New.ServiceMonth AS NewServiceMonth
		--,prv.ServiceMonth AS PreviousServiceMonth
		,coalesce(New.InvMonth, dateadd(month,1,prv.InvMonth)) AS InvMonth
		,coalesce(New.[Description],prv.[Description]) AS 'Description'
		,New.MRR_LC AS NewMRR_LC
		,prv.MRR_LC AS PrvMRR_LC
		,coalesce(New.Quantity,0) AS NewQty
		,coalesce(prv.Quantity,0) AS PrvQty
		,New.UnitPrice_LC AS NewUnitPrice_LC
		,prv.UnitPrice_LC AS PrvUnitPrice_LC

		,coalesce(New.MRR_LC,0)-coalesce(prv.MRR_LC,0) AS MRRDelta_LC
	FROM MonthlyLineMRR New
	FULL OUTER JOIN MonthlyLineMRR Prv
		ON New.[Account Name] = prv.[Account Name]
			AND New.ParentGroup = Prv.ParentGroup
			AND dateadd(month,-1,New.InvMonth) = Prv.InvMonth
			AND New.[Description] = prv.[Description]
			AND New.AccountID = prv.AccountID
			AND New.ParentGroupID = prv.ParentGroupID

	) MRRD
LEFT JOIN MonthlyAcMRR NewAcMRR
	ON NewAcMRR.ParentGroup = MRRD.ParentGroup
		AND NewAcMRR.InvMonth = MRRD.InvMonth
LEFT JOIN MonthlyAcMRR PrvAcMRR
	ON PrvAcMRR.ParentGroup = MRRD.ParentGroup
		AND PrvAcMRR.InvMonth = dateadd(month,-1,MRRD.InvMonth)
)

SELECT SHV_MRRD.*
	,MRRDelta_LC*EX.exchrate/100 AS MRRDelta_USD
	,EX.exchrate AS SpotExchangeRate
FROM MRRDelta SHV_MRRD
INNER JOIN [SMD].[SMD].[dbo].[V_AX_EXCHRATE_ALL] EX
	ON dateadd(day,-1,SHV_MRRD.InvMonth) = EX.FromDate
WHERE currencycode = 'AUD'
