
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description: Final Updates to Cost and Charge
--
-- Change Log:
-- ================================================================================================================================

create PROCEDURE cdr.UspFinalUpdateCostAndCharge 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge,  

-- unrated cost_30_6
update CallData.cdr.costAndCharge
set Cost_30_6 = CASE WHEN C.DurationMinutes < 0.5 THEN C.CostMinuteRate/2.0 
			   ELSE floor(((C.DurationMinutes*60) + 5)/6)*C.CostMinuteRate*0.1 
			   END
 from CallData.cdr.CostAndCharge C
where CostMinuteRate is not null and Cost_30_6 =0
-- (5346822 row(s) affected) ? time

-- need cost_60_60 for all
update CallData.cdr.costAndCharge
set	Cost_60_60 = CASE WHEN DurationMinutes < 1.0 THEN CostMinuteRate 
			   ELSE floor(DurationMinutes + 1)*CostMinuteRate 
			   END
where DurationMinutes is not null and CostMinuteRate is not null   
-- ((21179375 row(s) affected) took ? hours

-- Apr 4 -- (32834087 row(s) affected) 4 minutes

-- Cleanup idiosyncrasies for For the cube
update CallData.cdr.costAndCharge
	set 
		CostMinuteRate = CASE WHEN CostMinuteRate is null THEN 0 ELSE CostMinuteRate END,
		Cost_30_6 = CASE WHEN Cost_30_6 is null THEN 0 ELSE Cost_30_6 END,		
		ChargeMinuteRate = CASE WHEN ChargeMinuteRate is null THEN 0 ELSE ChargeMinuteRate END,
		ChargeInvoiced = CASE WHEN ChargeInvoiced is null THEN 0 ELSE ChargeInvoiced END
-- May 9 (35792719 row(s) affected) 5 minutes

-- Insert Bad TN not present in DimTN and in BadTN
truncate table cdr.BadTN;
insert into cdr.BadTN 
select FCC.TN as Id, 0 as CountryId, null TnTypeId, null AccountId, null LocationId, null ProfileId,
FCC.TN+'' as Label, null as TrunkGroupId
 from CallData.cdr.CostAndCharge FCC
left join FinanceBI.provision.Tn T on T.Id = FCC.TN 
--left join cdr.BadTN BT on BT.Id = FCC.TN 
where T.Id is null -- and BT.Id is null 
group by FCC.TN
-- May 9 (699969 row(s) affected) 35 sec
END
