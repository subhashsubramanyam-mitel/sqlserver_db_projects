CREATE VIEW [MWSandbox].[VwUserAddOns]
AS
-- MW 12192017 User level Add Ons
SELECT AccountId
	,LocationId
	,TN
	,SUM(FAX) AS FAX
	,SUM(SCRIBE) AS SCRIBE
	,SUM(CR) AS CR
	,SUM(CONF) AS CONF
	,SUM(MOB) AS MOB
FROM (
	SELECT a.AccountId
		,a.LocationId
		,a.TN
		,CASE 
			WHEN a.ProductId IN (
					--fax
					18
					,359
					)
				THEN 1
			ELSE 0
			END AS FAX
		,CASE 
			WHEN a.ProductId IN (
					--Scribe
					116
					,131
					)
				THEN 1
			ELSE 0
			END AS SCRIBE
		,CASE 
			WHEN a.ProductId IN (
					--Call Recording
					127
					,191
					,192
					)
				THEN 1
			ELSE 0
			END AS CR
		,CASE 
			WHEN a.ProductId IN (
					-- conferencing
					82
					,167
					,168
					,169
					,170
					,171
					,172
					,173
					,174
					,175
					,176
					,177
					,180
					,181
					)
				THEN 1
			ELSE 0
			END AS CONF
		-- Mobility
		,CASE 
			WHEN a.ProductId IN (
					255
					,299
					)
				THEN 1
			ELSE 0
			END AS MOB
	FROM [$(FinanceBI)].[oss].[VwServiceProduct_EX] a
	WHERE a.ServiceStatusId = 1
		AND a.ProductId IN (
			--fax
			18
			,359
			,
			--Scribe
			116
			,131
			,
			-- call Recording
			127
			,191
			,192
			,
			-- conferencing
			82
			,167
			,168
			,169
			,170
			,171
			,172
			,173
			,174
			,175
			,176
			,177
			,180
			,181
			-- Mobility
			,255
			,299
			)
	) a
GROUP BY AccountId
	,LocationId
	,TN