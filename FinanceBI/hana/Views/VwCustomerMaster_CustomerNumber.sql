/****** Script for SelectTopNRows command from SSMS  ******/

Create view hana.VwCustomerMaster_CustomerNumber as
-- MW 12032020 for Partner Joins, unique Customer Number
select * from
(SELECT  *
	  ,row_number() over (partition by [Customer Number] order by [Customer Number] desc) rn
  FROM [hana].[mVwCustomerMaster]) a 
where rn =1