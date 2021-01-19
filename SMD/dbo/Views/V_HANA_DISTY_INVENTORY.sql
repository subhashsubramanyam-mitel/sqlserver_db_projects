

 
 


  CREATE view [dbo].[V_HANA_DISTY_INVENTORY] as 
 -- MW 10262020 For Export To Tableau
 

select
YSOCALINV as [Calculated Inventory On Hand (USD)],
"0WEEKDAY1" as [Date - Day of Week],
"0CALMONTH2" as [Date - Month],
"0CALQUART1" as [Date - Quarter],
YBIQTRWK as [Date - Quarter/Week],
YBIWEEK as [Date - Week Key],
YBIWEEK___T as [Date - Week Name],
YBIYQTRWK as [Date - Y/Q/W],
"0CALYEAR" as [Date - Year],
"0CALMONTH" as [Date - Year / Month],
"0CALQUARTER" as [Date - Year / Quarter],
YDSACCMGM as [Distributor Account Manager (M) Key],
YDSACCMGM___T as [Distributor Account Manager (M) Name],
YCHNTYPE as [Distributor Channel Type Key],
YCHNTYPE___T as [Distributor Channel Type Name],
"4YSOCPIN01_SOLD_L1" as [Distributor Hierarchy L1 Key],
"4YSOCPIN01_SOLD_L1___T" as [Distributor Hierarchy L1 Name],
YSO_DISID as [Distributor Key],
YSO_DISID___T as [Distributor Name],
YREGN as [Distributor Region Key],
YREGN___T as [Distributor Region Name],
YSAREA as [Distributor Sales Area Key],
YSAREA___T as [Distributor Sales Area Name],
YSALESOFF as [Distributor Sales Office Key],
YSALESOFF___T as [Distributor Sales Office Name],
YSUBREGN as [Distributor Sub-Region Key],
YSUBREGN___T as [Distributor Sub-Region Name],
YSTHEATRE as [Distributor Sub-Theatre Key],
YSTHEATRE___T as [Distributor Sub-Theatre Name],
YTHEATRE as [Distributor Theatre Key],
YTHEATRE___T as [Distributor Theatre Name],
"0CURRENCY" as [Document Currency],
YSO_FMAT as [Final Material Key],
YSO_FMAT___T as [Final Material Name],
"0INFOPROV" as [InfoProvider],
YSO_IBO as [Inventory BackOrder USD],
YSO_ICMM as [Inventory Committed USD],
cast(YSOINVDT as datetime) as [Inventory Date],
YSO_IOH as [Inventory On Hand USD],
YSO_IOPO as [Inventory on PO USD],
"4YSOCPIN01_INVENTORY_TY" as [Inventory Type],
YSO_LDFG as [Load Flag],
"0MATERIAL" as [Override Material Key],
"0MATERIAL___T" as [Override Material Name],
"0PROD_HIER" as [Product Hierarchy Key],
"4YSOCPIN01_P_HIER_L1" as [Product Hierarchy L1 Key],
 "4YSOCPIN01_P_HIER_L1___T" as [Product Hierarchy L1 Name],
"4YSOCPIN01_P_HIER_L2" as [Product Hierarchy L2 Key],
"4YSOCPIN01_P_HIER_L2___T" as [Product Hierarchy L2 Name],
"4YSOCPIN01_P_HIER_L3" as [Product Hierarchy L3 Key],
"4YSOCPIN01_P_HIER_L3___T" as [Product Hierarchy L3 Name],
"4YSOCPIN01_P_HIER_L4" as [Product Hierarchy L4 Key],
"4YSOCPIN01_P_HIER_L4___T" as [Product Hierarchy L4 Name],
"4YSOCPIN01_P_HIER_L5" as [Product Hierarchy L5 Key],
"4YSOCPIN01_P_HIER_L5___T" as [Product Hierarchy L5 Name],
"4YSOCPIN01_P_HIER_L6" as [Product Hierarchy L6 Key],
"4YSOCPIN01_P_HIER_L6___T" as [Product Hierarchy L6 Name],
"4YSOCPIN01_P_HIER_L7" as [Product Hierarchy L7 Key],
"4YSOCPIN01_P_HIER_L7___T" as [Product Hierarchy L7 Name],
"0PROD_HIER___T" as [Product Hierarchy Name],
cast(ZSOINVDT as datetime) as [Reported Inventory Date],
YSOM_DPT as [Reported Material Description],
YSOMATID as [Reported Material ID],
"4YSOCPIN01_1ROWCOUNT" as [Row Counter],
YSO_TID as [Transaction ID],
YSO_UC as [Unit Cost],
YSO_CUC as [Unit Cost USD],
YSOUCOMM as [Units Committed],
YSO_UOBO as [Units on BackOrder],
YSO_UOH as [Units On Hand],
"4YSOCPIN01_YSO_UOP" as [Units On PO],
YSOWRLOC as [Warehouse location]


FROM OPENQUERY (BWP,  
	'SELECT   --top 10
*
	FROM    "ZMITEL_BOOKINGS.TABLEAU_VIEWS::YR_DI_CV_IN01" 
  '
	 )

