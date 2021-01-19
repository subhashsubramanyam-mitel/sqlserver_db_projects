
Create VIEW V_SFDC_QMS_OPTY_CLOSE
AS
-- MW 06012015  LeadToService orch uses this for list of QMS OPPS to close out.
select 
	SalesOrder,
	QNumber,
	OptyId,
	PartnerId,
	CustomerId,
	CustomerName,
	--OrderTotal,
	null as ReasonLost,
	OrderDate
from SFDC_OPTY_TRK 
where 
Source = 'QMS' and Status = 'N'
and OptyId is not null
--and CustomerSfdcId is not null
and OrderDate >= convert(char(10),'05-31-2015',101)
and OrderCreateStatus = 'C'