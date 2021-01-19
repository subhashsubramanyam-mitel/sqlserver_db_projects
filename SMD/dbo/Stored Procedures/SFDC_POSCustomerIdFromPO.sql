

CREATE procedure [dbo].[SFDC_POSCustomerIdFromPO] as
--MW 10142015 For Orders/Invoices Orch.  Reads from this table since it cant do a ditributied query

--MW 12012015  this wasnt working, turing off.  SSC submitting several POs for same order so logic doesnt work right.

--IF OBJECT_ID('POS_AX_CUSTOMERID', 'U') IS NOT NULL
--drop table  POS_AX_CUSTOMERID

truncate table POS_AX_CUSTOMERID

--select SalesOrder, SfdcId INTO POS_AX_CUSTOMERID  from V_POS_AX_CUSTOMERID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SFDC_POSCustomerIdFromPO] TO [ITApps]
    AS [dbo];

