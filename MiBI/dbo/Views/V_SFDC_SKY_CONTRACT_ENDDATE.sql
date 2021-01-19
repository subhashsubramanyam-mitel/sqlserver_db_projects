

 CREATE VIew V_SFDC_SKY_CONTRACT_ENDDATE as
 --View for end date sync to AX.   MW 08262015



--select a.AccountNum, b.ContractEndDate
--from 
--CUSTTABLE a inner join
--[$(MiBI)].dbo.V_SFDC_SKY_CONTRACT_ENDDATE b on a.AccountNum = b.ShoretelId collate database_default
--where 
--a.STCONTRACTENDDATE <> '1900-01-01 00:00:00.000'
--AND convert(Char(10),b.ContractEndDate, 120) <> convert(Char(10),a.STCONTRACTENDDATE, 120)

select 
b.ShoretelId,
--b.M5dbAccountID, 
max(a.ContractEndDate) as ContractEndDate
 from 
CONTRACT a inner join
SFDC_SKY_INVOICEGROUP b on a.M5dbAccountID = b.M5dbAccountID
where
 a.IsCurrent = 'Yes' and a.M5dbAccountID is not null
 group by b.ShoretelId
 
