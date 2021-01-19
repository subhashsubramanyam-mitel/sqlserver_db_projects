-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-01-20
-- Description:	Sync Product data
-- Change Log:  2013-09-20 adapting to revised price plan structure
-- =============================================
CREATE PROCEDURE [enum].[UspSyncProduct] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Product data';

	MERGE enum.Product as target
	USING (
		SELECT 
			P.Id,
			P.ServiceClassId,
			P.Name,
			P.ShortName,
			P.InvoiceLabel,
			P.Catalogorder,
			P.IsActive,
			P.LichenPlanId,
			coalesce(PP.NRC, 0.0) as DefaultOneTimeCharge,
			coalesce(PP.MRR, 0.0) as DefaultMonthlyCharge,
			P.MRR_SKU,
			P.NRR_SKU
		FROM 
			M5DB.Billing.dbo.VwProduct P with(nolock)
			left join M5DB.M5DB.dbo.VwProductDefaultPrice PP on PP.ProductId = P.Id and PP.Recency =1
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED and (
			target.ServiceClassId <> source.ServiceClassId or
			target.Name <> source.Name or
			coalesce(target.ShortName,'') <> coalesce(source.ShortName, '') or
			target.InvoiceLabel <> source.InvoiceLabel  or
			coalesce(target.CatalogOrder, -1) <> coalesce(source.CatalogOrder, -1)  or
			target.IsActive <> source.IsActive  or
			target.LichenPlanId <> source.LichenPlanId  or
			target.DefaultMonthlyCharge <> source.DefaultMonthlyCharge  or
			target.DefaultOneTimeCharge <> source.DefaultOneTimeCharge  or
			coalesce(target.MRR_SKU,'') <> coalesce(source.MRR_SKU,'') or
			coalesce(target.NRR_SKU,'') <> coalesce(source.NRR_SKU,'')
			)
		THEN	
		UPDATE SET 
			target.ServiceClassId = source.ServiceClassId,
			target.Name = source.Name,
			target.ShortName = source.ShortName,
			target.InvoiceLabel = source.InvoiceLabel,
			target.CatalogOrder = source.CatalogOrder,
			target.IsActive = source.IsActive,
			target.LichenPlanId = source.LichenPlanId,
			target.DefaultMonthlyCharge = source.DefaultMonthlyCharge,
			target.DefaultOneTimeCharge = source.DefaultOneTimeCharge ,
			target.MRR_SKU = source.MRR_SKU,
			target.NRR_SKU = source.NRR_SKU
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, ServiceClassId, Name, ShortName, InvoiceLabel, CatalogOrder, IsActive, LichenPlanId, DefaultMonthlyCharge, DefaultOneTimeCharge, MRR_SKU, NRR_SKU )
		VALUES ( Id, ServiceClassId, Name, ShortName, InvoiceLabel, CatalogOrder, IsActive, LichenPlanId, DefaultMonthlyCharge, DefaultOneTimeCharge, MRR_SKU, NRR_SKU )
	OUTPUT 'enum.Product', $action INTO SyncChanges;

	-- Update SKUs from description
	update P
	set MRR_SKU = PD.SKU

	from enum.Product P 
	inner join m5db_prod.m5db.dbo.billing_AxSKU_ByDescription PD on PD.DescriptionCompressed = REPLACE(P.Name, ' ', '')
	where MRR_SKU is null and NRR_SKU is null 

	PRINT convert(varchar,getdate(),14) + N': End syncing Product data';

END
