




CREATE VIEW [dbo].[V_POS_ALL]
AS
select 
		a.Invoice, 
		VADId, 
		c.NAME as VADName,
		InvoiceDate, 
		SalesOrder, 
		CustomerPO, 
		a.PartnerId as ImpactNumber, 
		PartnerName, 
		CustomerId, 
		CustomerName, 
		a.Sku, 
		Qty, 
		Billings, 
		ShipPostalCode,
		ShipCity,
		ShipState,
		ShipCountry,
		b.StockCode,
		b.StockCodeDesc,
		b.GmFamily as GMFamily,
		c.CustGroup as CUSTGROUP,
		p.PartnerGId,
		p.PartnerG as PartnerG,
		i.ItemGroupId,
		i.ItemGroupName,
		i.AxRevType,
		isnull(i.ItemCostCurrent, 0) as ItemCostCurrent,
		-- MW 03042015 Adding currency Info
		'USD' as CurrencyCode,
		Billings as LocalBillings
from --POS_RAW_SSC a left outer join
	--MW 10202017 NEW POS IMPORT FROM ORCH
	  POS_RAW_SSC_IMPORT a left outer join
	 PRODUCT_LINE b on  SUBSTRING(a.Sku,0,6)  = b.Sku left outer join
	 SVLCORPAXDB1.PROD.dbo.CustTable c on a.VADId = c.ACCOUNTNUM   left outer join
	  V_PARTNERG p on a.PartnerId = p.PartnerId collate database_Default  left outer join
	  AX_ITEMS i on SUBSTRING(a.Sku,0,6)  = i.SKU
union all
select 
		--Create invoiceId for ING mw 10292014
		a.Invoice,
		VADId, 
		c.NAME as VADName,
		InvoiceDate, 
		SalesOrder, 
		CustomerPO, 
		a.PartnerId as ImpactNumber, 
		PartnerName, 
		CustomerId, 
		CustomerName, 
		a.Sku, 
		Qty, 
		Billings, 
		ShipPostalCode,
		ShipCity,
		ShipState,
		ShipCountry,
		b.StockCode,
		b.StockCodeDesc,
		b.GmFamily	 as GMFamily,
		c.CustGroup as CUSTGROUP,
		p.PartnerGId,
		p.PartnerG as PartnerG,
		i.ItemGroupId,
		i.ItemGroupName,
		i.AxRevType,
		isnull(i.ItemCostCurrent,0) as ItemCostCurrent,		
		-- MW 03042015 Adding currency Info
		'USD' as CurrencyCode,
		Billings as LocalBillings
		--<PM> Replace ING datasource from manual to CI		
--from POS_RAW_ING  a left outer join
from POS_CI_ING  a left outer join
	 PRODUCT_LINE b on  SUBSTRING(a.Sku,0,6)  = b.Sku  left outer join
	 SVLCORPAXDB1.PROD.dbo.CustTable c on a.VADId = c.ACCOUNTNUM  left outer join
	 V_PARTNERG p on a.PartnerId = p.PartnerId collate database_Default left outer join
	 AX_ITEMS i on  SUBSTRING(a.Sku,0,6)  = i.SKU
union all
select 
		a.Invoice, 
		VADId, 
		c.NAME as VADName,
		InvoiceDate, 
		SalesOrder, 
		CustomerPO, 
		a.PartnerId as ImpactNumber, 
		PartnerName, 
		CustomerId, 
		CustomerName, 
		a.Sku, 
		Qty, 
		--MW 10082015 Using Spot Rate now per meeting with Jeff/Yad
		(Billings*(r.exchrate/100))as Billings, 
		--(Billings*.97)as Billings, 
		ShipPostalCode,
		ShipCity,
		ShipState,
		ShipCountry,
		b.StockCode,
		b.StockCodeDesc,
		b.GmFamily as GMFamily,
		c.CustGroup as CUSTGROUP,
		p.PartnerGId,
		p.PartnerG as PartnerG,
		i.ItemGroupId,
		i.ItemGroupName,
		i.AxRevType,
		isnull(i.ItemCostCurrent,0) as ItemCostCurrent,
		-- MW 03042015 Adding currency Info
		'CAD' as CurrencyCode,
		Billings as LocalBillings
from POS_RAW_TD   a left outer join
	 SVLCORPAXDB1.PROD.dbo.CustTable c on a.VADId = c.ACCOUNTNUM 	  left outer join
	 PRODUCT_LINE b on  SUBSTRING(a.Sku,0,6)  = b.Sku inner join
-- MW 09092014  need to convert
	  AX_EXCHRATE r on r.currencycode = 'CAD' left outer join
	  V_PARTNERG p on a.PartnerId = p.PartnerId collate database_Default  left outer join
	  AX_ITEMS i on  SUBSTRING(a.Sku,0,6)  = i.SKU
	  









GO
GRANT SELECT
    ON OBJECT::[dbo].[V_POS_ALL] TO [POS]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_POS_ALL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_POS_ALL';

