
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description:	Copy Bobl Outbound Calls with Charges
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspCopyBoblOutboundCalls] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge, cdr.CallReport_InProcess
-- (13373337 row(s) affected) in 4-14 minutes  June 5-- 
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
	      6 as costRateTableId, -- cost not rated
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
		left join rate.BossRate R on R.Id = CR.rateId
	where CR.internal = 0 
	and CR.duration > 0 
	and CR.servicetypeId = 2 -- outbound

END
