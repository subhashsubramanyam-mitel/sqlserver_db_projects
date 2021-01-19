
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Nov 28, 2014
-- Description:	Manual Credit by Account 
-- =============================================
CREATE FUNCTION [rollup].[UfnManualCreditByAccount] 
(	
	@InvMonth  Date -- Invoice Month
)
RETURNS TABLE 
AS
RETURN 
(
	select
	 A.AccountId,
	 Sum(LI.SalesQty) Quantity,  Sum(LI.Amount) Credit
	 from ax.VwInvoiceLine LI
	 inner join company.InvoiceGroup IG on IG.Id = LI.InvoiceGroupId
	 inner join company.AccountAttr A on A.AccountId = IG.AccountId
	where LI.ChargeCategory = 'Credit - Manual' and LI.INvoiceMonth = @InvMonth 
	and A.IsBillable = 1
	group by A.AccountId 
)
