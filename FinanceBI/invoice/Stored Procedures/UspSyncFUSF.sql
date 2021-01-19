-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-04-14
-- Description:	Sync FUSF data
-- Change Log:  

-- =============================================
create PROCEDURE invoice.UspSyncFUSF 
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);
							
	PRINT convert(varchar,getdate(),14) + N': Begin syncing FUSF data';
	
	DELETE from invoice.FUSF 
		WHERE InvoiceMonth >= @lastSync;
		

	INSERT into invoice.FUSF 
		SELECT * 			
		FROM 
			M5DB.Billing.dbo.Inv_FUSF F with(nolock)
		WHERE
			F.InvoiceMonth >= @lastSync; 

	PRINT convert(varchar,getdate(),14) + N': End syncing FUSF data';

END
