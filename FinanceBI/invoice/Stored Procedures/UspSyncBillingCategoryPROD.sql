

-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-07-23
-- Description:	Sync BillingCategory data
-- Change Log: 2013-02-14, Tarak, introduced incremental
-- =============================================
CREATE PROCEDURE [invoice].[UspSyncBillingCategoryPROD] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	--DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);
	
	PRINT convert(varchar,getdate(),14) + N': Begin syncing Billing Category data';

	INSERT INTO enum.BillingCategory
	SELECT 
		CASE 
			WHEN Description like 'Monthly%' THEN 'Monthly'
			WHEN Description like 'Setup%' THEN 'OneTime'
			WHEN Description like 'Credit%' THEN 'Credit'
			ELSE 'Unclassified' 
			END as GroupName,
		Description as Name
	FROM (
		select distinct Li.Description from M5DB_Prod.M5DB.dbo.billing_InvoiceLineItem LI
		left join enum.BillingCategory BC on BC.Name = LI.Description
		where BC.Name is null 
		and LI.DateGenerated >= @lastSync  --@lastSyncUTC
		)foo

	PRINT convert(varchar,getdate(),14) + N': End syncing Billing Category data';

END

