
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2015-04-15
-- Description:	Update Monthly NRR 
-- Change Log: 
-- =============================================
CREATE PROCEDURE [invoice].[UspLoadMonthlyNRR] 
	-- Add the parameters for the stored procedure here
	@InvMonth date = NULL
AS
Declare @InvMonthEnd date = DateAdd(day, 25, @InvMonth); -- 25th day ok
BEGIN

-- Delete from table if already present
delete from invoice.MonthlyNRR where InvoiceMonth = @InvMonth;

-- Insert fresh
	
	insert into invoice.MonthlyNRR 
		(InvoiceMonth, InvoiceDay, ServiceId, ProdServiceClassId, OneTimeCharge, LineItemId, OrderId, ProductId, CurrencyId)
		select @InvMonth InvoiceMonth, @InvMonth InvoiceDay, NR.ServiceId, 
			Max(P.ServiceClassId) ProductSvcClassId, SUM(NR.OneTimeCharge) NRR, 
			MAX(NR.LineItemId) LineItemId,  MAX(OrderId) OrderId, MAX(NR.ProductId) ProductId, MAX(SP.CurrencyId) -- NOTE assumes Service has correct CurrencyId
		from invoice.SPItem NR
		left join enum.BillingCategory BC on BC.Id = NR.BillingCategoryId
		left join oss.VwServiceProduct_Ranked_EX SP on 
				SP.ServiceId = NR.ServiceId and SP.ProductId = NR.ProductId and SP.RankNum = 1
		left join enum.Product P on P.Id = NR.ProductId 
		where 
		BC.GroupName = 'OneTime' and BC.Name not like '%Handling%'
		and	NR.DateGenerated between @InvMonth and @InvMonthEnd
		group by NR.ServiceId

-- Update MRR Category
	update NR
		set AssociatedMRRCategory = IA.Category
	from invoice.MonthlyNRR NR
	inner join invoice.MonthlyIACP IA on IA.InvoiceMonth = NR.InvoiceMonth and IA.ServiceId = NR.ServiceId
		and IA.Category in ('Install' , 'Anomaly', 'ChangeProductTo')
	where NR.InvoiceMonth = @InvMonth;

	PRINT convert(varchar,getdate(),14) + N': End loading Monthly NRR';

END

