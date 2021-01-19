Create View MWSandBox.VwQuoteForOpp_CastIron as
-- MW 02022018 Called from Cast Iron to attach quote to Opp
select  AccountId, AccountName, LocationName, Address, ProductName, Qty 
from  [MWSandbox].[VwSantanaQuote_SKY] 