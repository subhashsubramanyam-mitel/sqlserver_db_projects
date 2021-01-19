
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Nov 28, 2014
-- Description:	Monthly Usage by Account UsageType 
-- =============================================
CREATE FUNCTION [rollup].[UfnUsageByAccountProduct] 
(	
	@InvMonth  Date -- Invoice Month
)
RETURNS TABLE 
AS
RETURN 
(
	select
	 A.AccountId, P.[Prod Id] ProductId, Sum(Quantity) Quantity,  Sum(Usage) Usage
	 from invoice.VwLineItem LI
	 inner join company.AccountAttr A on A.AccountId = LI.AccountId
	 inner join enum.VwProduct P on P.[Prod Id] = LI.ProductId
	where ChargeCategory = 'Usage' and DateGenerated between @InvMonth and DateAdd(day,-1,dateadd(month,1,@InvMonth))
	and A.IsBillable = 1
	group by A.AccountId,  P.[Prod Id])
