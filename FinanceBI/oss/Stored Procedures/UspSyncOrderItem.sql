-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-05-07
-- Description:	Sync Order Item data
-- =============================================
create PROCEDURE oss.UspSyncOrderItem 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing OrderItem data';

	MERGE oss.OrderItem as target
	USING (
		SELECT 
			Id, OrderItemTypeId, Orderid, 
			case when [Description] = '' then null else [Description] end [Description], 
			dbo.UfnRoundupDay(DateProcessed) DateProcessed, 
			LocationId, 
			dbo.UfnRoundupDay(DateEffective) DateEffective,
			ServiceClassId, 
			case when InvoiceLabel = '' then null else InvoiceLabel end InvoiceLabel, 
			coalesce(Quantity,0) Quantity, CircuitCarrierCompanyId,
			DateModified, DateCreated, ModifiedBy, 
			coalesce(PersonId,0) PersonId,
			InvoiceGroupId, ProductId, InvoiceServiceGroupId, 
			coalesce(MRR,0.0) MRR, coalesce(NRC,0.0) NRC, 
			PricePlanPriceId, 
			coalesce(PrevMRR,0.0)PrevMRR, coalesce(PrevNRC,0.0)PrevNRC, 
			PrevPricePlanPriceId
		FROM 
			M5DB.M5DB.Dbo.order_OrderItem OI with(nolock)
		WHERE
			( OI.DateModified >= @lastSync )
	) AS source
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
			target.PrevPricePlanPriceId = source.PrevPricePlanPriceId 
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Id, OrderItemTypeId, Orderid, [Description], DateProcessed, LocationId, DateEffective,
			ServiceClassId, InvoiceLabel,Quantity, CircuitCarrierCompanyId,
			DateModified, DateCreated, ModifiedBy, CreatedByPersonId,
			InvoiceGroupId, ProductId, InvoiceServiceGroupId, 
			MRR, NRC, PricePlanPriceId, PrevMRR, PrevNRC, PrevPricePlanPriceId  ) 
		VALUES (Id, OrderItemTypeId, Orderid, [Description], DateProcessed, LocationId, DateEffective,
			ServiceClassId, InvoiceLabel,Quantity, CircuitCarrierCompanyId,
			DateModified, DateCreated, ModifiedBy, PersonId,
			InvoiceGroupId, ProductId, InvoiceServiceGroupId, 
			MRR, NRC, PricePlanPriceId, PrevMRR, PrevNRC, PrevPricePlanPriceId  ) 
	OUTPUT 'oss.OrderItem', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing OrderItem data';

END
