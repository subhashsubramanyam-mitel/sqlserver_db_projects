
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2015-04-15
-- Description:	Update Incr NRR 
-- Change Log: 
-- =============================================
CREATE PROCEDURE [expinvoice].[UspLoadIncrNRR] 
	-- Add the parameters for the stored procedure here
	@InvMonth date = NULL,
	@InvDay date = NULL  --  assume there is only one InvoiceDay
AS
Declare @InvMonthEnd date = DateAdd(day, 25, @InvMonth); -- 25th day ok
BEGIN

-- Delete from table if already present
delete from expinvoice.IncrNRR 
where InvoiceMonth = @InvMonth ; -- delete next month completely


-- Insert fresh
	
	insert into expinvoice.IncrNRR 
		(InvoiceMonth, InvoiceDay, ServiceId, ProdServiceClassId, OneTimeCharge, LineItemId, OrderId, ProductId, CurrencyId)
		select @InvMonth InvoiceMonth, @InvDay InvoiceDay, 
				NR.ServiceId, 
			Max(P.ServiceClassId) ProductSvcClassId, SUM(NR.OneTimeCharge) NRR, 
			MAX(NR.LineItemId) LineItemId,  MAX(OrderId) OrderId, MAX(NR.ProductId) ProductId, MAX(SP.CurrencyId) -- NOTE assumes Service has correct CurrencyId
		from expinvoice.SPItem NR
		left join enum.BillingCategory BC on BC.Id = NR.BillingCategoryId
		left join oss.VwServiceProduct_Ranked_EX SP on 
				SP.ServiceId = NR.ServiceId and SP.ProductId = NR.ProductId and SP.RankNum = 1
		left join enum.Product P on P.Id = NR.ProductId 
		where 
		BC.GroupName = 'OneTime' and BC.Name not like '%Handling%'
		and	NR.DateGenerated = @InvDay
		group by NR.ServiceId

-- Update MRR Category
	update NR
		set AssociatedMRRCategory = IA.Category
	from expinvoice.IncrNRR NR
	inner join expinvoice.IncrIACP IA on IA.InvoiceDay = NR.InvoiceDay and IA.ServiceId = NR.ServiceId
		and IA.Category in ('Install' , 'Anomaly', 'ChangeProductTo')
	where NR.InvoiceMonth = @InvMonth and NR.InvoiceDay = @InvDay

	PRINT convert(varchar,getdate(),14) + N': End loading Incr NRR';

END

