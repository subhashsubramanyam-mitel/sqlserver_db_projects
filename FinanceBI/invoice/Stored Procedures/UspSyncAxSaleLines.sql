-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-02-14
-- Description:	Sync AxItem data
-- Change Log:  

-- =============================================
create PROCEDURE invoice.UspSyncAxSaleLines 
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);
							
	PRINT convert(varchar,getdate(),14) + N': Begin syncing AXSaleLines data';
	
	DELETE from invoice.AxSaleLines 
		WHERE InvoiceMonth >= @lastSync;
		

	INSERT into invoice.AxSaleLines 
		SELECT
			CAST(LI.LineItemId as bigint)*10000+
				coalesce(CASE WHEN LI.ProductId is null THEN AP.Id else LI.ProductId END,0) as AxId,
			LI.LineItemId, 
			CASE WHEN LI.ProductId is null THEN AP.Id else LI.ProductId END as ProductId,
			LI.KitChecksumValue, 
			LI.AxItemId, 
			LI.SalesPrice,
			LI.SalesQty,
			dbo.UfnFirstOfMonth(LI.ShippingDateRequested) as InvoiceMonth,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodStart) as DatePeriodStart,
			dbo.UfnUTCTimeToLocalDate(LI.DatePeriodEnd) as DatePeriodEnd,
			LI.Name,
			LI.LocationId,
			LI.AddressId, -- remove address
			LI.City,
			LI.State,
			LI.zipCode,
			LI.Country,
			LI.InvoiceId,
			LI.InvoiceGroupId,
			LI.ServiceGroupName,
			LI.BillingContact,
			CASE WHEN BC.Id is null THEN 0 ELSE BC.Id END as BillingCategoryId
		FROM 
			M5DB.M5DB.dbo.VwAxSaleLines LI with(nolock)
			left join enum.BillingCategory BC on BC.Name = LI.Name
			left Join enum.Product AP on AP.Name = LI.Name and Li.productId is null -- to get ALT Product Name for Usage, Surcharge
		WHERE
			LI.ShippingDateRequested >= @lastSyncUTC; 

	PRINT convert(varchar,getdate(),14) + N': End syncing Ax Sales Lines data';

END
