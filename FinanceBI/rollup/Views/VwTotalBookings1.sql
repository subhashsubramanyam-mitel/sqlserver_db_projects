




CREATE VIEW [rollup].[VwTotalBookings1]  
AS

select
sum(opp.[Amount Won]) as'Bookings',
'Cloud Booking' as 'Bookings Source'
,opp.[Date Closed] as 'Bookings Date'
from [sfdc].[VwOpportunity] opp
where
[Amount Won] > 0 and
[Opportunity Type] <> 'Moves, Splits, Changes'
and Stage <> 'Closed Won- MSA'
and opp.[Date Closed] <=  getdate()
and opp.countrycode <> 'AU'
and  isnull(opp.[SubType],'NA') <> 'Flex CC and/or SIP' 
--and opp.[Date Closed] >= '10/01/2014' and opp.[Date Closed]  <='10/31/2014'
group by opp.[Date Closed]

Union all
select
sum(opp.[Amount Won]) as'Bookings',
'M5 AU Cloud Booking' as 'Bookings Source'
,opp.[Date Closed] as 'Bookings Date'
from [sfdc].[VwOpportunity] opp
where
[Amount Won] > 0 and
[Opportunity Type] <> 'Moves, Splits, Changes'
and Stage <> 'Closed Won- MSA'
and opp.[Date Closed] <=  getdate()
and opp.countrycode = 'AU'
and  isnull(opp.[SubType],'NA') <> 'Flex CC and/or SIP' 
--and opp.[Date Closed] >= '10/01/2014' and opp.[Date Closed]  <='10/31/2014'
group by opp.[Date Closed]

union all

select 
sum(oa.MRR) as 'Bookings'
, 'CrossSell' as 'Bookings Source'
,oa.DateCreated as 'Bookings Date'

from oss.VwAddOrderService  oa
inner join [enum].[VwProduct] p
on p.[Prod Id]= oa.ProductId and p.IsCrossSellProduct = 1
inner join [company].[VwAccount2] va
on va.[Ac Id] = oa.AccountId and va.IsBillable = 1
where oa.DateCreated <=  getdate()
--where oa.DateCreated >= '10/01/2014' and oa.DateCreated  <='10/31/2014'
group by oa.DateCreated 

union all

select 
sum(pvt.[Total Monthly Rev]) as 'Bookings'
, 'PrivateCloud' as 'Bookings Source'
,pvt.Date as 'Bookings Date'
from [sfdc].[PvtCloudOpportunity] Pvt 
where stage = 'closed'
group by pvt.Date 

union all

select
sum(opp.[Amount Won]) as'Bookings',
'UK Private Cloud' as 'Bookings Source'
,opp.[Date Closed] as 'Bookings Date'
from [sfdc].[VwOpportunity] opp
where
[Amount Won] > 0 and
[Opportunity Type] <> 'Moves, Splits, Changes'
and Stage <> 'Closed Won- MSA'
and opp.[Date Closed] <=  getdate()
and opp.countrycode = 'GB'
--and  isnull(opp.[SubType],'NA') <> 'Flex CC and/or SIP' 
and opp.[SubType] = 'Private and Other Cloud'
--and opp.[Date Closed] >= '10/01/2014' and opp.[Date Closed]  <='10/31/2014'
group by opp.[Date Closed]





