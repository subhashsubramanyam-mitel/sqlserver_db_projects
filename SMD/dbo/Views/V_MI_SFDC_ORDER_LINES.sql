CREATE View V_MI_SFDC_ORDER_LINES as 
-- MW 12072017 for MI SFDC Forecasting
SELECT     
 	a.RecId,    
	a.SalesOrder, 
	a.ShipTo,
	a.Line, 
	
	a.TotalLineQty, 
	a.NetAmount, 
	a.SKU, 
	c.Name as ProductName,
	a.LineStatus, 
	a.ShippingDateRequested, 
	CASE WHEN a.AxRevType in (4,5) then 1 else 0 end as isRecurring, 
	a.INVENTTRANSID,
	b.SupportStart,
	b.SupportEnd
FROM            
	AX_BOOKINGS AS a inner join
	MI_SFDC_ORDERS b on a.SalesOrder = b.SalesOrder left outer join
	SFDC_PRODUCTS c on a.SKU = c.SKU		collate database_Default