 CREATE View MWSandbox.[VwSantanaQuote_Tableau-delete] as
 -- for Tableau, issue with accountIds MW 02262018
 select 
  a.AccountId
  ,convert(varchar(15),a.AccountId) as AccountIdStr
  ,b.AccountName
 ,b.LocationName 
 ,b.Address
 ,b.ConnectProductId
 ,b.ProductName
 ,b.Qty
 ,b.MRR
 from
 MWSandbox.MigrationCustList a inner join
 MWSandbox.VwSantanaQuote_SKY b on a.AccountId = b.AccountId and isnumeric(b.AccountId) = 1