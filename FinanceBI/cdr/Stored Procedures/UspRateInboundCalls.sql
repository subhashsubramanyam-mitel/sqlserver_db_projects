
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description:	Rate Incoming calls including TollFree
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspRateInboundCalls] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge, cdr.CallReport_InProcess

-- Incoming TollFree First
-- (1229346 row(s) affected) in 2.5 minutes June 5
insert into CallData.cdr.CostAndCharge
(CDRRegionTypeId, CDRServiceTypeId, CDRCallTypeId, CDRSource, BoblCdrId, 
	AccountId, LocationId, TN, OtherTN, StartTime, DurationMinutes, 
	M5DBTrunkGroupId, CarrierShortName,
	CostRateTableId, CostMinuteRate, Cost_30_6, ChargeRateId, ChargeMinuteRate, ChargeInvoiced)
	
SELECT --top 100
        CASE  
			 WHEN rt.name = 'INTERNATIONAL'				  then 5
			 WHEN rt.name = 'INTERSTATE'                  then 4
			 WHEN rt.name = 'LOCAL'						  then 1
			 WHEN rt.name = 'INTRASTATE'				  then 3
			 WHEN rt.name = 'INTRALATA'					  then 2
			 ELSE 7
	      END CDRRegionTypeId,
	      CR.servicetypeId CDRServiceTypeId,
	      CASE WHEN CR.callTypeId is null THEN 7 ELSE CR.callTypeId END as  CDRCallTypeId,
	      'Bobl' CDRSource,
	      CR.id BoblCdrId,
	      A.Id AccountId,
	      L.Id LocationId,
	      CR.tn TN,
	      CASE WHEN CR.servicetypeId = 1 and Coalesce(CR.ani,'0') = '0' THEN CR.clid 
	           WHEN CR.servicetypeId = 1 and Coalesce(CR.ani,'0') <> '0' THEN CR.ani
	           ELSE CR.orig 
	       END OtherTN,
	      CR.start StartTime,
	      CR.duration/60.0 DurationMinutes,
	      T.TrunkGroupId as M5DBTrunkGroupId, 
	      C.CarrierShortName,
	      CASE WHEN TF.Rate is not null then 3 ELSE 4 END as costRateTableId, 
	      CASE WHEN TF.Rate is not null THEN TF.Rate ELSE C.InboundTollfreeRate END CostMinuteRate,
	     null as Cost_30_6,
		  CR.rateId ChargeRateId,
		  CASE WHEN R.IntervalSecs > 0 THEN R.intervalCharge*60/R.intervalSecs/100.0 
		    ELSE 0 END  as ChargeMinuteRate,
		  CR.charge/100 ChargeInvoiced
	from CallData.cdr.CallReport_InProcess CR with (nolock)
		left join enum.CdrServiceType st on CR.servicetypeId = st.Id
		left join enum.CdrRouteType rt on CR.routetypeId = rt.Id
		left join enum.CdrCallType ct on CR.callTypeId = ct.Id 
		left join company.Account A on A.LichenAccountId = CR.accountId
		left join company.Location L on L.LichenLocationId = CR.locationId
		inner join provision.Tn T on T.Id = CR.tn 
		left join provision.CircuitTrunkGroup TG on TG.Id = T.TrunkGroupId
		left join rate.Carrier C on C.CarrierAccountId = TG.CarrierAccountId
		left join rate.TollFree TF on (TF.NPA+TF.Nxx) = substring(CR.aniNpaNxx,1,6)
		  and ((CR.routetypeId in (4,5) and TF.Region = 'INTER') OR
				(CR.routetypeId in (1,2,3) and TF.Region = 'INTRA'))
		left join rate.BossRate R on R.Id = CR.rateId
	where CR.internal = 0 
	and CR.duration > 0 
	and CR.servicetypeId = 1
	and CR.callTypeId = 3 -- incoming tollfree 
	and C.CarrierId is  not null and T.TrunkGroupId is not null
	--and CR.IsProcessed = 0
--commit
-- (1052831 row(s) affected) 5 minutes

-- update the cost
	update CallData.cdr.CostAndCharge
	set	Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN CostMinuteRate/2.0 
				   ELSE floor(((DurationMinutes*60) + 5)/6)*CostMinuteRate*0.1 
				   END
	where CDRSource = 'Bobl' and CDRCallTypeId = 3 
	
-- other INCOMING next 
--(10749347 row(s) affected) in 3-12 minutes JUne 5
insert into CallData.cdr.CostAndCharge
(CDRRegionTypeId, CDRServiceTypeId, CDRCallTypeId, CDRSource, BoblCdrId, 
	AccountId, LocationId, TN, OtherTN, StartTime, DurationMinutes, 
	M5DBTrunkGroupId, CarrierShortName,
	CostRateTableId, CostMinuteRate, Cost_30_6, ChargeRateId, ChargeMinuteRate, ChargeInvoiced)
SELECT -- top 100
        CASE  
			 WHEN rt.name = 'INTERNATIONAL'				  then 5
			 WHEN rt.name = 'INTERSTATE'                  then 4
			 WHEN rt.name = 'LOCAL'						  then 1
			 WHEN rt.name = 'INTRASTATE'				  then 3
			 WHEN rt.name = 'INTRALATA'					  then 2
			 ELSE 7		
	      END CDRRegionTypeId,
	      CR.servicetypeId CDRServiceTypeId,
	      CASE WHEN CR.callTypeId is null THEN 7 ELSE CR.callTypeId END as  CDRCallTypeId,
	      'Bobl' CDRSource,
	      CR.id BoblCdrId,
	      A.Id AccountId,
	      L.Id LocationId,
	      CR.tn TN,
	      CASE WHEN CR.servicetypeId = 1 and Coalesce(CR.ani,'0') = '0' THEN CR.clid 
	           WHEN CR.servicetypeId = 1 and Coalesce(CR.ani,'0') <> '0' THEN CR.ani
	           ELSE CR.orig 
	       END OtherTN,
	      CR.start StartTime,
	      CR.duration/60.0 DurationMinutes,
	      T.TrunkGroupId as M5DBTrunkGroupId, 
	      C.CarrierShortName,
	      CASE WHEN C.InboundRate is not null then 4 ELSE 6 END as costRateTableId, 
	      C.InboundRate CostMinuteRate,
	      CASE WHEN CR.duration < 30 THEN C.InboundRate/2.0 
			   ELSE floor((CR.duration + 5)/6)*C.InboundRate*0.1
		  END Cost_30_6,
		  CR.rateId ChargeRateId,
		  CASE WHEN R.IntervalSecs > 0 THEN R.intervalCharge*60/R.intervalSecs/100.0 
		    ELSE 0 END  as ChargeMinuteRate,
		  CR.charge/100 ChargeInvoiced
	from CallData.cdr.CallReport_InProcess CR with (nolock)
		left join enum.CDRserviceType st on CR.servicetypeId = st.Id
		left join enum.CDRroutetype rt on CR.routetypeId = rt.Id
		left join enum.CDRcalltype ct on CR.callTypeId = ct.Id 
		left join company.Account A on A.LichenAccountId = CR.accountId
		left join company.Location L on L.LichenLocationId = CR.locationId
		inner join provision.Tn T on T.Id = CR.tn 
		left join provision.CircuitTrunkGroup TG on TG.Id = T.TrunkGroupId
		left join rate.Carrier C on C.CarrierAccountId = TG.CarrierAccountId
		left join rate.BossRate R on R.Id = CR.rateId
	where CR.internal = 0 
	and CR.duration > 0 
	and CR.servicetypeId = 1
	and (CR.CallTypeId is null or CR.callTypeId <> 3) -- incoming tollfree will be separately costed
	--and C.CarrierId is  not null and T.TrunkGroupId is not null
	--and CR.IsProcessed = 0

END
