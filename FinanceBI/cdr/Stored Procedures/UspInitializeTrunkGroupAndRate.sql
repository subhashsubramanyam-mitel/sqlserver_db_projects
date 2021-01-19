
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description: Preprocess Sansay CDRS from Teledynamics
--
-- Change Log:
-- ================================================================================================================================

create PROCEDURE cdr.UspInitializeTrunkGroupAndRate 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- Ensure that provision.CircuitTrunkGroup and rate.BossRate are recent

truncate table provision.CircuitTrunkGroup;
insert into provision.CircuitTrunkGroup
(Id, Name, OCN, CarrierAccountId, ColocationId, TrunkgroupStatusId, Description, IsSIP,
	IsOrigination, IsTermination, DateModified, DateCreated, ModifiedBy)
select Id, Name, OCN, CarrierAccountId, ColocationId, TrunkgroupStatusId, Description, IsSIP,
	IsOrigination, IsTermination, DateModified, DateCreated, ModifiedBy 
from M5DB.m5db.dbo.circuit_TrunkGroup;

truncate table rate.BossRate;
insert into  rate.BossRate
(id, rateGroupId, initialCharge, minSeconds, intervalCharge, intervalSecs, routetypeId,
	calltypeId, servicetypeId, cityId, stateId, lata, countryId, tnGroup, legacyId,
	score, DateModified, DateCreated, regionId, subRegion, ModifiedBy, sourceCountryId, IsDeleted)
select id, rateGroupId, initialCharge, minSeconds, intervalCharge, intervalSecs, routetypeId,
	calltypeId, servicetypeId, cityId, stateId, lata, countryId, tnGroup, legacyId,
	score, DateModified, DateCreated, regionId, subRegion, ModifiedBy, sourceCountryId, IsDeleted 
from M5DB.m5db.dbo.cdr_Rate;

END
