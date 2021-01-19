
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description: Top level processing of Rating, Costing, Revenue Import, and Prepare for Export to Phoenix
--
-- Change Log:  Incorporate Connect in addition to Bobl
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspRateCostRevenueForPhoenix] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
Exec cdr.UspRateTDXOutboundCalls @InvoiceMonth -- 42 minutes

Exec cdr.UspRateInboundCalls @InvoiceMonth -- 8.5 minutes
Exec cdr.UspRateInboundConnectCalls @InvoiceMonth -- 8.5 minutes

Exec cdr.UspCopyBoblOutboundCalls @InvoiceMonth -- 7 minutes
Exec cdr.UspCopyConnectOutboundCalls @InvoiceMonth -- 7 minutes

Exec cdr.UspRateDirInfoCalls @InvoiceMonth  -- 0.5 minute

Exec cdr.UspCopyBoblOverageCharge @InvoiceMonth -- 0.1 minute
Exec cdr.UspCopyConnectOverageCharge @InvoiceMonth -- 0.1 minute

Exec cdr.UspCopyProfileUsageComponentOfMRR @InvoiceMonth -- 12 minutes
Exec cdr.UspFinalUpdateCostAndCharge @InvoiceMonth -- 9.5 minutes

Exec cdr.UspPrepareForExportToPhoenix @InvoiceMonth -- 5 minutes

END
