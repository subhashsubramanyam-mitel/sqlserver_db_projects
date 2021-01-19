-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-09
-- Description:	Sync BillingCategory data based on AX Sale line and AX tax Line
-- Change Log: 
-- =============================================
create PROCEDURE ax.UspSyncBillingCategory 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	-- DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);
	
	PRINT convert(varchar,getdate(),14) + N': Begin syncing AX Billing Category data';

	INSERT INTO enum.BillingCategory
	SELECT 
		CASE 
			WHEN TAXTYPEDESC like '%Sale%Tax%' THEN 'Tax'
			ELSE 'Surcharge' 
			END as GroupName,
		TAXTYPEDESC as Name
	FROM (
		 select distinct TAXTYPEDESC from ax.TaxLine TL
		  left join enum.BillingCategory BC on BC.Name = TL.TAXTYPEDESC
		  inner join ax.SalesLine SL on SL.SALESID = TL.SALESID and SL.LINENUM = TL.LINENUM

		  where BC.Id is null and SL.SHIPPINGDATEREQUESTED >= @lastSync
		)foo
		
		
	-- Manual Credits FROM SALES LINE, everything else is already synced with Line ITem
			INSERT INTO enum.BillingCategory
	SELECT 
		CASE 
			WHEN Name like 'Monthly%' THEN 'Monthly'
			WHEN Name like 'Setup%' THEN 'OneTime'
			WHEN Name like 'Credit%' THEN 'Credit'
			ELSE 'Unclassified' 
			END as GroupName,
		Name as Name
	FROM (
		select distinct LI.Name from ax.SalesLine LI
		left join enum.BillingCategory BC on BC.Name = LI.Name
		where BC.Name is null and LI.SEMPOSTINGORDERTYPE = 'SKY-CR'
		and LI.SHIPPINGDATEREQUESTED >= @lastSync
		)foo


	PRINT convert(varchar,getdate(),14) + N': End syncing AX Billing Category data';

END
