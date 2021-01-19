-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-04-14
-- Description:	Sync State Telecom Surcharge data
-- Change Log:  

-- =============================================
create PROCEDURE invoice.UspSyncSTC 
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);
							
	PRINT convert(varchar,getdate(),14) + N': Begin syncing STC data';
	
	DELETE from invoice.StateTelecomSurcharge 
		WHERE InvoiceMonth >= @lastSync;
		

	INSERT into invoice.StateTelecomSurcharge 
		SELECT * 			
		FROM 
			M5DB.Billing.dbo.Inv_StateTelecomSurcharge F with(nolock)
		WHERE
			F.InvoiceMonth >= @lastSync; 

	PRINT convert(varchar,getdate(),14) + N': End syncing STC data';

END
