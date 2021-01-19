﻿ 
 CREATE view V_HANA_BACKLOG as 
 -- MW 12282020 
 select 
 "0BILBLK_DL" as [Billing Block (H) Key],
--"0BILBLK_DL_T" as [Billing Block (H) Name],
"0BILBLK_ITM" as [Billing Block (I) Key],
--"BILBLK_ITM_T" as [Billing Block (I) Name],
--"BILL_BLOCK_T" as [Billing Plan Block Name],
"0BILL_DATE" as [Billing Date],
--"0COUNTRY_T" as [Sold to Country (M) Name],
"0CREATEDBY" as [Created By],
"0CREATEDON" as [Created On (H)],
"0DEL_BLOCK" as [Delivery Block (H) Key],
--"0DEL_BLOCK_T" as [Delivery Block (H) Name],
"0DLV_STS" as [Delivery Status Key],
--"0DLV_STS_T" as [Delivery Status Name],
"0DOC_CURRCY" as [SD Document Currency],
"0DOC_NUMBER" as [Sales Document],
"0DOC_TYPE" as [Sales Document Type Key],
--"0DOC_TYPE_T" as [Sales Document Type Name],
"0ERDAT" as [Created On (L)],
"0GI_DATE" as [Goods Issue Date],
"0INCOTERMS" as [Incoterms],
--"0INCOTERMS_T" as [Incoterms 2 Name],
--"ITEM_CATEG_T" as [Sales Document Item Category Name],
"0MATAV_DATE" as [Material Availability Date],
"0MATERIAL" as [Material Key],
--"0MATERIAL_T" as [Material Name],
"0MATL_GROUP" as [Material Group (M) Key],
--"MATL_GROUP_T" as [Material Group (M) Name],
"0MATL_GRP_1" as [Material Group 1 Key],
--"0MATL_TYPE_T" as [Material Type (M) Name],
"0MAT_KONDM" as [Material Price Group Key],
--"0MAT_KONDM_T" as [Material Price Group Name],
"0ORD_REASON" as [Order Reason Code Key],
--"ORD_REASON_T" as [Order Reason Code Name],
"0PLANT" as [Plant Key],
--"0PLANT_T" as [Plant Name],
"0PRICE_DATE" as [Pricing Date],
"0PRICE_GRP" as [Customer Price Group (M) Key],
--"0PRICE_GRP_T" as [Customer Price Group (M) Name],
"0PROFIT_CTR" as [Profit Center (T) Key],
--"PROFIT_CTR_T" as [Profit Center (T) Name],
--"0REGION_T" as [Sold to State/Province (M) Name],
"0REQ_DATE" as [Customer Requested Delivery Date (Item)],
"0SALESORG" as [Sales Organization Key],
--"0SALESORG_T" as [Sales Organization Name],
"0SCHED_LINE" as [Sales Document Schedule Line],
"0SHIP_TO" as [Ship-to Party Key],
--"0SHIP_TO_T" as [Ship-to Party Name],
"0SOLD_TO" as [Sold to Party Key],
--"0SOLD_TO_T" as [Sold to Party Name],
"0S_ORD_ITEM" as [Sales Document Item],
"4YSDCPBG04_0CUST_GROUP" as [Customer Group Key],
"4YSDCPBG04_0CUST_GROUP___T" as [Customer Group Name],
"4YSDCPBG04_0CUST_GRP2" as [Operator Code Key],
"4YSDCPBG04_0CUST_GRP2___T" as [Operator Code Name],
"4YSDCPBG04_0LOAD_DATE" as [Loading Date],
"4YSDCPBG04_0PRICE_GRP" as [Customer Price Group Key],
"4YSDCPBG04_0PRICE_GRP___T" as [Customer Price Group Name],
"4YSDCPBG04_0PROD_HIER" as [Product Hierarchy Key],
"4YSDCPBG04_0PROD_HIER___T" as [Product Hierarchy Name],
"4YSDCPBG04_4YSDDBG03_NO" as [OCS Notification Key],
"4YSDCPBG04_4YSDDBG03_NO___T" as [OCS Notification Name],
"4YSDCPBG04_4YSDDBG03_SW" as [SWA Invoice],
"4YSDCPBG04_BBP_PODATE" as [Purchase Order Date],
"4YSDCPBG04_BK_CATEG" as [Backlog Category],
"4YSDCPBG04_BK_LINE" as [Backlog Line],
"4YSDCPBG04_CR_WEEK" as [Created Date - Week],
"4YSDCPBG04_CR_YBIYQTRWK" as [Created Date - Y/Q/W],
"4YSDCPBG04_CR_YEARQTRWE" as [Created Date - Quarter/Week],
"4YSDCPBG04_C_NETVALUE" as [Net Value (C)],
"4YSDCPBG04_ED_QUARTERWE" as [Expected Revenue - Day of Week],
"4YSDCPBG04_ED_WEEK" as [Expected Revenue - Week],
"4YSDCPBG04_ED_YBIYQTRWK" as [Expected Revenue - Y/Q/W],
"4YSDCPBG04_ED_YEARQTRWE" as [Expected Revenue - Quarter/Week],
"4YSDCPBG04_END_L1" as [End Customer Hierarchy Level 1 (M) Key],
"4YSDCPBG04_END_L1___T" as [End Customer Hierarchy Level 1 (M) Name],
"4YSDCPBG04_END_YCHNTYPE" as [End Customer Channel Type (M) Key],
"4YSDCPBG04_END_YCHNTYPE___T" as [End Customer Channel Type (M) Name],
"4YSDCPBG04_EXP_REV_DATE" as [Expected Revenue Date],
"4YSDCPBG04_OSL_REQ_DATE" as [Delivery Date],
"4YSDCPBG04_PO_WEBAZ" as [GR Processing Time],
"4YSDCPBG04_PO_YGRPT" as [GR Processing Type],
"4YSDCPBG04_SOLD_L1" as [Sold to Hierarchy Level 1 (M) Key],
"4YSDCPBG04_SOLD_L1___T" as [Sold to Hierarchy Level 1 (M) Name],
"4YSDCPBG04_SOLD_SALESEM" as [Sold to Account Manager (M) Key],
"4YSDCPBG04_SOLD_SALESEM___T" as [Sold to Account Manager (M) Name],
"4YSDCPBG04_SOLD_YCHNTYP" as [Sold to Channel Type (M) Key],
"4YSDCPBG04_SOLD_YCHNTYP___T" as [Sold to Channel Type (M) Name],
"4YSDCPBG04_SWAORDTYP" as [SWA Order Type],
"4YSDCPBG04_YPRDHRL1___T" as [Product Hierarchy L1 Name],
"4YSDCPBG04_YPRDHRL2___T" as [Product Hierarchy L2 Name],
"4YSDCPBG04_YPRDHRL3___T" as [Product Hierarchy L3 Name],
"4YSDCPBG04_YPRDHRL4___T" as [Product Hierarchy L4 Name],
"4YSDCPBG04_YPRDHRL5___T" as [Product Hierarchy L5 Name],
"4YSDCPBG04_YPRDHRL6___T" as [Product Hierarchy L6 Name],
"4YSDCPBG04_YPRDHRL7___T" as [Product Hierarchy L7 Name],
"4YSDCPBG04_YREGN" as [End Customer Region Key],
"4YSDCPBG04_YRESELL" as [Reseller Partner Key],
"4YSDCPBG04_YRESELL___T" as [Reseller Partner Name],
"4YSDCPBG04_YSTHEATRE" as [End Customer Sub-Theatre Key],
"4YSDCPBG04_YSUBREGN" as [End Customer Sub-Region Key],
"4YSDCPBG04_YTERITRY" as [End Customer Territory Key],
"4YSDCPBG04_YTHEATRE" as [End Customer Theatre Key],
"4YSDCPBG04_ZBLNOTES" as [Backlog Notes],
"4YSDCPBG04_ZBLREASON" as [Backlog Reason Key],
"4YSDCPBG04_ZBLREASON___T" as [Backlog Reason Name],
--"YBKFPART_T" as [Billing Plan Type Name],
"YBLLAFDAT" as [Billing Plan Date],
"YBLLBEDAT" as [Billing Plan Start Date],
"YBLLENDAT" as [Billing Plan End Date],
"YBLLPSTAT" as [Billing Line Status],
"YCHNHIER1" as [Sold to Channel Hierarchy Level 1 (M)],
"YCHNHIER2" as [Sold to Channel Hierarchy Level 2 (M)],
"YCUSTY4" as [Y4 Selling Agent],
--"YDOCATEG_T" as [Sales Document Category Name],
"YEUACTMGR" as [Sales Employee Key],
--"YEUACTMGR_T" as [Sales Employee Name],
"YEUCUST" as [End Customer Number],
"YEUCUSTC" as [End Customer City],
"YEUCUSTCN" as [End Customer Country Key],
--"YEUCUSTCN_T" as [End Customer Country Name],
"YEUCUSTN" as [End Customer Name],
"YEUCUSTPC" as [End Customer Postal Code],
"YEUCUSTR" as [End Customer State/Province Key],
--"YEUCUSTR_T" as [End Customer State/Province Name],
"YEUSLSOFF" as [End Customer Sub-Territory (T) Key],
--"YEUSLSOFF_T" as [End Customer Sub-Territory (T) Name],
--"YEUSOURCE_T" as [End Customer Source Name],
"YINSTDAT" as [Installation Date],
"YPCPO_NMB" as [Purchase Order No.],
--"YPRCTRL1_T" as [Profit Center Hierarchy L1 (M) Name],
--"YPRCTRL2_T" as [Profit Center Hierarchy L2 (M) Name],
--"YPRCTRL3_T" as [Profit Center Hierarchy L3 (M) Name],
--"YPRCTRL4_T" as [Profit Center Hierarchy L4 (M) Name],
--"YPRCTRL5_T" as [Profit Center Hierarchy L5 (M) Name],
--"YPRCTRL6_T" as [Profit Center Hierarchy L6 (M) Name],
--"YPRCTRL7_T" as [Profit Center Hierarchy L7 (M) Name],
"YPRFCNTR" as [Profit Center (M) Key],
--"YPRFCNTR_T" as [Profit Center (M) Name],
--"YPTNRLVL_T" as [Sold to Partner Level (M) Name],
"YREGN" as [Sold to Region (M) Key],
"YSALESOFF" as [Sold to Sub-Territory (M) Key],
"YSFDCQTE" as [SFDC Quote Number],
"YSPCITY" as [Ship to City],
--"YSPCNTY_T" as [Ship to Country Name],
"YSPNAME" as [Ship to Name],
"YSPPCDE" as [Ship to Postal Code],
--"YSPREGN_T" as [Ship to State/Province Name],
"YSPSTRET" as [Ship to Street],
"YSTHEATRE" as [Sold to Sub-Theatre (M) Key],
"YSUBREGN" as [Sold to Sub-Region (M) Key],
"YTERITRY" as [Sold to Territory (M) Key],
"YTHEATRE" as [Sold to Theatre (M) Key],
"YUEPOS" as [Higher-level Item],
"YUSGCONT" as [USG Contract Number],
"YVBDAT" as [Contract Start Date],
"YVNDAT" as [Contract End Date],
"ZCPQTRACK" as [CPQ Tracking ID],
"ZPOTYPE" as [Purchase Order Type Key],
"ZZSFDC" as [SFDC Unique Deal ID],
"4YSDCPBG04_YROWCOUNT" as [Number of Records],
"4YSDCPBG04_BACKLOG" as [Backlog (Doc)],
"4YSDCPBG04_NVD_CHOLD" as [Credit Hold (Doc)],
"4YSDCPBG04_NVD_CQTR" as [Backlog - Current Quarter (Doc)],
"4YSDCPBG04_NVD_CYR" as [Backlog - Current Year (Doc)],
"4YSDCPBG04_NVD_FYR" as [Future Years (Doc)],
"4YSDCPBG04_NVD_LATE" as [Late (Doc)],
"4YSDCPBG04_NVD_MONTH" as [Month (Doc)],
"4YSDCPBG04_NVD_NMONTH" as [Next Month (Doc)],
"4YSDCPBG04_NVD_NQTR" as [Next Quarter (Doc)],
"4YSDCPBG04_NVD_RETURN" as [Returns (Doc)],
"4YSDCPBG04_NVD_RQTR" as [Rest of Quarter (Doc)],
"4YSDCPBG04_NVD_RYR" as [Rest of Year (Doc)],
"4YSDCPBG04_NVD_TBACK" as [Total Backlog (Doc)],
"4YSDCPBG04_NVU_BACK" as [Backlog (USD)],
"4YSDCPBG04_NVU_CHOLD" as [Credit Hold (USD)],
"4YSDCPBG04_NVU_CQTR" as [Backlog - Current Quarter (USD)],
"4YSDCPBG04_NVU_CYR" as [Backlog - Current Year (USD)],
"4YSDCPBG04_NVU_FYR" as [Future Years (USD)],
"4YSDCPBG04_NVU_LATE" as [Late (USD)],
"4YSDCPBG04_NVU_MONTH" as [Month (USD)],
"4YSDCPBG04_NVU_NMONTH" as [Next Month (USD)],
"4YSDCPBG04_NVU_NQTR" as [Next Quarter (USD)],
"4YSDCPBG04_NVU_RETURNS" as [Returns (USD)],
"4YSDCPBG04_NVU_RQTR" as [Rest of Quarter (USD)],
"4YSDCPBG04_NVU_RYR" as [Rest of Year (USD)],
"4YSDCPBG04_NVU_TBACK" as [Total Backlog (USD)],
"4YSDCPBG04_Q_BACKLOG" as [Backlog (Qty)],
"4YSDCPBG04_Q_CHOLD" as [Credit Hold (Qty)],
"4YSDCPBG04_Q_CQTR" as [Backlog - Current Quarter (Qty)],
"4YSDCPBG04_Q_CYR" as [Backlog - Current Year (Qty)],
"4YSDCPBG04_Q_FYR" as [Future Years (Qty)],
"4YSDCPBG04_Q_LATE" as [Late (Qty)],
"4YSDCPBG04_Q_MONTH" as [Month (Qty)],
"4YSDCPBG04_Q_NMONTH" as [Next Month (Qty)],
"4YSDCPBG04_Q_NQTR" as [Next Quarter (Qty)],
"4YSDCPBG04_Q_RETURNS" as [Returns (Qty)],
"4YSDCPBG04_Q_RQTR" as [Rest of Quarter (Qty)],
"4YSDCPBG04_Q_RYR" as [Rest of Year (Qty)],
"4YSDCPBG04_Q_TBACK" as [Total Backlog (Qty)],
"4YSDCPBG04_SNI_BK_D" as [SNI (Doc)],
"4YSDCPBG04_SNI_BK_Q" as [SNI (Qty)],
"4YSDCPBG04_SNI_BK_U" as [SNI (USD)]

 FROM OPENQUERY (BWP,  'SELECT   * FROM    "ZMITEL_BOOKINGS.TABLEAU_VIEWS::YR_SD_CV_AGR_BG04"' ) 