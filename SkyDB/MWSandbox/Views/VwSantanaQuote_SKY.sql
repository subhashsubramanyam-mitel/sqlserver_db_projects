
 CREATE view [MWSandbox].[VwSantanaQuote_SKY] as 
-- MW 11292017 Combined Quote
	select   
	  AccountId
	  ,AccountName
	 ,LocationName 
	 ,Address
	 ,ConnectProductId
	 ,ProductName
	 ,SUM(Qty) as Qty
	 ,SUM(MRR) as MRR
FROM
 (
select 
  AccountId
  ,AccountName
 ,LocationName 
 ,Address
 ,ConnectProductId
 ,ProductName
 ,Qty
 ,MRR
 from
MWSandbox.VwMigQuoteProfiles
 where isnumeric( AccountId) = 1
--where AccountId = 109
UNION ALL
select 
  AccountId
  ,AccountName
 ,LocationName 
 ,Address
 ,ConnectProductId
 ,ProductName
 ,Qty
 ,MRR
 from
MWSandbox.VwMigQuoteACD_V2 where  isnumeric( AccountId) = 1

UNION ALL
select 
  AccountId
  ,AccountName
 ,LocationName 
 ,Address
 ,ProductId as ConnectProductId
 ,ProductName
 ,Qty
 ,0 as MRR
 from
MWSandbox.VwMigQuoteHW where  isnumeric( AccountId) = 1
UNION ALL
select 
  AccountId
  ,AccountName
 ,LocationName 
 ,Address
 ,ConnectProductId
 ,ProductName
 ,Qty
 ,MRR
 from
MWSandbox.VwMigQuoteOther where  isnumeric( AccountId) = 1
--where AccountId = 109
UNION ALL
select 
  AccountId
  ,AccountName
 ,LocationName 
 ,Address
 ,ProductId
 ,ProductName
 ,1 as Qty
 ,0 as MRR
 from
MWSandbox.VwCircuitBundles where  isnumeric( AccountId) = 1
UNION ALL
select 
  AccountId
  ,null
 ,'x' as LocationName 
 ,'***Note About Add Ons***' as Address
 ,null
 ,Options as ProductName
 ,null as Qty
 ,null as MRR
 from
MWSandbox.VwProfileAddOnSummary where  isnumeric( AccountId) = 1
) a 
group by 
	  AccountId
	  ,AccountName
	 ,LocationName 
	 ,Address
	 ,ConnectProductId
	 ,ProductName









