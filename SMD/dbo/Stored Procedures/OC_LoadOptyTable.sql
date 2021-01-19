
















  CREATE PROCEDURE [dbo].[OC_LoadOptyTable] as 
-- Loads Opty Table for OC integration user tstories 73 and 51

-- =============================================
-- MW 03042015 Loads Opty Tracking table for salesforce integration
-- =============================================

-- QMS
--
INSERT INTO SFDC_OPTY_TRK(
Source, QNumber, OrderDate, SalesOrder, OptyId, PartnerId, CustomerId, CustomerName 	, ReqShipDate,
		PONumber, OrderType,CustomerSfdcId, CustBuild			 )

select
		a.Source, 
		a.QNumber, 
		a.OrderDate, 
		a.SalesOrder, 
		-- FIX FOR QMS ERRORS
		CASE WHEN a.OptyId like '%<%' Then NULL ELSE
		a.OptyId END AS OptyId, 
		a.PartnerId, 
		a.CustomerId, 
		a.CustomerName, 
		a.ShippingDateRequested	,
		a.PONum, 
		a.OrderType,
		a.CustomerSfdcId,
		CASE WHEN a.OrderType = 'I' Then 'Initial'
			 When a.OrderType = 'S' Then 'Support'
			 ELSE 'AddOn' END AS CustBuild
FROM
V_SFDC_QMS_ORDERS a left outer join
SFDC_OPTY_TRK b on a.SalesOrder = b.SalesOrder
where b.SalesOrder IS NULL

 
	
-- AX off radar and EDI
INSERT INTO SFDC_OPTY_TRK(
Source, OrderDate, SalesOrder, PartnerId, CustomerId, CustomerName, CustomerPhone, EmailDomain, ReqShipDate,
		PONumber, OrderType	, CustBuild	 )
select 
		a.Source, 
		a.OrderDate, 
		a.SalesOrder, 
		a.PartnerId, 
		a.CustomerId, 
		a.CustomerName, 
		a.CustomerPhone, 
		a.EmailDomain, 
		--a.EdiOrder, 
		--a.OrderType,
		a.ShippingDateRequested,
		a.PONum, 
		a.OrderType,
		CASE WHEN a.OrderType = 'I' Then 'Initial'
			 When a.OrderType = 'S' Then 'Support'
			 ELSE 'AddOn' END AS CustBuild
FROM
	V_SFDC_EDI_ORDERS a left outer join
	SFDC_OPTY_TRK b on a.SalesOrder = b.SalesOrder
where b.SalesOrder IS NULL




-- Update Booking value (pre OC only) shouldnt be needed after
-- only used for updating old optys
update SFDC_OPTY_TRK set OrderTotal = b.Total from
	SFDC_OPTY_TRK a inner join (
		select SalesOrder, -- SUM(NetAmount) 
		--fx
		 SUM(a.NetAmount*(isnull(r.exchrate,1)/100)) as Total
		from AX_BOOKINGS a  left outer join
		AX_EXCHRATE r on a.Currency	= r.currencycode
		group by SalesOrder
								) b on a.SalesOrder = b.SalesOrder
where a.OrderTotal is null



-- POS
--  select * from SFDC_OPTY_TRK where OrderCreateStatus = 'N'
INSERT INTO SFDC_OPTY_TRK(
Source, SalesOrder,OrderDate,  ReqShipDate, PartnerId, CustomerId, CustomerName,  OrderTotal            
		, PONumber, OrderType		, CustBuild		 )
 SELECT     
    a.Source,
	a.SalesOrder, 
	a.OrderDate, 
	a.ReqShipDate,
	a.VarId,
	a.EndCust, 
	a.CustomerName,
	a.Billings,
	a.SalesOrder,
	CASE WHEN isnumeric(a.EndCust)= 1 THEN 'A' ELSE 'I' END As OrderType,
	CASE WHEN isnumeric(a.EndCust)= 1 THEN 'AddOn' ELSE 'Initial' END As CustBuild
 FROM          
  	V_SFDC_POS_ORDERS a left outer join
	SFDC_OPTY_TRK b on a.SalesOrder = b.SalesOrder
where b.SalesOrder IS NULL


--MW 04012018  update to new ids for account linkage
update SFDC_OPTY_TRK set
PartnerId = p.ShoreTelId_SAP,
CustomerId =c.ShoreTelId_SAP
from SFDC_OPTY_TRK a inner join
SFDC_SAP_AX_ID_MAP p on a.PartnerId = convert(VarChar(15),p.OtherERPNo) inner join
SFDC_SAP_AX_ID_MAP c on a.CustomerId = convert(VarChar(15),c.OtherERPNo) 
where a.OrderCreateStatus = 'N'

/* moving to Job Step
  -- Catch ALL
 INSERT INTO SFDC_OPTY_TRK(
Source, OrderDate, SalesOrder, PartnerId, CustomerId, CustomerName, CustomerPhone, EmailDomain, ReqShipDate,
		PONumber, OrderType	, CustBuild	 )
select 
		a.Source, 
		a.OrderDate, 
		a.SalesOrder, 
		a.PartnerId, 
		a.CustomerId, 
		a.CustomerName, 
		a.CustomerPhone, 
		a.EmailDomain, 
		--a.EdiOrder, 
		--a.OrderType,
		a.ShippingDateRequested,
		a.PONum, 
		a.OrderType,
		CASE WHEN a.OrderType = 'I' Then 'Initial'
			 When a.OrderType = 'S' Then 'Support'
			 ELSE 'AddOn' END AS CustBuild
FROM
	[V_SFDC_AX_ORDERS_ALL] a  
where a.SalesOrder IN
(
  select Distinct SalesOrder from SFDC_AX_BILLING_TRK where Status = 'N'
  and SalesOrder Not IN 
  (Select SalesOrder from SFDC_OPTY_TRK where Source = 'AX')
)
*/


--Update Id from Customer table for known accounts
update SFDC_OPTY_TRK set CustomerSfdcId = b.SfdcId from
SFDC_OPTY_TRK a inner join
SVLCORPSILO1.MEGASILO.dbo.CUSTOMERS b on a.CustomerId = b.ImpactNumber collate database_default
where a.CustomerSfdcId is null


--MW 09222015  Custom Per Bonnie/Ben.  All Dicker Telstra orders go to that account and NOT the reseller in the order.
Update
SFDC_OPTY_TRK  set PartnerId = '738368'
where PartnerId <> '738368' and
SalesOrder IN (
select distinct SalesOrder  from AX_BOOKINGS
where   BillTo = '738368'
)

--MW 05232017  Update reseller from AX, happens if reseller is updated in AX after record is imported here
update SFDC_OPTY_TRK set PartnerId = b.IVARId , OrderCreateStatus = 'N' 
 from 
 SFDC_OPTY_TRK a inner join
 (
 select a.SalesOrder, b.IVARId from
SFDC_OPTY_TRK  a (nolock) inner join
(Select SalesOrder, IVARId, COUNT(*) AS xxx from AX_BILLINGS  (nolock) 
where isnumeric(IVARId) =1
Group by SalesOrder, IVARId) b on a.SalesOrder = b.SalesOrder
where a.PartnerId <> '738368'
and a.PartnerId <> b.IVARId
) b on a.SalesOrder = b.SalesOrder


-- MW 10142015 QMS Orders are coming in with TBD as customer id...WTF.  Update id from Megasilo
 update SFDC_OPTY_TRK set CustomerSfdcId = b.AccountID
 from SFDC_OPTY_TRK a inner join
 SVLCORPSILO1.MEGASILO.dbo.OPPORTUNITY b on a.OptyId = b.OpportunityID collate Database_default
 and a.CustomerSfdcId is null



 -- MW 12162015 Load shipping info for SFDC
insert into SFDC_ORDER_SHIP_ADDR
(a.SalesOrder	,
a.ShipState	,
a.ShipPostalCode	,
a.ShipCountry 
)
select a.SalesOrder	,
a.ShipState	,
a.ShipPostalCode	,
a.ShipCountry
from  V_SFDC_ORDER_SHIP_ADDR a left outer join
 SFDC_ORDER_SHIP_ADDR b on a.SalesOrder = b.SalesOrder
where  b.SalesOrder IS NULL




