 CREATE View [MWSandbox].[VwSCC] as 
-- MW 11212017 SCC Info for Santana
select AccountId, Count(*) as NumberOfSCCs 
from [$(FinanceBI)].oss.VwServiceProduct2 
where --Name  like '%scc%' 
--ProductId in (274,275)  
serviceclassid in (100,101,102) 
and ServiceStatusid=1
group by AccountId