



CREATE view 
[dbo].[V_SFDC_POS_OPTY_CLOSE] as 
-- MW 06012015 LeadToService orch for AX/POS
select
	Source,
	SalesOrder,
	PartnerId,
	CustomerId,
	CustomerName,
	EmailDomain,
	OrderTotal,
	CustomerSfdcId,
null as ReasonLost,
OrderDate
FROM
SFDC_OPTY_TRK
Where 
Source IN ('AX', 'POS') and
OrderType NOT IN ('R','RR') and -- Dont close out  RMAs MW 11022015
Status = 'N'
--and CustomerSfdcId is not null
and OrderDate >= convert(char(10),'01-01-2017',101)
and OrderCreateStatus = 'C'
and OrderTotal > 2000



