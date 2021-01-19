


CREATE view [hana].[VwCustomerMaster_Partner] as
--MW 12032020 FOr joining into Partner Ids in Global Boss Billings
 select  
 case when [Customer Number] like '0%' then convert(varchar(10), cast([Customer Number] as bigint)) else [Customer Number] end collate database_default as PartnerId  --For Tableau
 ,* 
 from  hana.VwCustomerMaster_CustomerNumber