


CREATE VIEW [rollup].[VwTotalBookings_Americas]  
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
and opp.countrycode in ('US', 'CA')
and  isnull(opp.[SubType],'NA') <> 'Flex CC and/or SIP' 
and (isnull(opp.[SubType],'NA') <> 'Private and Other Cloud' )
--and opp.[Date Closed] >= '10/01/2014' and opp.[Date Closed]  <='10/31/2014'
-- MW 12062016  dont count cross sell from SFDC since it would be duplicated
and isnuLL( opp.SubType, 'NA') <> 'Cross-Sell'
group by opp.[Date Closed]

union all

select 
sum(oa.MRR) as 'Bookings'
, 'CrossSell' as 'Bookings Source'
,oa.DateCreated as 'Bookings Date'
from oss.VwAddOrderService(NOLOCK)    oa
inner join [enum].[VwProduct](NOLOCK)   p
on p.[Prod Id]= oa.ProductId and p.IsCrossSellProduct = 1
inner join [company].[VwAccount2](NOLOCK)   va
on va.[Ac Id] = oa.AccountId and va.IsBillable = 1
inner join [company].[Location](NOLOCK)  loc
ON loc.Id = oa.LocationId
where oa.DateCreated <=  getdate()
and  loc.CountryId in ( 840, 124)
--where oa.DateCreated >= '10/01/2014' and oa.DateCreated  <='10/31/2014'
group by oa.DateCreated 

union all

--select 
--sum(pvt.[Total Monthly Rev]) as 'Bookings'
--, 'PrivateCloud' as 'Bookings Source'
--,pvt.Date as 'Bookings Date'
--from [sfdc].[PvtCloudOpportunity] Pvt 
--where stage = 'closed'
--group by pvt.Date 

--union all

select
sum(opp.[Amount Won]) as'Bookings',
'Cloud for Partners' as 'Bookings Source'
,opp.[Date Closed] as 'Bookings Date'
from [sfdc].[VwOpportunity] opp
where
[Amount Won] > 0 and
[Opportunity Type] <> 'Moves, Splits, Changes'
and Stage <> 'Closed Won- MSA'
and opp.[Date Closed] <=  getdate()
and opp.countrycode in ('US','CA')
and opp.[SubType] = 'Private and Other Cloud'
--and opp.[Date Closed] >= '10/01/2014' and opp.[Date Closed]  <='10/31/2014'
group by opp.[Date Closed]






