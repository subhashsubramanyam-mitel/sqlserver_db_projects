
/* Change log:
     Jan 28, 2019 , Tarak, added date svc live actual = date svc closed is equivalent to voiding, per Kelly

*/
CREATE VIEW [oss].[VwServiceProduct_EX_Lite]
AS
SELECT SP.ServiceId
	,ProductId
	,LichenServiceId
	,SP.LichenPlanId
	,SP.ServiceClassId
	,ServiceStatusId
	,SP.AccountId
	,SP.InvoiceServiceGroupId
	,SP.LocationId
	,ServiceBundleId
	,REPLACE(REPLACE(SP.Name, CHAR(10), ''), CHAR(9), '') Name
	,IsAttachedToTN
	,CASE 
		WHEN T.Id = ''
			THEN NULL
		ELSE T.Id
		END AS TN
	,SP.InvoiceLabel
	,SP.OrderId
	,OrderTypeId
	,WasInInitialOrder
	,CASE 
		WHEN OrderProjectManagerId IS NOT NULL
			THEN OrderProjectManagerId
		ELSE OrderCreatedByPersonId
		END AS OrderProjectManagerId
	,OrderCreatedByPersonId
	,OrderedById
	,OrderSalesPersonId
	,Coalesce(MonthlyCharge, 0) * EX.EXCHRATE / 100 MonthlyCharge
	,Coalesce(OneTimeCharge, 0) * EX.EXCHRATE / 100 OneTimeCharge
	,DateSvcCreated
	,DateSvcModified
	,DateSvcLiveScheduled
	,-- 2014-05-08 as requested by Kerrin and Kelly, expose 'as is'
	DateSvcLiveActual
	,DateSvcCloseOrdered
	,MonthSvcCloseOrdered
	,ClosedByPersonId
	,DateSvcClosed
	,DateBillingValidFrom
	,DateBillingValidTo
	,CASE 
		WHEN Coalesce(SP.MonthSetupInvoiced, MonthMRRFirstInvoiced) = const.LastBilledMonth
			THEN 1
		ELSE 0
		END AS IsBilledFirstTime
	,MonthSetupInvoiced
	,MonthLastInvoiced
	,MonthMRRFirstInvoiced
	,MonthMRRLastInvoiced
	,DateMRRInvoicedTo
	,MonthCreditIssued
	,DateCreditedFrom
	,DateCreditedTo
	,CreatedByPersonId
	,ModifiedByPersonId
	,CASE -- order of when clauses is IMPORTANT
		WHEN SP.ServiceStatusId IN (
				25
				,26
				)
			THEN 'Voided'
		WHEN SP.ServiceStatusId = 14
			THEN 'Moved'
		WHEN IA.Category IS NOT NULL
			AND IA.Category = 'Install'
			THEN 'ToStartBilling'
		WHEN IA.Category IS NOT NULL
			AND IA.Category IN (
				'PriceDecr'
				,'PriceIncr'
				,'ChangeProductFrom'
				,'ChangeProductTo'
				)
			THEN 'BillingChanged'
		WHEN IA.Category IS NOT NULL
			AND IA.Category IN ('NoChange')
			THEN 'Billing'
		WHEN SP.MonthMRRLastInvoiced IS NOT NULL
			AND SP.MonthMRRLastInvoiced = const.LastBilledMonth
			AND SP.DateBillingValidFrom IS NOT NULL
			AND SP.DateBillingValidTo IS NULL
			THEN 'Billing'
		WHEN SP.DateSvcClosed = SP.DateSvcLiveActual
			THEN 'Voided' -- Jan 28, 2019 , equivalent to voiding, per Kelly
		WHEN SP.MonthMRRLastInvoiced IS NULL
			AND SP.MonthSetupInvoiced IS NOT NULL
			THEN 'BilledSetup'
		WHEN SP.ServiceStatusId IN (
				5
				,17
				,32
				)
			-- and dbo.UfnGreatestDate(SP.MonthMRRLastInvoiced, SP.DateBillingValidTo, SP.DateSvcClosed, null,null,null)
			--	 < const.LastBilledMonth -- before last billig cycle
			-- experimenting below (Aug 3)
			AND (
				SP.MonthMRRLastInvoiced < const.LastBilledMonth
				--	and SP.DateMRRInvoicedTo < DateAdd(month, +2, const.LastBilledMonth)
				--OR SP.DateBillingValidTo < const.LastBilledMonth
				OR SP.MonthMRRFirstInvoiced IS NULL -- Setup only services that are closed
				--OR SP.DateBillingValidFrom is null
				--OR SP.DateSvcClosed < const.LastBilledMonth
				)
			THEN 'Closed'
		WHEN SP.ServicestatusId IN (
				5
				,17
				,32
				)
			AND MonthMRRLastInvoiced IS NOT NULL
			AND DateMRRInvoicedTo >= DateAdd(month, + 2, const.LastBilledMonth)
			THEN 'InClosing'
		WHEN SP.ServicestatusId = 1
			AND SP.DateBillingValidFrom IS NOT NULL
			AND SP.DateBillingValidTo IS NULL
			AND SP.DateBillingValidFrom >= DateAdd(month, - 2, const.LastBilledMonth)
			THEN CASE 
					WHEN SP.DateBillingValidFrom >= DateAdd(month, + 1, const.LastBilledMonth)
						THEN 'FutureBilling' -- previously ToStartBilling
					WHEN SP.DateBillingValidFrom >= DateAdd(month, - 2, const.LastBilledMonth)
						THEN 'ToStartBilling'
					END
		WHEN SP.MonthSetupInvoiced IS NOT NULL
			AND SP.MonthlyCharge = 0.0
			THEN 'LingeringSetup'
		WHEN SP.ServicestatusId = 1
			AND SP.DateBillingValidFrom IS NOT NULL
			AND SP.DateBillingValidFrom < DateAdd(month, - 2, const.LastBilledMonth)
			AND SP.DateBillingValidTo IS NULL
			THEN 'LingeringUnbilled'
		WHEN SP.ServiceStatusId NOT IN (
				1
				,5
				,14
				,17
				)
			AND (
				(
					SP.DateSvcLiveScheduled IS NOT NULL
					AND SP.DateSvcLiveScheduled >= dbo.UfnGetDatePart(GETDATE())
					) -- if passed, it becomes unscheduled
				OR L.DateLiveForecast IS NOT NULL
				AND L.DateLiveForecast >= dbo.UfnGetDatePart(GETDATE())
				)
			THEN 'Forecasted'
		WHEN SP.ServiceStatusId NOT IN (
				1
				,5
				,14
				,17
				)
			AND Coalesce(SP.MonthSetupInvoiced, MonthMRRFirstInvoiced) IS NULL
			THEN 'Unscheduled'
		ELSE 'Limbo'
		END AS BillingStage
	,DataIssueId
	,L.ConnectivityType [Loc Connecticitytype]
	,L.InvoiceGroupId [Loc InvoiceGroupId]
	,A.FirstNPS [Ac FirstNps]
	,A.LastNPS [Ac LastNps]
	,A.[DateFirstServiceLive] [Ac DateFirstServiceLive]
	,A.DateFirstInvoiced [Ac DateFirstInvoiced]
	,A.PartnerId [Ac PartnerId]
	,DATEDIFF(day, sp.DateSvcCreated, today.thisdate) NumLifeDays
	,enum.[UfnLifeDaysSegmentId](sp.DateSvcCreated, today.thisdate) LifeDaysSegmentId
	,CASE 
		WHEN Coalesce(MonthlyCharge, 0.0) <> 0.0
			THEN 'NonZero'
		ELSE 'Zero'
		END IsMRRZero
	,CASE 
		WHEN Coalesce(OneTimeCharge, 0) <> 0.0
			THEN 'NonZero'
		ELSE 'Zero'
		END IsNRCZero
	,SP.CircuitStatusId
	,[enum].[UfnAvgLifeDaysSegmentId](DATEDIFF(day, sp.DateSvcCreated, today.thisdate)) LifeDaysNewSegmentId
	,SP.InFirstContract
	,Cl.Name SvcCluster
	,PT.Name SvcPlatform
	,SP.DateSvcVoided
	,SP.DateSvcSetToActive
	,CC.CurrencyCode
	,CC.Id CurrencyId
	,Coalesce(MonthlyCharge, 0) MonthlyCharge_LC
	,Coalesce(OneTimeCharge, 0) OneTimeCharge_LC
	,L.DateLiveForecast DateLocLiveForecast
	,SP.MasterOrderTypeId
FROM oss.ServiceProduct SP WITH (NOLOCK)
LEFT JOIN provision.VwTn T ON T.Id = SP.TN
LEFT JOIN company.VwLocation L ON L.[Loc Id] = SP.LocationId
LEFT JOIN company.VwAccount A ON A.[Ac Id] = L.AccountId
INNER JOIN enum.ServiceClass SC WITH (NOLOCK) ON SC.Id = SP.ServiceClassId
LEFT JOIN (
	SELECT getdate() thisdate
	) today ON 1 = 1
LEFT JOIN enum.Product P WITH (NOLOCK) ON P.Id = SP.ProductId
LEFT JOIN expinvoice.IncrIACP IA WITH (NOLOCK) ON IA.ServiceId = SP.ServiceId --and IA.ProdServiceClassId = P.ServiceClassId
LEFT JOIN enum.Cluster Cl WITH (NOLOCK) ON Cl.Id = SP.SvcClusterId
LEFT JOIN enum.PlatformType PT WITH (NOLOCK) ON PT.Id = Cl.PlatformTypeId
INNER JOIN enum.CurrencyCode CC WITH (NOLOCK) ON CC.Id = SP.CurrencyId
INNER JOIN ax.VwExchRatePeriod EX ON EX.CURRENCYCODE = CC.CurrencyCode
	AND today.thisdate >= EX.DateFrom
	AND today.thisdate < EX.DateTo
INNER JOIN (
	SELECT dbo.UfnLastBilledMonth() LastBilledMonth
	) Const ON 1 = 1
WHERE SP.ProductId IS NOT NULL -- reinstated Jan7,2004 because Cube can't handle null ProductId
	AND SP.serviceid IS NOT NULL
