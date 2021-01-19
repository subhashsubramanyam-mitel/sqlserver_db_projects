-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-05-07
-- Description:	Sync Order Item data
-- =============================================
CREATE PROCEDURE [oss].[UspSyncOrderItemNEW] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing OrderItem NEW data';

	Declare @SyncTIme Varchar(12) = Convert(varchar(10), DateAdd(day, 0, @lastSync), 120); -- 0 day safety window
	DECLARE @SS varchar(8000) = '
	MERGE oss.[OrderItem] as target
	USING (
		SELECT * FROM OpenQuery([M5DB],
	''select * from Billing.dbo.UfnOrderItemsToBeSynced(''''' + @SyncTime + ''''')'')
	)
	AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.OrderItemTypeId = source.OrderItemTypeId, 
			target.OrderId = source.OrderId, 
			target.Description = source.Description, 
			target.DateProcessed = source.DateProcessed, 
			target.LocationId = source.LocationId, 
			target.DateEffective = source.DateEffective, 
			target.ServiceClassId = source.ServiceClassId, 
			target.InvoiceLabel = source.InvoiceLabel, 
			target.Quantity = source.Quantity, 
			target.CircuitCarrierCompanyId = source.CircuitCarrierCompanyId, 
			target.DateModified = source.DateModified, 
			target.DateCreated = source.DateCreated, 
			target.ModifiedBy = source.ModifiedBy, 
			target.CreatedByPersonId = source.PersonId, 
			target.InvoiceGroupId = source.InvoiceGroupId, 
			target.ProductId = source.ProductId, 
			target.InvoiceServiceGroupId = source.InvoiceServiceGroupId, 
			target.MRR = source.MRR, 
			target.NRC = source.NRC, 
			target.PricePlanPriceId = source.PricePlanPriceId, 
			target.PrevMRR = source.PrevMRR, 
			target.PrevNRC = source.PrevNRC, 
			target.PrevPricePlanPriceId = source.PrevPricePlanPriceId,
			target.CurrencyId = source.CurrencyId 
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Id, OrderItemTypeId, Orderid, [Description], DateProcessed, LocationId, DateEffective,
			ServiceClassId, InvoiceLabel,Quantity, CircuitCarrierCompanyId,
			DateModified, DateCreated, ModifiedBy, CreatedByPersonId,
			InvoiceGroupId, ProductId, InvoiceServiceGroupId, 
			MRR, NRC, PricePlanPriceId, PrevMRR, PrevNRC, PrevPricePlanPriceId, CurrencyId  ) 
		VALUES (Id, OrderItemTypeId, Orderid, [Description], DateProcessed, LocationId, DateEffective,
			ServiceClassId, InvoiceLabel,Quantity, CircuitCarrierCompanyId,
			DateModified, DateCreated, ModifiedBy, PersonId,
			InvoiceGroupId, ProductId, InvoiceServiceGroupId, 
			MRR, NRC, PricePlanPriceId, PrevMRR, PrevNRC, PrevPricePlanPriceId, CurrencyId  ) 
	OUTPUT ''oss.OrderItem'', $action INTO SyncChanges;
	';
	--print @SS;
	EXEC (@SS);
	PRINT convert(varchar,getdate(),14) + N': End syncing OrderItem NEW data';

END
