
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description: Compute Summary for Usage Cube
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspComputeSummaryForUsageCube] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME Table cdr.CallReport_InProcess
-- took about 8 minutes

DECLARE @ServiceMonth date = DateAdd(month, -1, @InvoiceMonth); 

delete from usage.TNSummary where ServiceMonth = @ServiceMonth;

insert into usage.TNSummary
(ServiceMonth, AccountId, LichenAccountId, LocationId, LichenLocationId, Tn, CdrCallTypeId,
CdrServiceTypeId, CdrRegionTypeId, NumCalls, Minutes, Charge) 
select --top 100
  @ServiceMonth ServiceMonth,
  A.Id AccountId,
  CR.accountid LichenAccountid,
  L.Id LocationId,
  CR.locationid LichenLocationId,
  Tn,
  calltypeId CdrCallTypeid,
  servicetypeid CdrServiceTypeId,
  routetypeid CdrRegionTypeId,
  COUNT(1) NumCalls,
  SUM(duration/60.0) Minutes,
  SUM(charge/100.0) Charge
 
  from  CallData.cdr.CallReport_InProcess CR
  left join company.Account A on A.LichenAccountId = CR.Accountid
  left join company.Location L on L.LichenLocationId = CR.LocationId

where CR.internal=0 and CR.start >= @ServiceMonth and CR.start < @InvoiceMonth
groUP by A.Id, CR.accountId, L.Id, CR.locationId, tn, servicetypeid, routetypeid, calltypeiD
-- 


 --- Special calls

 delete from FinanceBI.cdr.SpecialCalls where ServiceMonth = @ServiceMonth;

 insert  into FinanceBI.cdr.SpecialCalls
 (ServiceMonth, Id, AccountId, LichenAccountId, LocationId, LocationName, LichenLocationId,
  Tn, ProfileId, ProfileName, LabelName, DialedTN, ANICity,ANIState,CdrCallTypeid, CdrServiceTypeId,
  CdrRegionTypeId,   NumCalls, StartTime, EndTime, [Minutes], Charge, RateId
  )
 select 
  @ServiceMonth ServiceMonth,
  TU.Id,
  A.Id AccountId,
  TU.AccountId LichenAccountid,
  L.Id LocationId,
   TU.LocationName,
  TU.LocationId LichenLocationId,
  TU.Tn,
  TU.ProfileId, 
  TU.ProfileName,
  TU.LabelName,
  TU.orig DialedTN,
 TU.aniCity ANICity,
 TU.aniState ANIState,
  TU.CalltypeId CdrCallTypeid,
  TU.servicetypeid CdrServiceTypeId,
  TU.routetypeid CdrRegionTypeId,
  1 NumCalls,
  TU.start StartTime,
  TU.endTs EndTime,
  TU.duration/60.0 [Minutes], 
  TU.charge/100.0 Charge,
  TU.rateId RateId
  from (
		select @ServiceMonth  ServiceMonth, * from CallData.cdr.CallReport_InProcess 
		where callTypeId is not null and callTypeId <> 3 
		) TU
  left join company.Account A on A.LichenAccountId = TU.Accountid
  left join company.Location L on L.LichenLocationId = Tu.LocationId
  where TU.ServiceMonth = @ServiceMonth

--(8121 row(s) affected)


-- Sync TN-wise Scribe Usage records from M5DB

delete from FinanceBI.usage.TNScribeSummary where ServiceMonth = @ServiceMonth

declare @query varchar(max);
set @query = 'insert into financebi.usage.TNScribeSummary
				select *
				from OpenQuery(m5db, ''select * from 
						Billing.dbo.[UfnScribeUsageForServiceMonth](''''' + Convert(varchar(12),@ServiceMonth, 102) +
						''''','''''+ Convert(varchar(12),@InvoiceMonth, 102) +''''');
	'') foo';
	
exec (@query);

-- Prepare Usage records for PSB Audit
Exec [audit].[UspPrepareMonthlyUsageForPSBAudit]
-- (1321372 row(s) affected) about 1.5 minutes

END
