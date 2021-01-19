

CREATE procedure [dbo].[SSCPOSDeleteNulls] as
--MW 10202017 new import for SSC POS Spreadsheet from SSC_POS_IMPORT orch
delete from POS_RAW_SSC_IMPORT
where InvoiceDate is null

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSCPOSDeleteNulls] TO [ITApps]
    AS [dbo];

