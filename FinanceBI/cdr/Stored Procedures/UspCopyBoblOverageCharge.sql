
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description:	Copy from Bobl Overage Charge for Courtesy Calls
--
-- Change Log:
-- ================================================================================================================================

create PROCEDURE cdr.UspCopyBoblOverageCharge 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge,  cdr.overagecharge_InProcess

-- (101760 row(s) affected in 00:00:09 
insert into CallData.cdr.CostAndCharge
(CDRRegionTypeId, CDRServiceTypeId, CDRCallTypeId, CDRSource,  
	AccountId, LocationId, TN, OtherTN, StartTime, DurationMinutes, 
	ChargeMinuteRate, ChargeInvoiced)
	
SELECT --top 100
        CASE  -- map billing usage region to cdr usage region
        
			 WHEN UsageRegionId = 4 THEN 1 -- LOCAL
			 WHEN UsageRegionId  = 6 THEN 2 -- INTERLATA
			 WHEN UsageRegionId = 5 THEN 3 -- INTRASTATE
			 WHEN UsageRegionId = 3 THEN 4 -- INTERSTATE
			 WHEN UsageRegionId = 7 THEN 5 -- INTERNATIONAL
			 WHEN UsageRegionId = 1 THEN 1 -- DIR/INFO --> LOCAL (ok for now)
			 ELSE 7 -- Unknown (TollFree shouldn't come here)
	      END CDRRegionTypeId,
	      2 CDRServiceTypeId,
	      7 as  CDRCallTypeId,
	      'Overage' CDRSource,
	      A.Id AccountId,
	      L.Id LocationId,
	      CR.tn TN,
	      null OtherTN,
	      CR.start StartTime, -- at most one record per TN per day
	      0 DurationMinutes, -- don't double count minutes
		  0.0 ChargeMinuteRate,
		  CR.chargeInDollars ChargeInvoiced
	from CallData.cdr.overagecharge_InProcess CR with (nolock)
		left join company.Account A on A.LichenAccountId = CR.LichenAccountId
		left join company.Location L on L.LichenLocationId = CR.LichenAccountId
		inner join provision.Tn T on T.Id = CR.tn 
	where CR.chargeInDollars > 0
END
