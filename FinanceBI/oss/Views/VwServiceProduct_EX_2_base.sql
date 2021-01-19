











/*
 Change log: modifying to avoid too many joins in OLAP
 2018-05-25  changing definition of ToStartBilling to be strictly next month billing. Rest is FutureBilling. 
 2019-01-28  Tarak, added date svc live actual = date svc closed is equivalent to voiding, per Kelly

 */




CREATE VIEW [oss].[VwServiceProduct_EX_2_base]
AS
Select SP.*,
	 enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled) BookToBillDays,
	 enum.UfnBookToBillSegmentId(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled) BookToBillSegmentId,
	 CASE When MonthlyCharge is null THEN 3
         When MonthlyCharge=0.0 THEN 2
         ELSE 1
	END MRRValueCategoryId,
	MonthlyCharge*enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled) MRRtimesBookToBill
	,enum.[UfnSeatSizeSegmentId](L.[Loc NumProfiles]) [Loc SeatSizeSegmentId]
	,enum.[UfnSeatSizeSegmentId](L.[Loc NumProfiles]+L.[NumPendingProfiles]) [Loc PlannedSeatSizeSegmentId]
	,enum.[UfnSeatSizeSegmentId](A.[NumProfiles]) [Ac SeatSizeSegmentId]
	,enum.[UfnSeatSizeSegmentId](A.[NumProfiles]+ A.[NumPendingProfiles]) [Ac PlannedSeatSizeSegmentId]
	,A.AccountManagerId 
	,A.SfdcTerritoryId
	,O.DateCreated [Order Date Created]
	,O.SalesContractId

From (
	SELECT     SP.ServiceId, ProductId, LichenServiceId, SP.LichenPlanId,
		SP.ServiceClassId, ServiceStatusId, SP.AccountId, SP.InvoiceServiceGroupId, SP.LocationId, ServiceBundleId, 
		dbo.UfnRemoveUnprintableChar(SP.Name) Name, 
		IsAttachedToTN,
		CASE WHEN T.Id = '' THEN Null ELSE T.Id END as TN, 
		SP.InvoiceLabel, 
		SP.OrderId, OrderTypeId, WasInInitialOrder, 
		CASE WHEN OrderProjectManagerId is not null then OrderProjectManagerId ELSE OrderCreatedByPersonId END
		as OrderProjectManagerId, OrderCreatedByPersonId, OrderedById, OrderSalesPersonId,
		Coalesce(MonthlyCharge,0)  * EX.EXCHRATE / 100 MonthlyCharge,
		 Coalesce(OneTimeCharge,0)  * EX.EXCHRATE / 100 OneTimeCharge, 
		DateSvcCreated, DateSvcModified, 
		/*
		CASE 
			WHEN
				DateSvcLiveScheduled is not null  and DateSvcLiveScheduled >= dbo.UfnGetDatePart(GETDATE())
				THEN DateSvcLiveScheduled -- scheduled date from service gets first preference
			WHEN 
			SC.ServiceGroup not in ('Connectivity', 'Professional Services')
			and SC.LichenClassName not like '%shipping' 
			and L.DateLiveForecast is not null and L.DateLiveForecast > dbo.UfnGetDatePart(GETDATE())
				THEN L.DateLiveForecast
			ELSE DateSvcLiveScheduled
		END as DateSvcLiveScheduled,  */
		DateSvcLiveScheduled, -- 2014-05-08 as requested by Kerrin and Kelly, expose 'as is'
		DateSvcLiveActual, 
		DateSvcCloseOrdered,
		MonthSvcCloseOrdered,
		ClosedByPersonId,
		DateSvcClosed, 
		DateBillingValidFrom, DateBillingValidTo, 
		CASE WHEN Coalesce(SP.MonthSetupInvoiced,MonthMRRFirstInvoiced) = const.LastBilledMonth
			THEN 1 ELSE 0 END as IsBilledFirstTime,
		MonthSetupInvoiced, MonthLastInvoiced, 
		MonthMRRFirstInvoiced, MonthMRRLastInvoiced, DateMRRInvoicedTo, MonthCreditIssued, 
		DateCreditedFrom, DateCreditedTo, 
		CreatedByPersonId, ModifiedByPersonId,
		CASE -- order of when clauses is IMPORTANT
			WHEN SP.ServiceStatusId in (25,26) THEN 'Voided'
			WHEN SP.ServiceStatusId = 14 THEN 'Moved'
			WHEN IA.Category is not null and IA.Category = 'Install' 
				THEN 'ToStartBilling'
			WHEN IA.Category is not null and IA.Category in ('PriceDecr', 'PriceIncr','ChangeProductFrom','ChangeProductTo')
				THEN 'BillingChanged'
			WHEN IA.Category is not null and IA.Category in ('NoChange')
				THEN 'Billing'
			WHEN SP.MonthMRRLastInvoiced is not null
						and SP.MonthMRRLastInvoiced = const.LastBilledMonth
						and SP.DateBillingValidFrom is not null and SP.DateBillingValidTo is null
				THEN 'Billing'
			WHEN SP.DateSvcClosed = SP.DateSvcLiveActual 
				THEN 'Voided' -- Jan 28, 2019 , equivalent to voiding, per Kelly
			WHEN SP.MonthMRRLastInvoiced is null and SP.MonthSetupInvoiced is not null
				THEN 'BilledSetup'
			WHEN SP.ServiceStatusId in (5,17,32) 
				-- and dbo.UfnGreatestDate(SP.MonthMRRLastInvoiced, SP.DateBillingValidTo, SP.DateSvcClosed, null,null,null)
				--	 < const.LastBilledMonth -- before last billig cycle
				-- experimenting below (Aug 3)
				and (SP.MonthMRRLastInvoiced < const.LastBilledMonth
				--	and SP.DateMRRInvoicedTo < DateAdd(month, +2, const.LastBilledMonth)
					 --OR SP.DateBillingValidTo < const.LastBilledMonth
					 OR SP.MonthMRRFirstInvoiced is null -- Setup only services that are closed
					 --OR SP.DateBillingValidFrom is null
					 --OR SP.DateSvcClosed < const.LastBilledMonth
					 ) 
				THEN 'Closed'
			WHEN SP.ServicestatusId in (5, 17, 32) and MonthMRRLastInvoiced is not null 
					and DateMRRInvoicedTo >= DateAdd(month, +2, const.LastBilledMonth)
				THEN 'InClosing'
			WHEN SP.ServicestatusId = 1 
				and SP.DateBillingValidFrom is  not null 
				and SP.DateBillingValidTo is null 
				and SP.DateBillingValidFrom >= DateAdd(month, -2, const.LastBilledMonth)
				THEN 
					CASE WHEN  SP.DateBillingValidFrom >= DateAdd(month, +1, const.LastBilledMonth) THEN 'FutureBilling'  -- previously ToStartBilling
						WHEN  SP.DateBillingValidFrom >= DateAdd(month, -2, const.LastBilledMonth) THEN 'ToStartBilling'
					END
			WHEN SP.MonthSetupInvoiced is not null 
				and SP.MonthlyCharge = 0.0 THEN 'LingeringSetup'
			WHEN SP.ServicestatusId = 1 
				and SP.DateBillingValidFrom is  not null 
				and SP.DateBillingValidFrom < DateAdd(month, -2, const.LastBilledMonth)
				and SP.DateBillingValidTo is null THEN 'LingeringUnbilled'
			WHEN SP.ServiceStatusId not in (1,5,14,17) and 
					((SP.DateSvcLiveScheduled is not null
						and SP.DateSvcLiveScheduled >= dbo.UfnGetDatePart(GETDATE()))  -- if passed, it becomes unscheduled
					 OR L.DateLiveForecast is not null
						and L.DateLiveForecast >= dbo.UfnGetDatePart(GETDATE()) )
				 THEN 'Forecasted'	
			WHEN SP.ServiceStatusId not in (1,5,14,17) 
				 and Coalesce(SP.MonthSetupInvoiced,MonthMRRFirstInvoiced) IS null THEN 'Unscheduled'
			ELSE 'Limbo'
		END as BillingStage,
		DataIssueId,
		L.ConnectivityType [Loc Connecticitytype],
		L.InvoiceGroupId [Loc InvoiceGroupId],
		A.FirstNPS [Ac FirstNps], A.LastNPS [Ac LastNps], A.[DateFirstServiceLive] [Ac DateFirstServiceLive],
		A.DateFirstInvoiced [Ac DateFirstInvoiced], A.PartnerId [Ac PartnerId], 
		DATEDIFF(day, sp.DateSvcCreated, today.thisdate) NumLifeDays,
		enum.[UfnLifeDaysSegmentId](sp.DateSvcCreated,today.thisdate) LifeDaysSegmentId,
		CASE WHEN Coalesce(MonthlyCharge,0.0) <>0.0 THEN 'NonZero' ELSE 'Zero' END IsMRRZero, 
		CASE WHEN Coalesce(OneTimeCharge,0) <>0.0 THEN 'NonZero' ELSE 'Zero' END IsNRCZero,
		SP.CircuitStatusId,
		[enum].[UfnAvgLifeDaysSegmentId](DATEDIFF(day, sp.DateSvcCreated, today.thisdate)) LifeDaysNewSegmentId,
		SP.InFirstContract,
		Cl.Name SvcCluster,
		PT.Name SvcPlatform,
		SP.DateSvcVoided,
		SP.DateSvcSetToActive,
		CC.CurrencyCode,
		CC.Id CurrencyId, 
		Coalesce(MonthlyCharge,0)  MonthlyCharge_LC,
		 Coalesce(OneTimeCharge,0) OneTimeCharge_LC ,
		 L.DateLiveForecast DateLocLiveForecast,
		 SP.MasterOrderTypeId
	FROM         oss.ServiceProduct SP
	left join provision.VwTn T on T.Id = SP.TN
	left join company.VwLocation L on L.[Loc Id] = SP.LocationId
	left join company.VwAccount A on A.[Ac Id] = L.AccountId
	inner join enum.ServiceClass SC on SC.Id = SP.ServiceClassId
	left join (select getdate() thisdate)  today on 1=1
	left join enum.Product P on P.Id = SP.ProductId
	left join expinvoice.IncrIACP IA on IA.ServiceId = SP.ServiceId --and IA.ProdServiceClassId = P.ServiceClassId
	left join enum.Cluster Cl on Cl.Id = SP.SvcClusterId
	left join enum.PlatformType PT on PT.Id = Cl.PlatformTypeId
	inner join    enum.CurrencyCode CC on CC.Id = SP.CurrencyId
	inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and today.thisdate >= EX.DateFrom and today.thisdate < EX.DateTo
	inner join (select dbo.UfnLastBilledMonth() LastBilledMonth) Const on 1=1

	where 
	 SP.ProductId is not null and -- reinstated Jan7,2004 because Cube can't handle null ProductId
	SP.serviceid is not null

) SP
left join company.VwLocation L on L.[Loc Id] = SP.LocationId
left join company.VwAccount A on A.[Ac Id] = SP.AccountId
left join oss.VwOrder O on O.OrderId = SP.OrderId



















