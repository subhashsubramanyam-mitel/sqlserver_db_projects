
CREATE VIEW [rollup].[VwTotalBookingsByCountry]  
AS


SELECT 
	  REPLACE(REPLACE(O.Name, CHAR(10), ''), CHAR(9), '') collate SQL_Latin1_General_CP1_CI_AS [Name]
      --,CASE WHEN O.Won = 'true' THEN O.EstimatedMRR ELSE 0.0 END [Amount Won]
	,O.EstimatedMRR  as 'Bookings'
      ,cast (O.[CloseDate] as Date) [Date Closed]
 ,O.CountryCode collate SQL_Latin1_General_CP1_CI_AS [Country]
	  ,case when
	    ( Stage <> 'Closed Won- MSA'
		and O.[CloseDate]  <=  getdate()
		--and opp.countrycode <> 'AU'
		and  isnull(O.[SubType],'NA') <> 'Flex CC and/or SIP' 
		and (isnull(O.[SubType],'NA') <> 'Private and Other Cloud' --and opp.countrycode <> 'GB'
		)
         )
		Then 'Cloud Booking' 
		when ( O.[SubType] = 'Private and Other Cloud')
		then 'Cloud for Partners'
       end collate SQL_Latin1_General_CP1_CI_AS [Bookings Source]
  FROM [sfdc].[Opportunity2] O
  left join sfdc.Account2 A on A.SfdcId = O.AccountID
  left join sfdc.Account2 P on P.SfdcId = O.ReferredbyPartnerID
  left join sfdc.Account2  LP on LP.SfdcId = O.LeadPartner
  -- Important: Company.Account should be latest from FinanceBI
  left join company.Account PA on PA.Id = cast(convert(float, A.M5DBAccountId) as int)
  left join SFDC.VwTerritory T on T.SfdcId = O.ShoreTelTerritory

  where 
  O.Created between  '2012-07-01' and '2020-07-01'
  --and A.[CustomerType] in ('Cloud', 'Legacy Cloud', 'Private Cloud')
  and coalesce(O.CloseDate, '2020-07-01') between  '2012-07-01' and '2020-07-01'
  and O.RecordType <> 'Secondary'
   and
  (isnumeric(A.M5dbAccountId) = 1 or A.M5dbAccountId is null)
  and 
  O.EstimatedMRR > 0
  and (Stage like '%Won%') and Stage <> 'Closed Won- MSA'
  and O.[Type] <> 'Moves, Splits, Changes'
  and (OwnerRole is null or OwnerRole  <> 'Terminated Users')
  and isnull(O.[SubType],'NA') <> 'Flex CC and/or SIP' 

  Union all

  select 
va.[Ac Name] as 'Name',
sum(oa.MRR) as 'Bookings'
,oa.DateCreated as 'Bookings Date'
,c.CodeAlpha2 as 'country'
, 'CrossSell' as 'Bookings Source'
from oss.VwAddOrderService  oa
inner join [enum].[VwProduct] p
on p.[Prod Id]= oa.ProductId and p.IsCrossSellProduct = 1
inner join [company].[VwAccount2] va
on va.[Ac Id] = oa.AccountId and va.IsBillable = 1
left join company.Location L 
ON L.Id = oa.LocationId
left join Enum.Country c
on c.Id = l.CountryId
where oa.DateCreated <=  getdate()
--where oa.DateCreated >= '10/01/2014' and oa.DateCreated  <='10/31/2014'
group by oa.DateCreated,c.CodeAlpha2, va.[Ac Name]
--order by oa.DateCreated,c.CodeAlpha2
