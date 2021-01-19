
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description:	Rate All Outbound calls from Teledynamics CDR (sansay)
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspRateTDXOutboundCalls] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge, cdr.SAN_InProcess, 
-- entire file executed in 30 min (June 5) to 90 minutes
insert into CallData.cdr.CostAndCharge
(CDRRegionTypeId, CDRServiceTypeId, CDRCallTypeId, CDRSource, TdxCdrId, 
	AccountId, LocationId, TN, OtherTN, StartTime, DurationMinutes, 
	TdxTrunkId,	CarrierShortName,
	CostRateTableId,CostUSDRateId, CostINTLRateId,CostMinuteRate, Cost_30_6, IsInNetwork)

SELECT -- top 10
		  CASE 
			WHEN CR.IS_US_DOMESTIC=0 THEN 5
			WHEN CR.IS_INTRA_STATE=0 THEN 4
			ELSE 3
			END CDRRegionTypeId, -- according to TDX
	      2 CDRServiceTypeId, -- outbound
	      CASE WHEN TF.TFP is not null then 3 ELSE 7 END as CDRCallTypeId, -- tollfree
	      'Tdx' CDRSource,
	      CR.id TdxcdrId,
	      --null AccountId, --
	      coalesce(SP.accountId, T.accountId) AccountId, 
	      --null LocationId, --
	      coalesce(SP.locationid, T.locationid) LocationId,
	      CR.CallingTN_Last10Digits TN, 
	      CR.E164_DIALED_NUMBER  OtherTN,
	      CR.CALL_BEGIN StartTime,
	      CR.CALL_DURATION/60.0 DurationMinutes,
	      CR.TERMT as TdxTrunkId,
	      TT.CarrierShortName,
		  null as CostRateTableId, 
		  null CostUSDRateId,
		  null CostINTLRateId,
		  0.0 as CostMinuteRate,
		  0.0 as Cost_30_6,
		  CASE WHEN T.Id is not null  and OT.Id is not null THEN 1 ELSE 0 END IsInNetwork

	from CallData.cdr.SAN_InProcess CR with (nolock)
		left join FinanceBI.provision.Tn T on T.Id = CR.CallingTN_Last10Digits -- calling number 
		left join FinanceBI.provision.Tn OT on OT.Id = CR.CalledTN_Last10Digits

		left join  (
			select SP.TN, MAX(SP.ServiceId) ServiceId
			from FinanceBI.oss.ServiceProduct SP
			where SP.ServiceClassId in (7,8,11,12,14,15,21,22,23)
				and SP.ServiceStatusId = 1 --active for now
			group by SP.TN
		) S on S.TN = T.Id
		
		left join FinanceBI.oss.ServiceProduct SP on SP.ServiceId = S.ServiceId 
		
		left join FinanceBI.cdr.TdxTrunk TT on TT.TdxTrunkId = CR.TERMT 
		-- Toll Free Outbound 
		left join (
			select '1800' TFP union select '1844' TFP union 
			select  '1855' TFP union select '1866'TFP union select '1877' TFP union 
			select '1888'TFP union 
			select '1900' TFP) TF on E164_DIALED_NUMBER like TF.TFP+'%' 
	where 
	 CR.CALL_DURATION > 0 
	--commit; 
	-- 	 ((10806267 row(s) affected))now in 3 minutes --May 7


-- International with area code	
	--begin transaction
	update CallData.cdr.CostAndCharge
		set CostRateTableId  = 2, CostINTLRateId = RI.RateId, CostMinuteRate = RI.Rate,
		Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN RI.Rate/2.0 
			   ELSE floor(((DurationMinutes*60) + 5)/6)*RI.Rate*0.1 
			   END
	--		 select top 10 * 
	from CallData.cdr.CostAndCharge FCC
	inner join CallData.cdr.SAN_InProcess CR on CR.ID = FCC.TdxCdrId 
	inner join Rate.CarrierInternational RI on RI.Carrier = FCC.CarrierShortName
			and Substring(FCC.OtherTN, 1, RI.PrefixLen) = RI.Prefix and RI.[Area Code] is not null
	where FCC.CDRsource = 'Tdx'
	and FCC.CDRRegionTypeId = 5 -- international 
	and FCC.CDRCallTypeId <> 3
	and FCC.CostRateTableId is null 
	--commit;
-- (356337 row(s) affected) 19 minutes

    
-- International without area code	
	--begin transaction
	update CallData.cdr.CostAndCharge
		set CostRateTableId  = 2, CostINTLRateId = RI.RateId, CostMinuteRate = RI.Rate,
		Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN RI.Rate/2.0 
			   ELSE floor(((DurationMinutes*60) + 5)/6)*RI.Rate*0.1 
			   END
	--select COUNT(1)
	from CallData.cdr.CostAndCharge FCC
	inner join CallData.cdr.SAN_InProcess CR on CR.ID = FCC.TdxCdrId 
	inner join Rate.CarrierInternational RI on RI.Carrier = FCC.CarrierShortName
			and Substring(FCC.OtherTN, 1, RI.PrefixLen) = RI.Prefix and RI.[Area Code] is null
	where FCC.CDRsource = 'Tdx'
	and FCC.CDRRegionTypeId = 5 -- international 
	and FCC.CDRCallTypeId <> 3
	and FCC.CostRateTableId is null 	
	--commit;
--- (35489 row(s) affected) 3.5 minute
	
-- USDomestic INTER that matches INTERNATIONAL
	--begin transaction
	update FCC
		set 
			-- these are INTER calls charged using International rate tables
			CostRateTableId  = 2, CostINTLRateId = RI.RateId, CostMinuteRate = RI.Rate,
			Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN RI.Rate/2.0 
				   ELSE floor(((DurationMinutes*60) + 5)/6)*RI.Rate*0.1 
				   END
	--select COUNT(1)
	from CallData.cdr.CostAndCharge FCC
	inner join CallData.cdr.SAN_InProcess CR on CR.ID = FCC.TdxCdrId 
	inner join Rate.CarrierInternational RI on RI.Carrier = FCC.CarrierShortName
			and Substring(FCC.OtherTN, 1, RI.PrefixLen) = RI.Prefix and RI.[Area Code] is not null
	where FCC.CDRsource = 'Tdx'
	and FCC.CDRRegionTypeId = 4 -- INTER 
	and FCC.CDRCallTypeId <> 3
	and FCC.CostRateTableId is null 
	--commit;
-- (0 row(s) affected) -- 8 minutes

-- USDomestic INTER remaining matching NPA-NXX-X
	--begin transaction
	update CallData.cdr.CostAndCharge
		set 
			CostRateTableId  = 1, CostUSDRateId = R.RateId, CostMinuteRate = R.CURRENT_RATE,
			Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN R.CURRENT_RATE /2.0 
				   ELSE floor(((DurationMinutes*60) + 5)/6)*R.CURRENT_RATE*0.1 
				   END
	--select COUNT(1)
	from CallData.cdr.CostAndCharge FCC
	inner join CallData.cdr.SAN_InProcess CR on CR.ID = FCC.TdxCdrId 
	inner join Rate.CarrierUSDomestic R on R.Carrier = FCC.CarrierShortName
		and R.Region = 'INTER' 
		and CR.NPA_NXX_X = R.DIAL_STRING 
		and R.OFFER_IS_ACTIVE = 'ACTIVE'		
	where FCC.CDRsource = 'Tdx'
	and FCC.CDRRegionTypeId = 4 -- INTER 
	and FCC.CDRCallTypeId <> 3
	and FCC.CostRateTableId is null 	
	--commit;
-- (2555544 row(s) affected, 14 minutes)
	
-- USDomestic INTER remaining matching NPA-NXX
	--begin transaction
	update CallData.cdr.CostAndCharge
		set 
			CostRateTableId  = 1, CostUSDRateId = R.RateId, CostMinuteRate = R.CURRENT_RATE,
			Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN R.CURRENT_RATE /2.0 
				   ELSE floor(((DurationMinutes*60) + 5)/6)*R.CURRENT_RATE*0.1 
				   END
	--select COUNT(1)
	from CallData.cdr.CostAndCharge FCC
	inner join CallData.cdr.SAN_InProcess CR on CR.ID = FCC.TdxCdrId 
	inner join Rate.CarrierUSDomestic R on R.Carrier = FCC.CarrierShortName
		and R.Region = 'INTER' 
		and CR.NPA_NXX = R.DIAL_STRING 
		and R.OFFER_IS_ACTIVE = 'ACTIVE'		
	where FCC.CDRsource = 'Tdx'
	and FCC.CDRRegionTypeId = 4 -- INTER 
	and FCC.CDRCallTypeId <> 3
	and FCC.CostRateTableId is null
	--commit; 	
	--(2460969 row(s) affected)   --- 5.5 minutes
	 
-- USDomestic INTRA remaining matching NPA-NXX-X
	--begin transaction
	update CallData.cdr.CostAndCharge
		set 
			CostRateTableId  = 1, CostUSDRateId = R.RateId, CostMinuteRate = R.CURRENT_RATE,
			Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN R.CURRENT_RATE /2.0 
				   ELSE floor(((DurationMinutes*60) + 5)/6)*R.CURRENT_RATE*0.1 
				   END
	--select COUNT(1)
	from CallData.cdr.CostAndCharge FCC
	inner join CallData.cdr.SAN_InProcess CR on CR.ID = FCC.TdxCdrId 
	inner join Rate.CarrierUSDomestic R on R.Carrier = FCC.CarrierShortName
		and R.Region = 'INTRA' 
		and CR.NPA_NXX_X = R.DIAL_STRING 
		and R.OFFER_IS_ACTIVE = 'ACTIVE'		
	where FCC.CDRsource = 'Tdx'
	and FCC.CDRRegionTypeId = 3 -- INTRA 
	and FCC.CDRCallTypeId <> 3
	and FCC.CostRateTableId is null 	
	--commit;
-- (2537558 row(s) affected) -- 2 minutes
	
-- USDomestic INTRA remaining matching NPA-NXX
	--begin transaction
	update CallData.cdr.CostAndCharge
		set 
			CostRateTableId  = 1, CostUSDRateId = R.RateId, CostMinuteRate = R.CURRENT_RATE,
			Cost_30_6 = CASE WHEN DurationMinutes < 0.5 THEN R.CURRENT_RATE /2.0 
				   ELSE floor(((DurationMinutes*60) + 5)/6)*R.CURRENT_RATE*0.1 
				   END
	--select COUNT(1)
	from CallData.cdr.CostAndCharge FCC
	inner join CallData.cdr.SAN_InProcess CR on CR.ID = FCC.TdxCdrId 
	inner join Rate.CarrierUSDomestic R on R.Carrier = FCC.CarrierShortName
		and R.Region = 'INTRA' 
		and CR.NPA_NXX = R.DIAL_STRING 
		and R.OFFER_IS_ACTIVE = 'ACTIVE'		
	where FCC.CDRsource = 'Tdx'
	and FCC.CDRRegionTypeId = 3 -- INTRA 
	and FCC.CDRCallTypeId <> 3
	and FCC.CostRateTableId is null 	
	--commit;
	--(2607958 row(s) affected) -- 2 minutes 
-- the update section after first international rates ran in 8 minutes

END
