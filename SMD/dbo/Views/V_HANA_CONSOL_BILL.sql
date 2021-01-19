﻿
 


  CREATE View [dbo].[V_HANA_CONSOL_BILL]  as

 
-- MW 12022020 Sales Out and Billings
 select 
 cast ("0CALDAY" as datetime) as [Date - Day],
"0CALMONTH" as [Date - Year / Month],
"0CALMONTH2" as [Date - Month],
"0CALQUART1" as [Date - Quarter],
"0CALQUARTER" as [Date - Year / Quarter],
"0CALYEAR" as [Date - Year],
"0DOC_CURRCY" as [Document Currency Key],
"0DOC_CURRCY___T" as [Document Currency Name],
"0MATERIAL" as [Material Key],
"0MATERIAL___T" as [Material Name],
"0PROD_HIER" as [Product Hierarchy Key],
"0PROD_HIER___T" as [Product Hierarchy Name],
"0SALESORG" as [Sales Organization Key],
"0SALESORG___T" as [Sales Organization Name],
"0SOLD_TO" as [Sold to party Key],
"0SOLD_TO___T" as [Sold to party Name],
"4YSDCPSOBL01_BILLING_DOC" as [Billing Document],
"4YSDCPSOBL01_CSP_YPRCTRL1___T" as [Profit Center Hierarchy Level 1 Name],
"4YSDCPSOBL01_CSP_YPRCTRL2___T" as [Profit Center Hierarchy Level 2 Name],
"4YSDCPSOBL01_CSP_YPRCTRL3___T" as [Profit Center Hierarchy Level 3 Name],
"4YSDCPSOBL01_CSP_YPRCTRL4___T" as [Profit Center Hierarchy Level 4 Name],
"4YSDCPSOBL01_CSP_YPRCTRL5___T" as [Profit Center Hierarchy Level 5 Name],
"4YSDCPSOBL01_CSP_YPRCTRL6___T" as [Profit Center Hierarchy Level 6 Name],
"4YSDCPSOBL01_CSP_YPRCTRL7___T" as [Profit Center Hierarchy Level 7 Name],
"4YSDCPSOBL01_DATASOURCE" as [Data Source],
"4YSDCPSOBL01_END_L1" as [End Customer Hierarchy Level 1 Key (M)],
"4YSDCPSOBL01_END_L1___T" as [End Customer Hierarchy Level 1 Name (M)],
"4YSDCPSOBL01_INV_MONTH" as [Invoice - Month],
"4YSDCPSOBL01_INV_WEEK" as [Invoice - Week],
"4YSDCPSOBL01_INV_YEARQUAR" as [Invoice - Year / Quarter],
"4YSDCPSOBL01_L1___T" as [Product Hierarchy Level 1 Name],
"4YSDCPSOBL01_L2___T" as [Product Hierarchy Level 2 Name],
"4YSDCPSOBL01_L3___T" as [Product Hierarchy Level 3 Name],
"4YSDCPSOBL01_L4___T" as [Product Hierarchy Level 4 Name],
"4YSDCPSOBL01_L5___T" as [Product Hierarchy Level 5 Name],
"4YSDCPSOBL01_L6___T" as [Product Hierarchy Level 6 Name],
"4YSDCPSOBL01_L7___T" as [Product Hierarchy Level 7 Name],
"4YSDCPSOBL01_SIC_SOURCE" as [SIC Source],
"4YSDCPSOBL01_SOLD_COUNTRY___T" as [Sold to Country Name],
"4YSDCPSOBL01_SOLD_L1" as [Sold to Hierarchy Level 1 Key (M)],
"4YSDCPSOBL01_SOLD_L1_1" as [Distributor Hierarchy Level 1 Key],
"4YSDCPSOBL01_SOLD_L1_1___T" as [Distributor Hierarchy Level 1 Name],
"4YSDCPSOBL01_SOLD_L1___T" as [Sold to Hierarchy Level 1 Name (M)],
"4YSDCPSOBL01_SOLD_REGION___T" as [Sold to State/Province Name (M)],
"4YSDCPSOBL01_SOLD_YCHNTYP" as [Sold to Channel Type Key (M)],
"4YSDCPSOBL01_SOLD_YCHNTYP___T" as [Sold to Channel Type Name (M)],
"4YSDCPSOBL01_SOLD_YPTNRLV" as [Sold to Partner Level Key (M)],
"4YSDCPSOBL01_SOLD_YPTNRLV___T" as [Sold to Partner Level Name (M)],
"4YSDCPSOBL01_SOLD_YREGN" as [Sold to Region (M)],
"4YSDCPSOBL01_SOLD_YREGN_1" as [Distributor Region],
"4YSDCPSOBL01_SOLD_YSALESO" as [Sold to Sub Territory Key (M)],
"4YSDCPSOBL01_SOLD_YSALESO___T" as [Sold to Sub Territory Name (M)],
"4YSDCPSOBL01_SOLD_YSALE_0" as [Distributor Sub Territory],
"4YSDCPSOBL01_SOLD_YSTHEAT" as [Sold to Sub Theatre (M)],
"4YSDCPSOBL01_SOLD_YSTHE_0" as [Distributor Sub Theatre],
"4YSDCPSOBL01_SOLD_YSUBREG" as [Sold to Sub Region (M)],
"4YSDCPSOBL01_SOLD_YTERITR" as [Sold to Territory (M)],
"4YSDCPSOBL01_SOLD_YTHEATR" as [Sold to Theatre (M)],
"4YSDCPSOBL01_SOLD_YTHEA_0" as [Distributor Theatre],
"4YSDCPSOBL01_YDECSERIS" as [Device Series],
"4YSDCPSOBL01_YDEVMODL" as [Device Model],
"4YSDCPSOBL01_YDOFMNTH" as [Date - Day of Month],
"4YSDCPSOBL01_YDOFQTR" as [Date - Day of Quarter],
"4YSDCPSOBL01_YDOFYR" as [Date - Day of Year],
"4YSDCPSOBL01_YDSACCMGM" as [Distributor Account Manager Key (M)],
"4YSDCPSOBL01_YDSACCMGM___T" as [Distributor Account Manager Name (M)],
"4YSDCPSOBL01_YEUCUSTCN___T" as [End Customer Country Name],
"4YSDCPSOBL01_YMOFQTR" as [Date - Month of Quarter],
"4YSDCPSOBL01_YMTLHLIND" as [End Customer High Level Vertical],
"4YSDCPSOBL01_YMTLINDUS" as [End Customer Vertical],
"4YSDCPSOBL01_YQTD" as [Quarter To Date (QTD)],
"4YSDCPSOBL01_YSICCODE" as [End Customer SIC Code 4 Key],
"4YSDCPSOBL01_YSICCODE1" as [End Customer SIC Code 1 Key],
"4YSDCPSOBL01_YSICCODE1___T" as [End Customer SIC Code 1 Name],
"4YSDCPSOBL01_YSICCODE2" as [End Customer SIC Code 2 Key],
"4YSDCPSOBL01_YSICCODE2___T" as [End Customer SIC Code 2 Name],
"4YSDCPSOBL01_YSICCODE3" as [End Customer SIC Code 3 Key],
"4YSDCPSOBL01_YSICCODE3___T" as [End Customer SIC Code 3 Name],
"4YSDCPSOBL01_YSICCODE___T" as [End Customer SIC Code 4 Name],
"4YSDCPSOBL01_YSOCUSNM_1" as [End Customer Name],
"4YSDCPSOBL01_YSOEUSTE___T" as [Normalized End Customer State/Province Name],
"YBIQTRWK" as [Date - Quarter/Week],
"YBIWEEK" as [Date - Week],
"YBIYQTRWK" as [Date - Y/Q/W],
"YCHACCMGM" as [Sold to Account Manager Key],
"YCHACCMGM___T" as [Sold to Account Manager Name],
"YCHNTYPE___T" as [Sold to Account Channel Type Name],
"YDEVCLASS" as [Device Classification],
"YEUCUST" as [End Customer Number],
"YEUCUSTPC" as [End Customer Postal Code],
"YEUIND" as [Change Indicator for End User Customer],
--"YEUSOURCE" as [End Customer Source],
"YMNTD" as [Month To Date (MTD)],
--"YPCPO_NMB" as [PO Number],
"YPRFCNTR" as [Profit Center Key],
"YPRFCNTR___T" as [Profit Center Name],
"YREGN" as [End Customer Region],
"YREPREGN" as [Analyst Reporting Region],
"YSOCUSNM" as [End Customer Location Name],
"YSOEUCTY" as [End Customer City],
"YSOORDNO" as [Sales Document],
"YSOSPAID" as [SPA ID],
"YSO_DISTR" as [Distributor Key],
"YSO_DISTR___T" as [Distributor Name],
"YSTHEATRE" as [End Customer Sub Theatre],
"YSUBREGN" as [End Customer Sub Region],
"YTAM" as [End Customer TAM],
"YTERITRY" as [End Customer Territory],
"YTHEATRE" as [End Customer Theatre],
"YUCCUSER" as [UCC User],
"YUCUSRLVL" as [UCC User level],
"YYTD" as [Year To Date (YTD)],
"YUSRCLASS" as [User Classification],
"4YSDCPSOBL01_UC_T_BILL" as [Total Billings (USD)],
"4YSDCPSOBL01_UC_T_BILL_MA" as [Total Billings Quantity (Calc)],
"4YSDCPSOBL01_UC_T_BILL_QU" as [Total Billings Quantity],
"4YSDCPSOBL01_UC_T_R_BILL" as [Total Reseller Billings (USD)],
"4YSDCPSOBL01_UC_T_R_EXSWA" as [Total Billings Excluding SWA (USD)],
"4YSDCPSOBL01_YSYSCOUNT" as [System Count],
"YCCAGCNT" as [CC Agent count],
"YCCEXTCNT" as [CC Extension Count],
"YCCLICCNT" as [CC license count],
"YCCPRTCNT" as [CC Port Count],
"YCCSTCNT" as [CC Site Count],
"YMAILCNT" as [Mailbox Count],
"YPHONECNT" as [Phone Count],
"YTOTUSRCT" as [User Count] 

 
 FROM OPENQUERY (BWP,  'SELECT  
"0CALDAY" ,
"0CALMONTH",
"0CALMONTH2",
"0CALQUART1",
"0CALQUARTER",
"0CALYEAR",
"0DOC_CURRCY",
"0DOC_CURRCY___T",
"0MATERIAL",
"0MATERIAL___T",
"0PROD_HIER",
"0PROD_HIER___T",
"0SALESORG",
"0SALESORG___T",
"0SOLD_TO",
"0SOLD_TO___T",
"4YSDCPSOBL01_BILLING_DOC",
"4YSDCPSOBL01_CSP_YPRCTRL1___T",
"4YSDCPSOBL01_CSP_YPRCTRL2___T",
"4YSDCPSOBL01_CSP_YPRCTRL3___T",
"4YSDCPSOBL01_CSP_YPRCTRL4___T",
"4YSDCPSOBL01_CSP_YPRCTRL5___T",
"4YSDCPSOBL01_CSP_YPRCTRL6___T",
"4YSDCPSOBL01_CSP_YPRCTRL7___T",
"4YSDCPSOBL01_DATASOURCE",
"4YSDCPSOBL01_END_L1",
"4YSDCPSOBL01_END_L1___T",
"4YSDCPSOBL01_INV_MONTH",
"4YSDCPSOBL01_INV_WEEK",
"4YSDCPSOBL01_INV_YEARQUAR",
"4YSDCPSOBL01_L1___T",
"4YSDCPSOBL01_L2___T",
"4YSDCPSOBL01_L3___T",
"4YSDCPSOBL01_L4___T",
"4YSDCPSOBL01_L5___T",
"4YSDCPSOBL01_L6___T",
"4YSDCPSOBL01_L7___T",
"4YSDCPSOBL01_SIC_SOURCE",
"4YSDCPSOBL01_SOLD_COUNTRY___T",
"4YSDCPSOBL01_SOLD_L1",
"4YSDCPSOBL01_SOLD_L1_1",
"4YSDCPSOBL01_SOLD_L1_1___T",
"4YSDCPSOBL01_SOLD_L1___T",
"4YSDCPSOBL01_SOLD_REGION___T",
"4YSDCPSOBL01_SOLD_YCHNTYP",
"4YSDCPSOBL01_SOLD_YCHNTYP___T",
"4YSDCPSOBL01_SOLD_YPTNRLV",
"4YSDCPSOBL01_SOLD_YPTNRLV___T",
"4YSDCPSOBL01_SOLD_YREGN",
"4YSDCPSOBL01_SOLD_YREGN_1",
"4YSDCPSOBL01_SOLD_YSALESO",
"4YSDCPSOBL01_SOLD_YSALESO___T",
"4YSDCPSOBL01_SOLD_YSALE_0",
"4YSDCPSOBL01_SOLD_YSTHEAT",
"4YSDCPSOBL01_SOLD_YSTHE_0",
"4YSDCPSOBL01_SOLD_YSUBREG",
"4YSDCPSOBL01_SOLD_YTERITR",
"4YSDCPSOBL01_SOLD_YTHEATR",
"4YSDCPSOBL01_SOLD_YTHEA_0",
"4YSDCPSOBL01_YDECSERIS",
"4YSDCPSOBL01_YDEVMODL",
"4YSDCPSOBL01_YDOFMNTH",
"4YSDCPSOBL01_YDOFQTR",
"4YSDCPSOBL01_YDOFYR",
"4YSDCPSOBL01_YDSACCMGM",
"4YSDCPSOBL01_YDSACCMGM___T",
"4YSDCPSOBL01_YEUCUSTCN___T",
"4YSDCPSOBL01_YMOFQTR",
"4YSDCPSOBL01_YMTLHLIND",
"4YSDCPSOBL01_YMTLINDUS",
"4YSDCPSOBL01_YQTD",
"4YSDCPSOBL01_YSICCODE",
"4YSDCPSOBL01_YSICCODE1",
"4YSDCPSOBL01_YSICCODE1___T",
"4YSDCPSOBL01_YSICCODE2",
"4YSDCPSOBL01_YSICCODE2___T",
"4YSDCPSOBL01_YSICCODE3",
"4YSDCPSOBL01_YSICCODE3___T",
"4YSDCPSOBL01_YSICCODE___T",
"4YSDCPSOBL01_YSOCUSNM_1",
"4YSDCPSOBL01_YSOEUSTE___T",
"YBIQTRWK",
"YBIWEEK",
"YBIYQTRWK",
"YCHACCMGM",
"YCHACCMGM___T",
"YCHNTYPE___T",
"YDEVCLASS",
"YEUCUST",
"YEUCUSTPC",
"YEUIND",
/*"YEUSOURCE", */
"YMNTD",
/*"YPCPO_NMB", */
"YPRFCNTR",
"YPRFCNTR___T",
"YREGN",
"YREPREGN",
"YSOCUSNM",
"YSOEUCTY",
"YSOORDNO",
"YSOSPAID",
"YSO_DISTR",
"YSO_DISTR___T",
"YSTHEATRE",
"YSUBREGN",
"YTAM",
"YTERITRY",
"YTHEATRE",
"YUCCUSER",
"YUCUSRLVL",
"YYTD",
"YUSRCLASS",
"4YSDCPSOBL01_UC_T_BILL",
"4YSDCPSOBL01_UC_T_BILL_MA",
"4YSDCPSOBL01_UC_T_BILL_QU",
"4YSDCPSOBL01_UC_T_R_BILL",
"4YSDCPSOBL01_UC_T_R_EXSWA",
"4YSDCPSOBL01_YSYSCOUNT",
"YCCAGCNT",
"YCCEXTCNT",
"YCCLICCNT",
"YCCPRTCNT",
"YCCSTCNT",
"YMAILCNT",
"YPHONECNT",
"YTOTUSRCT"
  FROM    "ZMITEL_BOOKINGS.TABLEAU_VIEWS::YR_SD_CV_SOBL"' )   
  
 



