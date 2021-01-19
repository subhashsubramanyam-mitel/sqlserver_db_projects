 Create view PM_SALESDATA as 
 -- MW 05042018  Combined view for PM. Post AX.

 select *   from
 (
SELECT         Source, OrderDate, Invoice, VADId, VADName, InvoiceDate, SalesOrder, CustomerPo, ImpactNumber, BillToName, EndCust, EndCustName, SKU, QTY, NetSalesUSD, ShipPostalCode, ShipCity, ShipState, ShipCountry, 
                         StockCode, ItemDesc, CUSTGROUP, OrigSalesOrder, OrderType, GMFamily, --PartnerGId,  PartnerG, 
						  RevType, PartnerId, Partner, AX_InvoiceDateUTC, ItemGroupName, SC_Billings, ItemCost, RequestedShipDate, SalesPoolId, ChampLevel, 
                         CustomerVersion, Theatre, Region, CustomerVertical, CustomerVerticalClass, ExtendedNetPriceLocal, CurrencyCode
FROM            PM_SALESDATA_ARCHIVE
 UNION ALL
 select  Source, OrderDate, Invoice, VADId, VADName, InvoiceDate, SalesOrder, CustomerPo, ImpactNumber, BillToName, EndCust, EndCustName, SKU, QTY, NetSalesUSD, ShipPostalCode, ShipCity, ShipState, ShipCountry, 
                         StockCode, ItemDesc, CUSTGROUP, OrigSalesOrder, OrderType, GMFamily, --PartnerGId  collate database_default ,  PartnerG  collate database_default ,  
						 RevType, PartnerId, Partner, AX_InvoiceDateUTC, ItemGroupName, SC_Billings, ItemCost, RequestedShipDate, SalesPoolId, ChampLevel, 
                         CustomerVersion, Theatre, Region, CustomerVertical, CustomerVerticalClass, ExtendedNetPriceLocal, CurrencyCode from 
				V_PM_SAP_DATA
				 

UNION ALL
 select  Source, OrderDate, Invoice, VADId, VADName, InvoiceDate, SalesOrder, CustomerPo, ImpactNumber, BillToName, EndCust, EndCustName, SKU, QTY, NetSalesUSD, ShipPostalCode, ShipCity, ShipState, ShipCountry, 
                         StockCode, ItemDesc, CUSTGROUP, OrigSalesOrder, OrderType, GMFamily, --PartnerGId   ,  PartnerG   ,
						   RevType, PartnerId, Partner, AX_InvoiceDateUTC, ItemGroupName, SC_Billings, ItemCost, RequestedShipDate, SalesPoolId, ChampLevel, 
                         CustomerVersion, Theatre, Region, CustomerVertical, CustomerVerticalClass, ExtendedNetPriceLocal, CurrencyCode from 
				V_PM_POS_DATA
				) a