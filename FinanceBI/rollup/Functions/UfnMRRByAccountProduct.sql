
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Nov 28, 2014
-- Description:	Monthly MRR By  Account Product incl Location Discount 
-- Change Log: 12/8/2004, Tarak, added Non-pivot Fixed Cost
-- =============================================
CREATE FUNCTION [rollup].[UfnMRRByAccountProduct] 
(	
	@InvMonth  Date -- Invoice Month
)
RETURNS TABLE 
AS
RETURN 
(
	select
	 A.AccountId, LI.ProductId, 
	 Sum(LI.Quantity) Quantity,  Sum(LI.Charge) MRR, 
	 Sum(Case WHEN FUC.Id is not null THEN (LI.Quantity * FUC.Cost) ELSE 0.0 END) NPFC
	 from invoice.VwLineItem LI
	 inner join company.InvoiceGroup IG on IG.Id = LI.InvoiceGroupId
	 inner join company.AccountAttr A on A.AccountId = IG.AccountId
	 inner join enum.VwProduct P on P.[Prod Id] = LI.ProductId
	 left join rollup.FixedUnitCost FUC on 
		(FUC.ProdCategory = P.[Prod Category] or FUC.ProdCategory='') and
		(FUC.ProdSubCategory = P.[ProdSubCategory] or FUC.ProdSubCategory = '') and
		(FUC.ProdClassLeafName = P.[Class Leaf Name] or FUC.ProdClassLeafName = '') and
		(FUC.PrimaryHandset = P.PrimaryHandset or FUC.PrimaryHandset = '')
	where LI.ChargeCategory = 'MRR' and LI.DateGenerated between @InvMonth and DateAdd(day, 25, @InvMonth) 
	and A.IsBillable = 1
	group by A.AccountId, LI.ProductId
)

