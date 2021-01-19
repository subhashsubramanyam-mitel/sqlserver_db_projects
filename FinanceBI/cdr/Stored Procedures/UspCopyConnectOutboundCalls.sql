

-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2018-03-05
-- Description:	Copy Connect Outbound Calls with Charges
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspCopyConnectOutboundCalls] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge, cdr.Connect_CdrCurrentMonth_InProcess

insert into CallData.cdr.CostAndCharge
(CDRRegionTypeId, CDRServiceTypeId, CDRCallTypeId, CDRSource, BoblCdrId, 
	AccountId, LocationId, TN, OtherTN, StartTime, DurationMinutes, 
	CostRateTableId,ChargeRateId, ChargeMinuteRate, ChargeInvoiced)
	
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
	      PartyGroupId ConnectCdrId, -- unique id
	      A.Id AccountId,
	      L.Id LocationId,
	      CR.tn TN,
	      CASE WHEN TN = SourceTn THEN TargetTN ELSE SourceTn 
	       END OtherTN,
	      CR.TimeStart StartTime,
	      CR.duration/60.0 DurationMinutes,
	      6 as costRateTableId, -- cost not rated
		  null ChargeRateId,
		  (CR.ChargeAmount/100)/(CR.duration/60.0) as ChargeMinuteRate,
		  CR.ChargeAmount/100.0 ChargeInvoiced
	from CallData.cdr.Connect_CdrCurrentMonth_InProcess CR with (nolock)
		left join enum.CdrServiceType st on CR.servicetypeId = st.Id
		left join enum.CdrRouteType rt on CR.routetypeId = rt.Id
		left join enum.CdrCallType ct on CR.callTypeId = ct.Id 
		left join company.Account A on A.Id = CR.accountId
		left join company.Location L on L.Id = CR.locationId
		inner join provision.Tn T on T.Id = CR.tn 
		--left join rate.BossRate R on R.Id = CR.rateId
	where 
	 CR.duration > 0 
	and CR.servicetypeId = 2 -- outbound

END

