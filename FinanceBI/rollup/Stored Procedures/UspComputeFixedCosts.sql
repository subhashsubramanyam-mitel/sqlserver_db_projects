

-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-12-16
-- Description:	Compute Fixed Costs for a Given SvcMonth
-- Change Log:
--     2016-12-08 Tarak, adjusting based on Will Nolan's revisions 
-- =============================================
CREATE PROCEDURE [rollup].[UspComputeFixedCosts]
	@svcMonth Date
AS
BEGIN

print 'Fixed Costs ...';
-- Delete all costs previous computed for the service month
delete from rollup.FixedCommonCost where SvcMonth = @svcMonth ;

-- 6 NOC Connectivity 25%, the other 75% will come through from Phoenix
insert into rollup.FixedCommonCost (FixedCostCategoryId, SvcMonth, Cost)
select 6, AD.[Month], -SUM(LT.[Cons USD AMT])/4 Amount from 
ax.VwLedgerTrans2 LT
inner join enum.AxDepartment D on D.[Dept Id] = LT.DIMENSION
inner join enum.AxLedgerAccount LA on LA.[GL AccountNum] = LT.ACCOUNTNUM
inner join enum.AxDate AD on AD.Date  = LT.TRANSDATE
Where 
LA.[GL AccountNum] in ('55130', '55135') -- two GL accounts that acrrue 
and AD.[Month] = @svcMonth
group by AD.[Month]


--- 3, 4, 5 NOC Support, Monitoring, Profiles
insert into rollup.FixedCommonCost (FixedCostCategoryId, SvcMonth, Cost)
select NC.Cat, AD.[Month], -SUM(LT.[Cons USD AMT])/3 Amount from 
ax.VwLedgerTrans2 LT
inner join enum.AxDepartment D on D.[Dept Id] = LT.DIMENSION
inner join enum.AxLedgerAccount LA on LA.[GL AccountNum] = LT.ACCOUNTNUM
inner join enum.AxDate AD on AD.Date  = LT.TRANSDATE
inner join (select 3 Cat union select 4 union select 5 ) NC on 1=1
Where 
-- D.[L1 Owner] = 'Dennis Schmidt'
--and
 D.[IS Level2] = 'Cost of Hosted Service'
and LA.[GL Area] not in ('GAAP', 'Headcount', 'Restructuring', 'Stock Compensation')
and LA.[GL Account Grouping] not in ('Depreciation')
and AD.Month  = @svcMonth
and D.[Dept Level5] = 'Service Assurance (NOC)'
group by NC.Cat, AD.[Month]


--- 2 Networks
insert into rollup.FixedCommonCost (FixedCostCategoryId, SvcMonth, Cost)
select 2, AD.[Month], -SUM(LT.[Cons USD AMT]) Amount from 
ax.VwLedgerTrans2 LT
inner join enum.AxDepartment D on D.[Dept Id] = LT.DIMENSION
inner join enum.AxLedgerAccount LA on LA.[GL AccountNum] = LT.ACCOUNTNUM
inner join enum.AxDate AD on AD.Date  = LT.TRANSDATE
Where 
--D.[L1 Owner] = 'Dennis Schmidt' and 
D.[IS Level2] = 'Cost of Hosted Service'
and LA.[GL Area] not in ('GAAP', 'Headcount', 'Restructuring', 'Stock Compensation')
and LA.[GL Account Grouping] not in ('Depreciation') -- EXCEPT Depreciation
and AD.[Month]  = @svcMonth
and D.[Dept Level5] = 'Networks'
group by AD.[Month]

-- Depreciation revision provided provided by Will Nolan
--- 8 Data Center Depreciation 
insert into rollup.FixedCommonCost (FixedCostCategoryId, SvcMonth, Cost)
select 8, AD.[Month], SUM(LT.[Cons USD AMT]) Amount from 
ax.VwLedgerTrans2 LT
inner join enum.AxDepartment D on D.[Dept Id] = LT.DIMENSION
inner join enum.AxLedgerAccount LA on LA.[GL AccountNum] = LT.ACCOUNTNUM
inner join enum.AxDate AD on AD.Date  = LT.TRANSDATE
Where 
D.[IS Level1] = 'Direct Cost'
and D.[IS Level2] = 'Cost of Hosted Service'
and LA.[GL Area]  in ('Operating Expense')
and LA.[GL Account Grouping] in ('Depreciation') -- ONLY Depreciation
and AD.[Month]  = @svcMonth
and D.[Dept Id] in (1530, 1535, 1540, 1545, 1555, 1620)
group by AD.[Month]


-- 1 Account Mgmt
insert into rollup.FixedCommonCost (FixedCostCategoryId, SvcMonth, Cost)
select 1, AD.[Month], -SUM(LT.[Cons USD AMT]) from 
ax.VwLedgerTrans2 LT
inner join enum.AxDepartment D on D.[Dept Id] = LT.DIMENSION
inner join enum.AxLedgerAccount LA on LA.[GL AccountNum] = LT.ACCOUNTNUM
inner join enum.AxDate AD on AD.Date  = LT.TRANSDATE
Where 
-- D.[L1 Owner] = 'Bharath Oruganti' and 
-- D.[IS Level2] = 'Cost of Hosted Service' and
-- D.[Dept Level2] in ( 'Provisioning', 'Cloud Ops/Other') and
D.[Dept Id] in (4815, 4817, 4818, 4819) --
and LA.[GL Area] not in ('GAAP', 'Headcount', 'Restructuring', 'Stock Compensation')
and LA.[GL Account Grouping] not in ('Depreciation')
and AD.[Month]  = @svcMonth
group by AD.[Month]

-- 7 Support
insert into rollup.FixedCommonCost (FixedCostCategoryId, SvcMonth, Cost)
select 7, AD.[Month], -SUM(LT.[Cons USD AMT]) from 
ax.VwLedgerTrans2 LT
inner join enum.AxDepartment D on D.[Dept Id] = LT.DIMENSION
inner join enum.AxLedgerAccount LA on LA.[GL AccountNum] = LT.ACCOUNTNUM
inner join enum.AxDate AD on AD.Date  = LT.TRANSDATE
Where 
-- D.[L1 Owner] = 'Bharath Oruganti' and
D.[IS Level2] = 'Cost of Hosted Service'
and D.[Dept Level5] in ('Support')
and LA.[GL Area] not in ('GAAP', 'Headcount', 'Restructuring', 'Stock Compensation')
and LA.[GL Account Grouping] not in ('Depreciation')
and AD.[Month]  = @svcMonth
group by AD.[Month]


END


