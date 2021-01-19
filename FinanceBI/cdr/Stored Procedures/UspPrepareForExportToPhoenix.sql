
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description: Prepare Cost and Charge for  Export To Phoenix
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspPrepareForExportToPhoenix] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge,  cdr.Dlabs_UsageImport, and many supporting tables

Declare @Bill_Month varchar(8) = Substring(convert(varchar(24),@InvoiceMonth,120),1,7);

-- Completed in 4-5 minutes -- Jun 5

-- 1. Profile Allocation
insert into CallData.cdr.Dlabs_UsageImport
(WTN, bill_month, cost, revenue, minutes, account_id, client_name, location_id, location_name,
 calls, usage_type, base_tn, calls_unrated, 
 minutes_unrated, InTNDB)
select -- top 10
	Coalesce(FCC.CleanTN, 'InvalidTN') as WTN,
	@Bill_Month as bill_month,
	0  as cost,
	 LTRIM(Str(Coalesce(SUM(FCC.ChargeInvoiced),0.0), 25, 2))  as revenue,
	 0 as minutes,
	 FCC.AccountId as account_id,
	 A.Name as client_name,
	 FCC.LocationId as location_id,
	 L.Name as location_name,
	 Count(1) as calls,
	 'PROFILE' as usage_type,
	 FCC.TN as base_tn,
	 0 as calls_unrated,
	 0 as minutes_unrated,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END as InTNDB
from CallData.cdr.CostAndCharge FCC
inner join cdr.VwCdrTn T on T.Id = FCC.TN -- all TNs should match
left join provision.Tn GTN on GTN.Id = FCC.CleanTN -- if Clean TNs match
left join company.Account A on A.Id = FCC.AccountId
left join company.Location L on L.Id = FCC.LocationId
where FCC.CDRSource = 'Profile'
group by 
	 FCC.CleanTN ,
	 FCC.AccountId,
	 A.Name ,
	 FCC.LocationId,
	 L.Name ,
	 FCC.TN ,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END 
	 ;
-- Jan (132855 row(s) affected) 24 sec
-- Dec (110734 row(s) affected)

-- 2. Inbound TollFree 
insert into CallData.cdr.Dlabs_UsageImport 
(WTN, bill_month, cost, revenue, minutes, account_id, client_name, location_id, location_name,
 calls, usage_type, base_tn, calls_unrated, minutes_unrated, InTNDB)
select -- top 10
	Coalesce(FCC.CleanTN, 'InvalidTN') as WTN,
	@Bill_Month as bill_month,
	 LTRIM(Str(Coalesce(SUM(FCC.Cost_60_60),0.0), 25, 2))  as cost,
	 LTRIM(Str(Coalesce(SUM(FCC.ChargeInvoiced),0.0), 25, 2))  as revenue,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) <> 6 then DurationMinutes else 0 END) as minutes,
	 FCC.AccountId as account_id,
	 A.Name as client_name,
	 FCC.LocationId as location_id,
	 L.Name as location_name,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) <> 6 then 1 else 0 END) as calls,
	 'IN TF' as usage_type,
	 FCC.TN as base_tn,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) = 6 then 1 else 0 END) as calls_unrated,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) = 6 then DurationMinutes else 0 END) as minutes_unrated,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END as InTNDB
from CallData.cdr.CostAndCharge FCC
inner join cdr.VwCdrTn T on T.Id = FCC.TN -- all TNs should match
left join provision.Tn GTN on GTN.Id = FCC.CleanTN -- if Clean TNs match
left join company.Account A on A.Id = FCC.AccountId
left join company.Location L on L.Id = FCC.LocationId
where 
		FCC.CDRSource in ( 'Bobl', 'Connect')
		and FCC.CDRCallTypeId = 3 -- Tollfree
		and FCC.CDRServiceTypeId = 1 -- incoming
group by 
	 FCC.CleanTN ,
	 FCC.AccountId,
	 A.Name ,
	 FCC.LocationId,
	 L.Name ,
	 FCC.TN ,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END 
--- Jan (4161 row(s) affected) 1 min 11 sec
-- Dec (3960 row(s) affected)

--3. Inbound Non-TollFree 
insert into CallData.cdr.Dlabs_UsageImport 
(WTN, bill_month, cost, revenue, minutes, account_id, client_name, location_id, location_name,
 calls, usage_type, base_tn, calls_unrated, minutes_unrated, InTNDB)
select -- top 10
	Coalesce(FCC.CleanTN, 'InvalidTN') as WTN,
	@Bill_Month as bill_month,
	 LTRIM(Str(Coalesce(SUM(FCC.Cost_60_60),0.0), 25, 2))  as cost,
	 LTRIM(Str(Coalesce(SUM(FCC.ChargeInvoiced),0.0), 25, 2))  as revenue,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) <> 6 then DurationMinutes else 0 END) as minutes,
	 FCC.AccountId as account_id,
	 A.Name as client_name,
	 FCC.LocationId as location_id,
	 L.Name as location_name,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) <> 6 then 1 else 0 END) as calls,
	 'IN NTF' as usage_type,
	 FCC.TN as base_tn,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) = 6 then 1 else 0 END) as calls_unrated,
	 SUM(CASE WHEN coalesce(CostRateTableId,6) = 6 then DurationMinutes else 0 END) as minutes_unrated,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END as InTNDB
from CallData.cdr.CostAndCharge FCC
inner join cdr.VwCdrTn T on T.Id = FCC.TN -- all TNs should match
left join provision.Tn GTN on GTN.Id = FCC.CleanTN -- if Clean TNs match
left join company.Account A on A.Id = FCC.AccountId
left join company.Location L on L.Id = FCC.LocationId
where 
		FCC.CDRSource in ( 'Bobl', 'Connect')
		and FCC.CDRCallTypeId <> 3 -- NOT Tollfree
		and FCC.CDRServiceTypeId = 1 -- incoming
group by 
	 FCC.CleanTN ,
	 FCC.AccountId,
	 A.Name ,
	 FCC.LocationId,
	 L.Name ,
	 FCC.TN ,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END 
-- Jan (133055 row(s) affected) 2 minutes
-- Dec (130044 row(s) affected)

-- 4. Outbound INTERNATIONAL
insert into CallData.cdr.Dlabs_UsageImport 
(WTN, bill_month, cost, revenue, minutes, account_id, client_name, location_id, location_name,
 calls, usage_type, base_tn, calls_unrated, minutes_unrated, InTNDB)
select -- top 10
	Coalesce(FCC.CleanTN, 'InvalidTN') as WTN,
	@Bill_Month as bill_month,
	 LTRIM(Str(Coalesce(SUM(FCC.Cost_60_60),0.0), 25, 2))  as cost,
	 LTRIM(Str(Coalesce(SUM(FCC.ChargeInvoiced),0.0), 25, 2))  as revenue,
	 SUM(CASE WHEN FCC.CostINTLRateId is not null and CDRSource = 'Tdx'
				THEN DurationMinutes else 0 END) as minutes, -- count Tdx minutes
	 FCC.AccountId as account_id,
	 A.Name as client_name,
	 FCC.LocationId as location_id,
	 L.Name as location_name,
	 SUM(CASE WHEN FCC.CostINTLRateId is not null and CDRSource = 'Tdx'
				THEN 1 else 0 END) as calls, -- count Tdx calls
	 'OUT INTL' as usage_type,
	 FCC.TN as base_tn,
	 SUM(CASE WHEN FCC.CostINTLRateId is null  and CDRSource = 'Tdx'
				THEN 1 else 0 END) as calls_unrated,
	 SUM(CASE WHEN FCC.CostINTLRateId is null  and CDRSource = 'Tdx'
				THEN DurationMinutes else 0 END) as minutes_unrated,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END as InTNDB
from CallData.cdr.CostAndCharge FCC
inner join cdr.VwCdrTn T on T.Id = FCC.TN -- all TNs should match
left join provision.Tn GTN on GTN.Id = FCC.CleanTN -- if Clean TNs match
left join company.Account A on A.Id = FCC.AccountId
left join company.Location L on L.Id = FCC.LocationId
where 
		 -- take three sources
		 FCC.CDRCallTypeId in (5,7)
		and FCC.CDRServiceTypeId = 2 -- outbound
		and FCC.CDRRegionTypeId = 5 -- international
group by 
	 FCC.CleanTN ,
	 FCC.AccountId,
	 A.Name ,
	 FCC.LocationId,
	 L.Name ,
	 FCC.TN ,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END 
-- Jan (31804 row(s) affected) 1 min 13 sec
-- Dec (35335 row(s) affected)  -- MORE

-- 5. Outbound INTERSTATE  -- investigate base_tn 131647612 -- why cost is 0.0?
insert into CallData.cdr.Dlabs_UsageImport 
(WTN, bill_month, cost, revenue, minutes, account_id, client_name, location_id, location_name,
 calls, usage_type, base_tn, calls_unrated, minutes_unrated, InTNDB)
select -- top 10
	Coalesce(FCC.CleanTN, 'InvalidTN') as WTN,
	@Bill_Month as bill_month,
	 LTRIM(Str(Coalesce(SUM(FCC.Cost_60_60),0.0), 25, 2))  as cost,
	 LTRIM(Str(Coalesce(SUM(FCC.ChargeInvoiced),0.0), 25, 2))  as revenue,
	 SUM(CASE WHEN FCC.CostUSDRateId is not null and CDRSource = 'Tdx'
				THEN DurationMinutes else 0 END) as minutes, -- count Tdx minutes
	 FCC.AccountId as account_id,
	 A.Name as client_name,
	 FCC.LocationId as location_id,
	 L.Name as location_name,
	 SUM(CASE WHEN FCC.CostUSDRateId is not null  and CDRSource = 'Tdx'
				THEN 1 else 0 END) as calls, -- count Tdx calls
	 'OUT INTER' as usage_type,
	 FCC.TN as base_tn,
	 SUM(CASE WHEN FCC.CostUSDRateId is  null  and CDRSource = 'Tdx'
				THEN 1 else 0 END) as calls_unrated,
	 SUM(CASE WHEN FCC.CostUSDRateId is  null  and CDRSource = 'Tdx'
				THEN DurationMinutes else 0 END) as minutes_unrated,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END as InTNDB
from CallData.cdr.CostAndCharge FCC
inner join cdr.VwCdrTn T on T.Id = FCC.TN -- all TNs should match
left join provision.Tn GTN on GTN.Id = FCC.CleanTN -- if Clean TNs match
left join company.Account A on A.Id = FCC.AccountId
left join company.Location L on L.Id = FCC.LocationId
where 
		 -- take three sources
		 FCC.CDRCallTypeId in (5,7)
		and FCC.CDRServiceTypeId = 2 -- outbound
		and FCC.CDRRegionTypeId = 4 -- inter
	group by 
	 FCC.CleanTN ,
	 FCC.AccountId,
	 A.Name ,
	 FCC.LocationId,
	 L.Name ,
	 FCC.TN ,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END 
-- Jan(125455 row(s) affected) 1 min 33 sec 408188 -- too many
-- Dec (423041 row(s) affected)  -- MUCH MORE

-- 6. Outbound INTRASTATE  -- investigate base_tn 131647612 -- why cost is 0.0?
insert into CallData.cdr.Dlabs_UsageImport 
(WTN, bill_month, cost, revenue, minutes, account_id, client_name, location_id, location_name,
 calls, usage_type, base_tn, calls_unrated, minutes_unrated, InTNDB)
select -- top 10
	Coalesce(FCC.CleanTN, 'InvalidTN') as WTN,
	@Bill_Month as bill_month,
	 LTRIM(Str(Coalesce(SUM(FCC.Cost_60_60),0.0), 25, 2))  as cost,
	 LTRIM(Str(Coalesce(SUM(FCC.ChargeInvoiced),0.0), 25, 2))  as revenue,
	 SUM(CASE WHEN FCC.CostUSDRateId is not null and CDRSource = 'Tdx'
				THEN DurationMinutes else 0 END) as minutes, -- count Tdx minutes
	 FCC.AccountId as account_id,
	 A.Name as client_name,
	 FCC.LocationId as location_id,
	 L.Name as location_name,
	 SUM(CASE WHEN FCC.CostUSDRateId is not null  and CDRSource = 'Tdx'
				THEN 1 else 0 END) as calls, -- count Tdx calls
	 'OUT INTRA' as usage_type,
	 FCC.TN as base_tn,
	 SUM(CASE WHEN FCC.CostUSDRateId is  null  and CDRSource = 'Tdx'
				THEN 1 else 0 END) as calls_unrated,
	 SUM(CASE WHEN FCC.CostUSDRateId is  null  and CDRSource = 'Tdx'
				THEN DurationMinutes else 0 END) as minutes_unrated,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END as InTNDB
from CallData.cdr.CostAndCharge FCC
inner join cdr.VwCdrTn T on T.Id = FCC.TN -- all TNs should match
left join provision.Tn GTN on GTN.Id = FCC.CleanTN -- if Clean TNs match
left join company.Account A on A.Id = FCC.AccountId
left join company.Location L on L.Id = FCC.LocationId
where 
		 -- take three sources
		 FCC.CDRCallTypeId in (5,7)
		and FCC.CDRServiceTypeId = 2 -- outbound
		and FCC.CDRRegionTypeId in (1,2,3) -- intra
	group by 
	 FCC.CleanTN ,
	 FCC.AccountId,
	 A.Name ,
	 FCC.LocationId,
	 L.Name ,
	 FCC.TN ,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END 
;
-- Jan 139862 row(s) affected) 1 min 41 sec
-- Dec (586095 row(s) affected) -- MUCH MORE

-- 7. Outbound n11  
insert into CallData.cdr.Dlabs_UsageImport 
(WTN, bill_month, cost, revenue, minutes, account_id, client_name, location_id, location_name,
 calls, usage_type, base_tn, calls_unrated, minutes_unrated, InTNDB)
select -- top 10
	Coalesce(FCC.CleanTN, 'InvalidTN') as WTN,
	@Bill_Month as bill_month,
	 LTRIM(Str(Coalesce(SUM(FCC.Cost_60_60),0.0), 25, 2))  as cost,
	 LTRIM(Str(Coalesce(SUM(FCC.ChargeInvoiced),0.0), 25, 2))  as revenue,
	 SUM(CASE WHEN coalesce(FCC.CostRateTableId,6)<>6 and CDRSource in ( 'Bobl', 'Connect')
				THEN DurationMinutes else 0 END) as minutes, -- 
	 FCC.AccountId as account_id,
	 A.Name as client_name,
	 FCC.LocationId as location_id,
	 L.Name as location_name,
	 SUM(CASE WHEN coalesce(FCC.CostRateTableId,6)<>6 and CDRSource in ( 'Bobl', 'Connect')
				THEN 1 else 0 END) as calls, -- 
	 'OUT n11' as usage_type,
	 FCC.TN as base_tn,
	 SUM(CASE WHEN coalesce(FCC.CostRateTableId,6)=6 and CDRSource in ( 'Bobl', 'Connect')
				THEN 1 else 0 END) as calls_unrated,
	 SUM(CASE WHEN coalesce(FCC.CostRateTableId,6)=6 and CDRSource in ( 'Bobl', 'Connect')
				THEN DurationMinutes else 0 END) as minutes_unrated,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END as InTNDB
from CallData.cdr.CostAndCharge FCC
inner join cdr.VwCdrTn T on T.Id = FCC.TN -- all TNs should match
left join provision.Tn GTN on GTN.Id = FCC.CleanTN -- if Clean TNs match
left join company.Account A on A.Id = FCC.AccountId
left join company.Location L on L.Id = FCC.LocationId
where 
		FCC.CDRSource in ( 'Bobl', 'Connect')
		and FCC.CDRRegionTypeId <> 5 -- NOT international
		and FCC.CDRServiceTypeId = 2 -- Outbound
		and FCC.CdrCallTypeId not in (3,5,7) -- not Regular or mobile
	group by 
	 FCC.CleanTN ,
	 FCC.AccountId,
	 A.Name ,
	 FCC.LocationId,
	 L.Name ,
	 FCC.TN ,
	 CASE WHEN T.TnType = 'BadTn' and GTN.Id is null THEN 0 ELSE 1 END 
;
END
