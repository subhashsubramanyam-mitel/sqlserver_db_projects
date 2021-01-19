﻿

 


 CREATE view [dbo].[V_HANA_BILL] as 
 -- MW 08062020 For Export To Tableau
 select  
		--"YSTSALES" as [Sold-To (Sales View)],
		"0SOLD_TO" as [Sold-to party],
		"0SALESORG" as [Sales Organization],
		"SOLD_COUNTRY" as [Sold to Country (M)],
		"SOLD_REGION" as [Sold to State/Province (M)],
		"SOLD_YREGN" as [Sold to Region (M)],
		"SOLD_YSAREA" as [Sold to Sales Area (M)],
		"SOLD_L1" as [Sold to Hierarchy Level 1 (M)],
		"SOLD_L2" as [Sold to Hierarchy Level 2 (M)],
		"SOLD_L3" as [Sold to Hierarchy Level 3 (M)],
		"0SHIP_TO" as [Ship to party],
		"YSHCUST" as [Change Indicator for Ship to],
		"YSPCITY" as [Ship to City],
		"YSPCNTY" as [Ship to Country],
		"YSPPCDE" as [Ship to Postal Code],
		"YSPREGN" as [Ship to State/Province],
		"YSPSTRET" as [Ship to Street],
		"SHIP_YREGN" as [Ship to Region (M)],
		"SHIP_YSAREA" as [Ship to Sales Area (M)],
		"SHIP_L1" as [Ship to Hierarchy Level 1 (M)],
		"SHIP_L2" as [Ship to Hierarchy Level 2 (M)],
		"SHIP_L3" as [Ship to Hierarchy Level 3 (M)],
		"0CREATEDON" as [Created On],
		"0CALDAY" as [Date - Day],
		"0CALMONTH" as [Date - Year / Month],
		"0CALQUARTER" as [Date - Year / Quarter],
		"0CALYEAR" as [Date - Year],
		"CAL_MONTH" as [Date - Month],
		"CAL_QUARTER" as [Date - Quarter],
		"CAL_WEEKDAY" as [Date - Day of Week],
		"CAL_WEEK" as [Date - Week],
		"YBLLENDAT" as [Billing End Date],
		"YECACCMGR" as [End Customer Account Manager (T)],
		"YEUCUST" as [End Customer Number],
		"YEUCUSTC" as [End Customer City],
		"YEUCUSTCN" as [End Customer Country],
		"YEUCUSTLN" as [End Customer Location Name],
		"YEUCUSTPC" as [End Customer Postal Code],
		"YEUCUSTR" as [End Customer State/Province],
		"YEUCUSTS" as [End Customer Street],
		"YEUIND" as [Change Indicator for End User],
		"YEUSOURCE" as [End Customer Source],
		"YEUSLSOFF" as [End Customer Sub-Territory (T)],
		"ZENDCUSTNM" as [End Customer Name],
		"END_YCHNTYPE" as [End Customer Channel Type],
		"END_L1" as [End Customer Hierarchy Level 1 (M)],
		"END_L2" as [End Customer Hierarchy Level 2 (M)],
		"END_L3" as [End Customer Hierarchy Level 3 (M)],
		"0BILLTOPRTY" as [Bill to party],
		"BP_COUNTRY" as [Bill to Country (M)],
		"0MATERIAL" as [Material],
		"0MATL_GROUP" as [Material Group],
		"0MATL_GRP_1" as [Material Group 1],
		"0MATL_GRP_2" as [Material Group 2],
		"0MATL_GRP_4" as [Material Group 4],
		"0MATL_GRP_5" as [Material Group 5],
		"MAT_MATL_CAT" as [Material Category (M)],
		"MAT_PROD_HIE" as [Material Product Hierarchy (M)],
		"0MATAV_DATE" as [Material Availability Date],
		"YUEPOS" as [Higher-Level Item],
		"0BILL_ITEM" as [Billing Item],
		"0BILL_NUM" as [Billing Document],
		"0BILL_TYPE" as [Billing Type],
		"0COMP_CODE" as [Company Code],
		"0CREATEDBY" as [Created By],
		"0CUST_GROUP" as [Customer Group],
		"0CUST_GRP2" as [Operator Code],
		"0CUST_GRP3" as [Portfolio],
		"0DOC_CATEG" as [Billing Document Category],
		"0DOC_CURRCY" as [SD Document Currency],
		"0DOC_NUMBER" as [Sales Document],
		"0ITEM_CATEG" as [Billing Item Category],
		"0ORD_REASON" as [Order Reason],
		"0PAYER" as [Payer],
		"0SALESEMPLY" as [Sales Employee],
		"0S_ORD_ITEM" as [Sales Document Item],
		--"YEUACTMGR" as [Account Manager],
		"0DOC_TYPE" as [Sales Document Type],
		"YASHOPOR" as [ASHOP Number],
		"YCHACCMGR" as [Channel Account Manager (T)],
		"YDSACCMGR" as [Distributor Account Manager (T)],
		"YSFDCQTE" as [SFDC Quote Number],
		"YSWAQTE" as [CRM SWA Quote Number],
		"ZCPQTRACK" as [CPQ Tracking ID],
		"ZPOTYPE" as [Purchase Order Type],
		"ZZSFDC" as [SFDC Unique Deal ID],
		"YPCPO_NMB" as [Purchase Order No.],
		"YUSGCONT" as [USG Contract Number],
		"YBKFPART" as [BillingInvoicing Plan Type],
		"0PROD_HIER" as [Product Hierarchy],
		"YSDCOST" as [Standard Cost (USD)],
		"YSDNVAL" as [Net Value (USD)],
		"0BILL_DATE" as [Billing Date],
		"0CH_ON" as [Changed On],
		"0GI_DATE" as [Goods Issue Date],
		"YACCDAT" as [Acceptance Date],
		"YBLLBEDAT" as [Billing Start Date],
		"YPRIORDAY" as [Prior Day],
		"YMTD" as [Month To Date (MTD)],
		"YQTD" as [Quarter To Date (QTD)],
		"YYTD" as [Year To Date (YTD)],
		"YDOCATEG" as [Sales Document Category],
		"YBILL_STDDSC" as [Billings Std D/C (Doc)],
		"YBILL_ADDSC" as [Billings Addl D/C (Doc)],
		"YBILL_FRGHT" as [Billings Freight (Doc)],
		"YBILL_ADDSCU" as [Billings Addl D/C (USD)],
		"YBILL_FRGHTU" as [Billings Freight (USD)],
		"YBILL_COST" as [Billings Std Cost (Doc)],
		"YBILL_COSTU" as [Billings Std Cost (USD)],
		"0MAT_KONDM" as [Material Price Group (T)],
		"MS_MAT_KONDM" as [Material Price Group (M)],
		"0PRICE_GRP" as [Customer Price Group (T)],
		"YCUSTY4" as [Y4 Selling Agent],
		"PO_YGRPT" as [GR Processing Type],
		"SWAORDTYP" as [SWA Order Type],
		"SIC_SOURCE" as [SIC Source] 
FROM OPENQUERY (BWP,  
	'SELECT   
*
	FROM    "ZMITEL_BOOKINGS.TABLEAU_VIEWS::YR_SD_CV_BL01" 
--where "0CALYEAR" =  2020  '
	 )
 
