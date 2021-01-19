CREATE View AUinvoice.VwMapping  as 
select distinct Description, chargeType, ProdCategory, ProdSUbCategory, [Seat Classification] 
from AUinvoice.JanBillWMapping