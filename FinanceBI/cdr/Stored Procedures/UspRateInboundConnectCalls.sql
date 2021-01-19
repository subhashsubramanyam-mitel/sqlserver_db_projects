
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2018-03-05
-- Description:	Rate Incoming calls including TollFree for Connect
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspRateInboundConnectCalls] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge, cdr.Connect_CdrCurrentMonth_InProcess

-- Incoming TollFree First

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
	      'Connect' CDRSource,
	      CR.PartyGroupId ConnectCdrId,
	      A.Id AccountId,
	      L.Id LocationId,
	      CR.tn TN,
	      CASE WHEN TN = SourceTn THEN TargetTN ELSE SourceTn 
	       END OtherTN,
	      CR.TimeStart StartTime,
	      CR.duration/60.0 DurationMinutes,
	      T.TrunkGroupId as M5DBTrunkGroupId, 
	      C.CarrierShortName,
	      CASE WHEN TF.Rate is not null then 3 ELSE 4 END as costRateTableId, 
	      CASE WHEN TF.Rate is not null THEN TF.Rate ELSE C.InboundTollfreeRate END CostMinuteRate,
	     null as Cost_30_6,
		  null ChargeRateId,
		  (CR.ChargeAmount/100)/(CR.duration/60.0) as ChargeMinuteRate,
		  CR.ChargeAmount/100 ChargeInvoiced
	from CallData.cdr.Connect_CdrCurrentMonth_InProcess CR with (nolock)
		left join enum.CdrServiceType st on CR.servicetypeId = st.Id
		left join enum.CdrRouteType rt on CR.routetypeId = rt.Id
		left join enum.CdrCallType ct on CR.callTypeId = ct.Id 
		left join company.Account A on A.Id = CR.accountId
		left join company.Location L on L.Id = CR.locationId
		inner join provision.Tn T on T.Id = CR.tn 
		left join provision.CircuitTrunkGroup TG on TG.Id = T.TrunkGroupId
		left join rate.Carrier C on C.CarrierAccountId = TG.CarrierAccountId
		left join rate.TollFree TF on (TF.NPA+TF.Nxx) = substring(CR.TargetTn,1,6)
		  and ((CR.routetypeId in (4,5) and TF.Region = 'INTER') OR
				(CR.routetypeId in (1,2,3) and TF.Region = 'INTRA'))
		--left join rate.BossRate R on R.Id = CR.rateId
	where 
	 CR.duration > 0 
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
	where CDRSource = 'Connect' and CDRCallTypeId = 3 
	
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
	      'Connect' CDRSource,
	      CR.PartyGroupId BoblCdrId,
	      A.Id AccountId,
	      L.Id LocationId,
	      CR.tn TN,
	      CASE WHEN TN = SourceTn THEN TargetTN ELSE SourceTn 
	       END OtherTN,
	      CR.TimeStart StartTime,
	      CR.duration/60.0 DurationMinutes,
	      T.TrunkGroupId as M5DBTrunkGroupId, 
	      C.CarrierShortName,
	      CASE WHEN C.InboundRate is not null then 4 ELSE 6 END as costRateTableId, 
	      C.InboundRate CostMinuteRate,
	      CASE WHEN CR.duration < 30 THEN C.InboundRate/2.0 
			   ELSE floor((CR.duration + 5)/6)*C.InboundRate*0.1
		  END Cost_30_6,
		  null ChargeRateId,
		  (CR.ChargeAmount/100)/(CR.duration/60.0) as ChargeMinuteRate,
		  CR.ChargeAmount/100 ChargeInvoiced
	from CallData.cdr.Connect_CdrCurrentMonth_InProcess CR with (nolock)
		left join enum.CDRserviceType st on CR.servicetypeId = st.Id
		left join enum.CDRroutetype rt on CR.routetypeId = rt.Id
		left join enum.CDRcalltype ct on CR.callTypeId = ct.Id 
		left join company.Account A on A.Id = CR.accountId
		left join company.Location L on L.Id = CR.locationId
		inner join provision.Tn T on T.Id = CR.tn 
		left join provision.CircuitTrunkGroup TG on TG.Id = T.TrunkGroupId
		left join rate.Carrier C on C.CarrierAccountId = TG.CarrierAccountId
		--left join rate.BossRate R on R.Id = CR.rateId
	where
	 CR.duration > 0 
	and CR.servicetypeId = 1
	and (CR.CallTypeId is null or CR.callTypeId <> 3) -- incoming tollfree will be separately costed
	--and C.CarrierId is  not null and T.TrunkGroupId is not null
	--and CR.IsProcessed = 0

END
