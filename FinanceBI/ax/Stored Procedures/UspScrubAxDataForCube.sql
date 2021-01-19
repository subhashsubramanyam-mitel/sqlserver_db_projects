-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-09-07
-- Description:	Separating the data cleanups
-- =============================================
CREATE PROCEDURE [ax].[UspScrubAxDataForCube]
AS
BEGIN
update ax.LedgerTrans set TXT = 'Q2''14 Adjust Solar SPIFF' 
where TXT like 'Q%SOLAR%Spiff%' and TXT <> 'Q2''14 Adjust Solar SPIFF' 

update ax.LedgerTrans set TXT = 'Q2''14 Adjust Solar SPIFF' 
where TXT like 'Fenwick #543909SUP 09.30.13%' and TXT <> 'QFenwick #543909SUP 09.30.13'
and LEN(TXT)<= LEN('Fenwick #543909SUP 09.30.13')+2
 
update ax.LedgerTrans set TXT = 'Deposit 7/9/13' 
where TXT like 'Deposit 7/9/13%' and TXT <> 'Deposit 7/9/13' 

update 
--select * from
ax.LedgerTrans 
set TXT = 'CONCUR ACCRUAL - SHARMA, RAJIV' 
where TXT like 'CONCUR ACCRUAL - SHARMA, RAJIV%' and TXT <> 'CONCUR ACCRUAL - SHARMA, RAJIV' 


END
