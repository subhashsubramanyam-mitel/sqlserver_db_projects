create view C_SSC_CUSTOMERIDS as 
-- 04172018 saving for scansource
	select CASE WHEN a.VAR = 'SCANSOURCE, INC.' then 'Partner' Else 'Customer' End AS Type,  a.CustomerId as New_Id, b.OtherERPno as Old_Id, a.CustomerName
	from SVLCORPSILO1.MEGASILO.dbo.V_SSC_CUSTLIST a inner join
	[SFDC_SAP_AX_ID_MAP] b on a.CustomerId = b.ShoreTelId_SAP