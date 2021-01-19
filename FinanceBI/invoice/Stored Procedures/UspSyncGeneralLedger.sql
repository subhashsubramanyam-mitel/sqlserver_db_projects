-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-11-29
-- Description:	Sync General Ledger
-- Change Log: 2013-02-13, Performance tuning, rewriting without MERGE
-- =============================================
create PROCEDURE invoice.UspSyncGeneralLedger 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);

	PRINT convert(varchar,getdate(),14) + N': Begin syncing General Ledger data';

	DELETE from invoice.GeneralLedger
		WHERE DocDate >= @lastSync;

	INSERT into invoice.GeneralLedger			
		SELECT  
			SOPTYPE as SOPType,
			SOPNUMBE as SOPNumber,
			DOCID as DocId,
			CUSTNMBR as CustomerNumber,
			PRBTADCD as BillingAddrCode,
			DOCDATE as DocDate,
			BACHNUMB as BatchNumber,
			DOCAMNT as DocAmount,
			SUBTOTAL as SubTotal,
			TAXAMNT as TaxAmount,
			VOIDSTTS as VoidStatus,
			CASE WHEN (DOCDATE < '2012-11-01') THEN IGL.Id ELSE IGM.Id END as InvoiceGroupId,
			dbo.UfnFirstOfMonth(DocDate) as InvoiceMonth,
			CASE WHEN (DOCDATE < '2012-11-01') THEN IL.Id ELSE IM.Id END as InvoiceId,
			CASE WHEN (DOCDATE < '2012-11-01') THEN LL.Id ELSE LM.Id END as DefaultLocationId	
		FROM m5db.m5db.dbo.VwGeneralLedger as SOP
		LEFT JOIN company.InvoiceGroup IGM
			on IGM.Id = SOP.NumCUST
		LEFT JOIN  company.InvoiceGroup IGL
			on IGL.LichenInvoiceGroupId = SOP.NumCUST	
		LEFT JOIN invoice.Invoice IM
			on IM.Id = SOP.NumSOP
		LEFT JOIN invoice.Invoice IL
			on IL.LichenInvoiceId = SOP.NumSOP
		LEFT JOIN company.Location LM
			on LM.Id = SOP.NumPRBTADCD
		LEFT JOIN company.Location LL
			on LL.LichenLocationId = SOP.NumPRBTADCD
		WHERE SOP.DOCDATE >= @lastSync; -- NOTE: as of 2013-02-14, DOCDATE wasn't UTC

	PRINT convert(varchar,getdate(),14) + N': End syncing General Ledger data';
	
END
