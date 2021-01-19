


-- =============================================
-- MW 05102013 initializes SFDC BILL Tables
-- ============================================= select Min(InvoiceDate) from V_COM_SFDC


CREATE PROCEDURE   [dbo].[initSFDCBill] AS


-- adding to end
--truncate table SFDC_BILL_AUDIT_SO

--keeping table
--truncate     table SFDC_BILL_ORDER_TRK


--Create DUp Lookup
--  Will need to report on this.
--

-- MW 08222013
-- this table tracks invoices that cannot be deleted for the loading time period.
truncate table SFDC_BILL_ZOMBIE_INV


--Get Billings
drop table SFDC_BILL_BILLINGS

SELECT     
		Invoice, 
		InvoiceDate, 
		SalesOrder, 
		OrderDate, 
		ImpactNumber, 
		BillingsComp, 
		MgnCompUplifted, 
		PartnerSfdcId, 
		PartnerG,
		OrigSalesArea,
		FiscalQuarterCommission, 
        CalendarMonthCommission, 
        CASE WHEN isnull(GOV, 'x') = 'GOV' then 1 else 0 end as GOV, 
        CASE WHEN isnull(MAP, 'x') = 'MAP' then 1 else 0 end as MAP, 
        CustSE_ID ,
        SalesArea as AXTerritoryCode,
		EndCustBuild,
		QmsOrderNumber,
		CustomerPo,
		REVtype,
		GOVclass,
		OrderType,
		EndCustName,
		EndCust
        INTO SFDC_BILL_BILLINGS
FROM         
	V_COM_SFDC
WHERE     --(InvoiceDate > GETDATE() - 139) loading from JAN now  select getdate()-139
-- REMEMBER TO CHANGE IN ORCH PARAMS TOO!!!!!
-- ALSO NEED TO CHANGE IN DELETE BELOW
 InvoiceDate >= CONVERT(CHAR(10), '04-01-2015', 101)
 --InvoiceDate < CONVERT(CHAR(10), '07-01-2011', 101)
--
--Use below to reload
--( InvoiceDate >= CONVERT(CHAR(10), '01-01-2013', 101) AND
-- InvoiceDate < CONVERT(CHAR(10), '04-01-2013', 101) )
-- )

-- need to delete where orderdate is out of range of load date and there is an invoice in range
-- this causes dupes in sfdc since the order would never be deleted and the invoice would
-- be created over and over.  MW 07262013

--  

-- done in Cast iron mw 08232013
/*
delete from SFDC_BILL_BILLINGS where 
 (InvoiceDate Between CONVERT(CHAR(10), '04-03-2013', 101)  and  CONVERT(CHAR(10),getdate()-2, 101))  -- need yesterdays of course
      AND OrderDate < CONVERT(CHAR(10), '04-03-2013', 101)
*/




-- **************************************
-- sick and tired of all the bullshit, aint got no time for this
 -- MW 03052015 update to end customer territory as defined in SFDC
 -- This overwrites HOAs remap process
 update SFDC_BILL_BILLINGS
 set AXTerritoryCode = b.AxCode
 from
 SFDC_BILL_BILLINGS a inner join
 CUSTOMERS b on a.EndCust = b.ImpactNumber
 where  a.AXTerritoryCode <> b.AxCode collate database_DeFAULT
 and a.AXTerritoryCode NOT LIKE '%XX%'
 --
 -- Now apply the remaps
 --  SFDC_BILL_REMAP is supplied by Kathryn
  update SFDC_BILL_BILLINGS
 set AXTerritoryCode = b.SalesArea
 from
SFDC_BILL_BILLINGS a inner join
SFDC_BILL_REMAP b on a.EndCust = b.EndCust
 where  a.AXTerritoryCode <> b.SalesArea collate database_DeFAULT
-- ***************************


drop Table SFDC_BILL_ORDER_DUP

select SalesOrder INTO SFDC_BILL_ORDER_DUP FRom
(
select SalesOrder, COunt(*) as s from (

SELECT     
	SalesOrder, 
	isnull(OrderDate, InvoiceDate) as OrderDate, 
	PartnerSfdcId,
	CustSE_ID as EndCust, 
	GOV, 
    MAP,
	Sum(BillingsComp) as Billings  
 FROM          SFDC_BILL_BILLINGS
group by 	
		SalesOrder, 
		isnull(OrderDate, InvoiceDate), 
		PartnerSfdcId,
		CustSE_ID ,
		GOV,
		MAP
		) a
		group by SalesOrder having count(*) >1
)b

--delete from Billings SFDC has unique orders
delete from SFDC_BILL_BILLINGS where SalesOrder IN (select SalesOrder from SFDC_BILL_ORDER_DUP)


--Now load order table, has to be unique orders
truncate table SFDC_BILL_ORDER_TRK

Insert into SFDC_BILL_ORDER_TRK ( SalesOrder,	OrderDate	,PartnerSfdcId	,EndCust	,Billings, GOV,MAP )
(
SELECT     
	SalesOrder, 
	isnull(OrderDate, InvoiceDate) as OrderDate, 
	PartnerSfdcId,
	EndCust as EndCust, 
	--SalesArea,
	
	Sum(BillingsComp) as Billings , GOV,
	MAP 
	-- into SFDC_BILL_ORDER_TRK
 FROM          SFDC_BILL_BILLINGS
group by 	
		SalesOrder, 
		isnull(OrderDate, InvoiceDate), 
		PartnerSfdcId,
		EndCust ,
		GOV,
		MAP
)


--not sure if using
truncate table SFDC_BILL_AUDIT_SO





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[initSFDCBill] TO [ITApps]
    AS [dbo];

