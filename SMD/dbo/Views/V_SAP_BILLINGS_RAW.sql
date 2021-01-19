
CREATE View [dbo].[V_SAP_BILLINGS_RAW] as
-- MW 04042018 with mappings
SELECT 
		[VBAK-ERDAT] as OrderDate,
		replace ([VBAK-VDATU], '00000000', Convert(varchar(10),getdate(), 112)) as RequestedShipDate,
		[VBKD-BSTKD] as CustomerPo,
		[VBKD-IHREZ] as QmsQuoteNumber,
		[VBAK-VBELN] as SalesOrder,
		[VBFA-VBELV] as OrigSalesOrder,
		[VBAK-BSARK] as OrderType,
		[VBRK-VBELN] as Invoice,
		[VBRK-FKDAT] as InvoiceDate,
		[VBPA-KUNNR_BP] as BillTo,
		[KNVV-KDGRP] as CUSTGROUP,
		[ADRC-NAME1_BP] as BillToName,
		[VBPA-KUNNR_Z5] as EndCust,
		[ADRC-NAME1_Z5] as EndCustName,
		[VBRP-POSNR] as InvoiceLineNum,
		[VBRP-PRODH] as ItemGroupName,
		[MARA-MTART] as AxRevType,
		replace( [VBRP-MATNR] ,'0000000000000', '') as SKU,
		[VBRP-ARKTX] as ItemDesc,
		[VBRK-WAERK] as CURRENCYCODE,
		[VBAP-NETPR] as PRICEUNIT,
		--MW 041220187 screwy ass SAP numbers
		CASE WHEN CHARINDEX('-',[VBRP-FKIMG]) > 0 
				THEN CAST('-'+replace(replace([VBRP-FKIMG], ',','') , '-','') as float) ELSE
		cast( replace([VBRP-FKIMG], ',','') as float) END  as QTY,

				CASE WHEN CHARINDEX('-',[VBRP-NETWR]) > 0 
				THEN CAST('-'+replace(replace([VBRP-NETWR], ',','') , '-','') as float) ELSE
		cast( replace([VBRP-NETWR], ',','') as float) END  as NetSalesUSD,
	--	[BSEG-DMBTR] as NetSalesLocalCurrency,
		[VBRP-PRCTR] as ProfitCenter,
		[VBRK-LAND1] as Country,
		[ADRC-CITY1] as ShipCity,
		[ADRC-POST_CODE1] as ShipPostalCode,
		[ADRC-REGION] as ShipState,
		[ADRC-CITY2] as ShipCounty,
		[ADRC-COUNTRY] as ShipCountry,
		[ADRC-NAME1_YR] as IVARName,
		[VBPA-KUNNR_YR] as IVARId,
		[VBRP-UEPOS] as SemSbeParent,
		replace(replace ([VBAK-VDATU_2], '00000000', Convert(varchar(10),getdate(), 112)),'000000', Convert(varchar(10),getdate(), 112))  as ShippingDateRequested,
		replace ([LIKP-WADAT_IST], '00000000', Convert(varchar(10),getdate(), 112)) as ShippingDateConfirmed,
		[VBRK-ERDAT] as InvoiceDateUTC,
		[VBRK-ERZET] as InvoiceDateTimeUTC,
		case when isdate([KNA1-ERDAT]) = 1 then  replace ([KNA1-ERDAT], '00000000', Convert(varchar(10),getdate(), 112)) else null end  as EndCustCreateDate,
		[KONV-KBETR] as SemQmsList,
		[VBRP-AUGRU_AUFT] as ReturnReasonCodeId,
		[VBRP-SHKZG] as ReturnFlag,
		CASE when isnumeric([VBRP-FKIMG_2]) = 1 then [VBRP-FKIMG_2] else null END as ReturnQty,
		[VBRK-VBELN] +'_'+ [VBRP-POSNR] as RecId,
		row_number() over (partition by [VBRK-VBELN] +'_'+ [VBRP-POSNR] order by Created Desc) as RowNum
  FROM [SMD].[dbo].[SAP_BILLINGS_RAW]
  where 
  -- filter bad records MW 07222019
  isdate([VBRK-FKDAT]) = 1
