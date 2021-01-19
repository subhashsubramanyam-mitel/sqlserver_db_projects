
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-12-16, modified 2015-03-25
-- Description:	Compute Revenue, Cost and Profitability Stats by Account
-- =============================================
Create PROCEDURE [rollup].[UspComputeProfitability_backup_Jan28]
	@svcMonth Datetime
AS
BEGIN

Declare @PrevBillingMonth Datetime = DateAdd(month, -1, @svcMonth); -- MRR is billed in previous month
Declare @NextBillingMonth Datetime = DateAdd(month, 1, @svcMonth); -- Usage is billed in the following month
Declare @3mBegin Datetime = DateAdd(Month, -2, @svcMonth); -- 3 months start is two months behind first of current month
Declare @3mEnd Datetime =	DateAdd(Second, -1, 
								 cast(@NextBillingMonth as datetime)); --3 months end at a second before next month 

print 'Revenue ...';

-- REVENUE
-- truncate table rollup.AccountRevenue
delete from rollup.AccountRevenue where SvcMonth = @svcMonth;

-- Product MRR
insert into rollup.AccountRevenue
select AccountId, @svcMonth as SvcMonth, P.RevenueComponentId, SUM(Quantity) Quantity, Sum(MRR) Revenue
		,AP.ProductId
from rollup.UfnMRRByAccountProduct(@PrevBillingMonth) AP -- MRR is billed in prev month
left join enum.Product P on P.Id = AP.ProductId 
where P.RevenueComponentId <> 111 -- ignore 'Other' coming from Professional Services, etc.
group by AccountId,  AP.ProductId, P.RevenueComponentId

-- Usage MRR
insert into rollup.AccountRevenue
select AccountId, @svcMonth as  SvcMonth,  103 as RevenueComponentId, 1 Quantity, Sum(Usage) Revenue
		,AP.ProductId
from rollup.UfnUsageByAccountProduct(@NextBillingMonth) AP -- Usage is billed after usage is consumed
group by AccountId, AP.ProductId

-- manual credit
insert into rollup.AccountRevenue
select AccountId, @svcMonth as  SvcMonth, 106 as RevenueComponentId, 1 Quantity, Sum(Credit) Revenue
		, null -- null Product Id for credits
from rollup.UfnManualCreditByAccount(@NextBillingMonth) AP -- Manual credits are applied in next month
group by AccountId


-- Account and Total Stats
print 'TmpAccountStats ...';
truncate table rollup.TmpAccountStats;

-- insert all accounts
insert into rollup.TmpAccountStats 
(AccountId, ClusterId,  SvcMonth) 
select Id, PrimaryClusterId, @svcMonth 
from company.Account

-- Update base stats
update TA set
	NumCircuits = AP.NumT1s,
	NumProfiles = AP.NumProfiles,
	NumManagedProfiles =AP.NumManagedProfiles,
	NumMonthsInvoiced = DateDiff(month, AA.DateFirstInvoiced, @NextBillingMonth)
from rollup.TmpAccountStats TA
inner join (
	Select 
		AccountId,
		SUM(CASE WHEN P.[Prod Category] = 'Profiles' THEN Quantity ELSE 0 END) NumProfiles,
		SUM(CASE WHEN P.[Prod Category] = 'Profiles' 
				and P.[Class Leaf Name] like 'mgdprofile%' THEN Quantity ELSE 0 END) NumManagedProfiles,
		SUM(CASE WHEN P.[Prod Category] = 'Access' 
				and P.[Class Leaf Name] = 't1' THEN Quantity ELSE 0 END) NumT1s
	From rollup.UfnMRRByAccountProduct(@PrevBillingMonth) AP
	inner join enum.VwProduct P on P.[Prod Id] = AP.ProductId
	group by AccountId
) AP on AP.AccountId = TA.AccountId 
inner join company.AccountAttr AA on AA.AccountId = TA.AccountId

where TA. SvcMonth = @svcMonth

-- NOC, Support
-- declare @svcMonth date = '2014-11-01';
	update TA	SET
		NumSupportCasesRegular = coalesce(SS.SupReg,0)/3,
		NumNocCasesRegular = coalesce(SS.NSupReg,0)/3
	from rollup.TmpAccountStats TA
	inner join 
		(select M5dbAccountId AccountId, 
			SUM(case when Category in ( 'Support', 'Support/NOC')  THEN 1 ELSE 0 END) SupReg,
			SUM(case when Category in ( 'NOC', 'Support/NOC')  THEN 1 ELSE 0 END) NSupReg
		 from sfdc.VwSkyCase SC

	where SC.SfdcCreateDate  between @3mBegin and @3mEnd
		 and M5dbAccountId is not null  -- valid account
		  and CaseType = 'Other'  -- EXCLUDES Add Serverice and Outage
		 group by M5dbAccountId
		 ) SS on SS.AccountId = TA.AccountId


-- update derived stats
update TA set
	SeatSizeSegmentId = enum.UfnSeatSizeSegmentId(NumProfiles),
	ProfilePrice = CASE WHEN NumManagedProfiles > 0 THEN AP.ManagedProfilesMRR/NumManagedProfiles ELSE 0.0 END,
	IsOlderThan3Months = CASE WHEN NumMonthsInvoiced > 3 THEN 1 ELSE 0 END,
	HasAccess = CASE WHEN NumCircuits > 0 THEN 1 ELSE 0 END
from rollup.TmpAccountStats TA
inner join (
	Select 
		AccountId,
		SUM(CASE WHEN P.[Prod Category] = 'Profiles' 
				and P.[Class Leaf Name] like 'mgdprofile%' THEN MRR ELSE 0 END) ManagedProfilesMRR
	From rollup.UfnMRRByAccountProduct(@svcMonth) AP
	inner join enum.VwProduct P on P.[Prod Id] = AP.ProductId
	group by AccountId
) AP on AP.AccountId = TA.AccountId 
where TA. SvcMonth = @svcMonth

-- Common Stats
print 'CommonStats ...';
delete from rollup.CommonStats where  SvcMonth = @svcMonth;

Insert into rollup.CommonStats ( SvcMonth) values (@svcMonth)
update CS
	set NumProfiles = SA.NumProfiles,
		NumCircuits = SA.NumCircuits
	from  rollup.CommonStats CS
	inner join (
		select Sum(NumProfiles) NumProfiles, Sum(NumCircuits) NumCircuits
		from rollup.TmpAccountStats Where  SvcMonth = @svcMonth
		) SA on 1=1
	where CS.SvcMonth = @svcMonth;

Update CS
	set 
		NumSupportCasesRegular = coalesce(SS.NumSupportCasesRegular,0)/3,
		NumSupportCasesOutage = coalesce(SS.NumSupportCasesOutage,0)/3,
		NumSupportCasesNoAccount = coalesce(SS.NumSupportCasesNoAccount,0)/3,
		NumNocCasesTotal = coalesce(SS.NumNocCasesTotal,0)/3,
		NumNocCasesOutage = coalesce(SS.NumNocCasesOutage,0)/3,
		NumNocCasesNoAccount = coalesce(SS.NumNocCasesNoAccount,0)/3
from  rollup.CommonStats CS
inner join 
		(select 
			 SUM(CASE WHEN SC.Category in( 'Support', 'Support/NOC') and SC.HasAccount = 1
						and NOT (CaseOwnerRole like '%NOC%' and CaseOrigin in ('Outage Email', 'Nagios')) THEN 1 ELSE 0 END) NumSupportCasesRegular,
 			 SUM(CASE WHEN SC.Category in( 'Support', 'Support/NOC') and SC.HasAccount = 1
						and SC.CaseType = 'Outage' THEN 1 ELSE 0 END) NumSupportCasesOutage,		 
 			 SUM(CASE WHEN SC.Category in( 'Support', 'Support/NOC')  and SC.HasAccount = 0 
						and SC.CaseType <> 'Add Service' THEN 1 ELSE 0 END) NumSupportCasesNoAccount,		 
			 SUM(CASE WHEN SC.CaseOwnerRole like '%NOC%' THEN 1 ELSE 0 END) NumNocCasesTotal,
			 SUM(CASE WHEN SC.Category in( 'NOC', 'Support/NOC') and SC.HasAccount = 1
						and SC.CaseType = 'Outage' THEN 1 ELSE 0 END) NumNocCasesOutage,	
			 SUM(CASE WHEN SC.Category in( 'NOC', 'Support/NOC')  and SC.HasAccount = 0 
						and SC.CaseType <> 'Add Service' THEN 1 ELSE 0 END) NumNocCasesNoAccount
		from sfdc.VwSkyCase SC
		 where SC.SfdcCreateDate  between @3mBegin and @3mEnd
		  -- and (CaseownerRole like  '%sky Support%' or CaseOwnerRole like '%NOC%') already covered
			) SS on 1=1
where CS.SvcMonth = @svcMonth;

-- Costs from Phoenix
With Phoenix as (
	select PH.CostCategory, SUM(PH.Cost) Cost, sum(PH.usage) Usage  from rollup.UfnHighLevelCost (@svcMonth) PH
	group by PH.CostCategory
) 
update CS
	set 
		CostProfileInfra = - ([Profile].Cost + [Profile].Usage)
		,CostAccessInfra = - ([Access].Cost + [Access].Usage)

from rollup.CommonStats CS
inner join Phoenix Access on Access.CostCategory = 'Access Infrastructure Costs'
inner join Phoenix [Profile] on [Profile].CostCategory = 'Profile Infrastructure Costs'

where  SvcMonth = @svcMonth;

--  Costs from AX Ledger Departments
with CSE as (
	select FCC.FixedCostCategoryId, SUM(Fcc.Cost)/3 amt, count(1)/3 cnt  -- already negative costs
	from rollup.FixedCommonCost FCC
	where FCC.SvcMonth between @3mBegin and @3mEnd
	group by FCC.FixedCostCategoryId
) 
update CS
	set		
		CostPerSupportCase = case when NumSupportCasesRegular > 0 then Support.amt / NumSupportCasesRegular else 0.0 end
		,CostPerNocSupportCase = case when NumNocCasesTotal > 0 then  NocSupport.amt / NumNocCasesTotal else 0.0 end
		,CostPerNocConnectivityMonitoringCase =case when NumCircuits > 0 then  NocMonitoring.amt / NumCircuits else 0.0 end
		,CostPerProfile = case when NumProfiles > 0 then ( Networks.amt + NocProfiles.amt + Depreciation.amt)/NumProfiles else 0.0 end
		,CostProfileInfraPerProfile = case when NumProfiles > 0 then CostProfileInfra/NumProfiles else 0.0 end
		,CostAccessInfraPerCircuit = case when NumCircuits > 0 then  CostAccessInfra/NumCircuits else 0.0 end
		,CostAcctMgmtPerProfile = case when NumProfiles > 0 then  AcctMgmt.amt/NumProfiles else 0.0 end
from rollup.CommonStats CS
left join CSE AcctMgmt on AcctMgmt.FixedCostCategoryId = 1
left join CSE Networks on Networks.FixedCostCategoryId = 2
left join CSE NocSupport on NocSupport.FixedCostCategoryId = 3
left join CSE NocMonitoring on NocMonitoring.FixedCostCategoryId = 4
left join CSE NocProfiles on NocProfiles.FixedCostCategoryId = 5
left join CSE NocConnectivity on NocConnectivity.FixedCostCategoryId = 6
left join CSE Support on Support.FixedCostCategoryId =7
left join CSE Depreciation on Depreciation.FixedCostCategoryId = 8
where  SvcMonth = @svcMonth

-- Provfile Ovhd
update CS
	set 
		CostProfileOvhd =  CostPerProfile*NumProfiles 
				+ (NumSupportCasesOutage+NumSupportCasesNoAccount) * CostPerSupportCase
				+ (NumNocCasesOutage+NumNocCasesNoAccount) * CostPerNocSupportCase
from rollup.CommonStats CS
where  SvcMonth = @svcMonth;
update CS
	set 
		CostProfileOvhdPerProfile = case when NumProfiles > 0 then CostProfileOvhd/NumProfiles  else 0.0 end
from rollup.CommonStats CS
where  SvcMonth = @svcMonth;
-- BEGIN Account specific Costs HERE
print 'Costs deleted, 201 and 202 ...';
delete from rollup.AccountCost where  SvcMonth = @svcMonth ;

--201	Profile Infra	Profile/Usage	FCC+Seats
--202	Profile Ovhd	Profile/Usage	FCC+Seats
--214   AcccountMgmt    OpEx            FCC+Seats

Insert into rollup.AccountCost
select AccountId, @svcMonth, 
	PCT.CostType CostComponentId,
	CASE WHEN PCT.CostType = 201 THEN  Com.CostProfileInfraPerProfile 
		WHEN PCT.CostType = 202 THEN Com.CostProfileOvhdPerProfile 
		WHEN PCT.CostType = 214 THEN Com.CostAcctMgmtPerProfile 
		ELSE 0
		END 
			* A.NumProfiles  Cost 
from rollup.TmpAccountStats A
inner join (select * from rollup.CommonStats where  SvcMonth = @svcMonth) Com on 1=1
inner join (select 201 CostType union select 202 CostType union select 214 CostType) PCT on 1=1
where A.NumProfiles > 0


-- Non Pivot fixed Cost NPFC
print 'Costs 203, 210, 213 ...';
--203	Rental Phone	Profile/Usage	NPFC
--210	Access Ovhd	Access	NPFC
--213	Other Lineitem Cost	Other	NPFC

Insert into rollup.AccountCost
Select NPFC.AccountId, @svcMonth, NT.NPFCtype, 
	CASE when NT.NPFCtype = 203 THEN NPFC.RentalNPFC
		 when NT.NPFCtype = 210 THEN NPFC.AccessNPFC
		 WHEN NT.NPFCtype = 213 THEN NPFC.otherNPFC
		 ELSE 0.0
		 END Cost
from (
	select AccountId, 
	-1 * SUM (Case WHEN [Prod Category] = 'Other' THEN NPFC ELSE 0.0 END +
				Case WHEN [Prod Category] = 'Hardware-Rental' THEN NPFC ELSE 0.0 END) RentalNPFC,
	-1 * SUM (Case WHEN [Prod Category] = 'Access' THEN NPFC ELSE 0.0 END +
				Case WHEN [Prod Category] = 'Applications' and P.[Class Leaf Name]='Internet'
					 THEN NPFC ELSE 0.0 END) AccessNPFC,
	-1 * SUM (AP.NPFC - Case WHEN [Prod Category] = 'Access' THEN NPFC ELSE 0.0 END 
				-	Case WHEN [Prod Category] = 'Applications' and P.[Class Leaf Name]='Internet' THEN NPFC ELSE 0.0 END
				-	Case WHEN [Prod Category] = 'Other' THEN NPFC ELSE 0.0 END
				-	Case WHEN [Prod Category] = 'Hardware-Rental' THEN NPFC ELSE 0.0 END
				) otherNPFC
	from rollup.UfnMRRByAccountProduct (@svcMonth) AP
	inner join enum.VwProduct P on P.[Prod Id] = AP.ProductId
	Where NPFC > 0
	group by AccountId
) NPFC 
inner join (select 203 NPFCtype union select 210 union select 213) NT on 1=1

print 'Costs  204 and 208 ...';
--204	Vendor	Profile/Usage	Phoenix
--208	Access Direct	Access	Phoenix

Insert into rollup.AccountCost
select VC.AccountId,@svcMonth, VCT.VendorCostType,
	CASE WHEN VCT.VendorCostType = 204 THEN VC.ProfileCost ELSE VC.AccessCost END Cost
from (
	select AccountId, -(V.[TN Cost] + V.[Usage Cost] +V.[Other Cost]) as ProfileCost,
		-V.[Access Services Cost] AccessCost
	from rollup.UfnCostByAccount(@svcMonth) V  -- Phoenix vendor bills arrived during SvcMonth
	where ([TN Cost] + [Usage Cost] +[Other Cost]) <> 0.0
) VC
inner join (select 204 VendorCostType union select 208 ) VCT on 1=1

print 'Costs  205 and 206...';
--205	Support	Profile/Usage	FCC+Cases
--206	NOC Support	Profile/Usage	FCC+Cases

Insert into rollup.AccountCost
select SN.AccountId, @svcMonth, SNT.SNType CostComponentId,
	CASE WHEN SNT.SNType = 205 THEN SN.CostSupport ELSE SN.CostNoc END Cost
from (
	select M5dbAccountId AccountId, 
	SUM(case when Category in ( 'Support', 'Support/NOC') THEN 1 ELSE 0 END) * Max(Com.CostPerSupportCase)/3 CostSupport,
	SUM(case when category in ( 'NOC', 'Support/NOC') THEN 1 ELSE 0 END) * Max(Com.CostPerNocSupportCase)/3 CostNoc
	 from sfdc.VwSkyCase SC
	 inner join (select * from rollup.CommonStats where  SvcMonth = @svcMonth) Com on 1=1
	 where SC.SfdcCreateDate between @3mBegin and @3mEnd
	  	 and M5dbAccountId is not null
	 group by M5dbAccountId
 ) SN
 inner join (select 205 SNType union select 206 ) SNT on 1=1

print 'Costs  209 ...';
--209	Access Infra	Access	FCC+Circuits
Insert into rollup.AccountCost
select AccountId, 
	@svcMonth, 209, (Com.CostAccessInfraPerCircuit * A.NumCircuits) Cost
from rollup.TmpAccountStats A
inner join (select * from rollup.CommonStats where  SvcMonth = @svcMonth
	) Com on 1=1
where A.NumCircuits > 0

print 'Costs 207, 211 and 212 ...';
-- 207	Profile/Usge Commission	Profile/Usage	Rev+PC (Rev component 1,2, 3)
--211	Access Commission	Access	Rev+PC (Rev component 4)
--212	Other Commission	Other	Rev+PC (Rev Component 5,  7)

Insert into rollup.AccountCost
select AR.AccountId, @svcMonth,
	   207 as CostComponentId,
	   -1 * SUM(AR.Revenue) * coalesce(max(PR.CommissionRate), 0) Cost
from rollup.AccountRevenue AR
left join commission.VwAcRate PR on PR.AccountId = AR.AccountId 
where AR. SvcMonth = @svcMonth and AR.RevenueComponentId in (101,102,103) and AR.Revenue > 0
group by AR.AccountId
union all
select AR.AccountId, @svcMonth,
	   211 as CostComponentId,
	   -1 * SUM(AR.Revenue) * coalesce(max(PR.CommissionRate), 0) Cost
from rollup.AccountRevenue AR
left join commission.VwAcRate PR on PR.AccountId = AR.AccountId 
where AR. SvcMonth = @svcMonth and AR.RevenueComponentId in (104) and AR.Revenue > 0
group by AR.AccountId
union all
select AR.AccountId,@svcMonth,
	   212 as CostComponentId,
	   -1 * SUM(AR.Revenue) * coalesce(max(PR.CommissionRate), 0) Cost
from rollup.AccountRevenue AR
left join commission.VwAcRate PR on PR.AccountId = AR.AccountId 
where AR. SvcMonth = @svcMonth and AR.RevenueComponentId in (105,107) and AR.Revenue > 0
group by AR.AccountId

-- Totaling Account Revenues and Costs
update TAS 	set 
	ProfileRevenue = SA.ProfileRevenue,
	AccessRevenue = SA.AccessRevenue,
	TotalRevenue = SA.TotalRevenue
from rollup.TmpAccountStats TAS
inner join (
Select AccountId, SvcMonth, 
	  SUM(CASE WHEN RevenueComponentId in (101,102,103) then Revenue Else 0.0 End) ProfileRevenue,
	  SUM(CASE WHEN RevenueComponentId in (104) then Revenue Else 0.0 End) AccessRevenue,
	  SUM(CASE WHEN RevenueComponentId between 101 and 107 then Revenue Else 0.0 End) TotalRevenue
from rollup.AccountRevenue AR 
where SvcMonth = @SvcMonth
group by AccountId, SvcMonth
) SA on SA.AccountId = TAS.AccountId
;

With FCC (AMCost) as (
select Cost AMCost from rollup.FixedCommonCost  where FixedCostCategoryId = 1 and SvcMonth = @svcMonth
),
CS (CostProfileOvhd, NumProfiles) as (
select CostProfileOvhd, NumProfiles from rollup.CommonStats where SvcMonth = @svcMonth
) 
update TAS 	set 
	ProfileCost = SA.ProfileCost,
	AccessCost = SA.AccessCost,
	ContributionCost = SA.ContributionCost,
	GrossCost = SA.GrossCost
from rollup.TmpAccountStats TAS
inner join (
		select AccountId, SvcMonth, 
			SUM(CASE WHEN CostcomponentId in (201,202,203,204,205,206) THEN Cost ELse 0.0 END ) ProfileCost,
			SUM(CASE WHEN CostcomponentId in (208,209,210) THEN Cost ELse 0.0 END ) AccessCost,
			SUM (Cost )															   ContributionCost,
			SUM(CASE WHEN CostcomponentId not in (202,207,211,212) THEN Cost ELse 0.0 END ) 
			+ MAX((CS.CostProfileOvhd -FCC.AMCost)	/  CS.NumProfiles) 	GrossCost 
		from rollup.AccountCost
		inner join FCC on 1=1
		inner join CS on 1=1
		where SvcMonth = @svcMonth
		group by AccountId, SvcMonth
) SA on SA.AccountId = TAS.AccountId


print 'Account Stats delete and add from TmpAccountStats ...';
-- add accountstats to permanent table
delete from rollup.AccountStats where  SvcMonth = @svcMonth;
insert into rollup.AccountStats (
      [AccountId]
      ,[SvcMonth]
      ,[ClusterId]
      ,[NumCircuits]
      ,[NumProfiles]
      ,[SeatSizeSegmentId]
      ,[NumManagedProfiles]
      ,[ProfilePrice]
      ,[ProfilePriceSegmentId]
      ,[NumSupportCasesRegular]
      ,[NumNocCasesRegular]
      ,[NumMonthsInvoiced]
      ,[IsOlderThan3Months]
      ,[PartnerCommissionRate]
      ,[HasAccess]
	  ,[ProfileCost]
	  ,[ProfileRevenue]
	  ,[AccessCost]
	  ,[AccessRevenue]
	  ,ContributionCost
	  ,TotalRevenue
	  ,GrossCost
	  )
select       
	   TA.[AccountId]
      ,TA.[SvcMonth]
      ,[ClusterId]
      ,[NumCircuits]
      ,[NumProfiles]
      ,[SeatSizeSegmentId]
      ,[NumManagedProfiles]
      ,[ProfilePrice]
      ,[ProfilePriceSegmentId]
      ,[NumSupportCasesRegular]
      ,[NumNocCasesRegular]
      ,[NumMonthsInvoiced]
      ,[IsOlderThan3Months]
      ,[PartnerCommissionRate]
      ,[HasAccess] 
	  ,[ProfileCost]
	  ,[ProfileRevenue]
	  ,[AccessCost]
	  ,[AccessRevenue]
	  ,ContributionCost
	  ,TotalRevenue
	  ,GrossCost
from rollup.TmpAccountStats TA 
inner join (
		Select distinct TA.AccountId, TA. SvcMonth from rollup.TmpAccountStats TA
		left join rollup.AccountCost AC on AC.AccountId = TA.AccountId and AC. SvcMonth = TA. SvcMonth
		left join rollup.AccountRevenue AR on AR.AccountId = TA.AccountId and Ar. SvcMonth = TA. SvcMonth
		where TA. SvcMonth = @svcMonth and (Ac.AccountId is not null or AR.AccountId is not null)
		) Foo on Foo.AccountId = TA.AccountId and Foo. SvcMonth = TA. SvcMonth
where TA. SvcMonth = @svcMonth 




END

