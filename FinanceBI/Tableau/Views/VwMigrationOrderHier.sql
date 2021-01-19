


CREATE View [Tableau].[VwMigrationOrderHier] as
--MW 05152019  Special Logic for Migrations

--linked adds
select 
	  o.Id as OrderId
	 ,isnull((p.FirstName + ' ' + p.LastName), 'Unassigned') as PMName
	 ,ot.Name as OrderType
	 ,'Migration' as MasterOrderType
	 ,ooo.Id as MigrationOrderId
	 ,os.Name as MigrationOrderStatus
	 ,ooo.DeprovisionDate  as MigrationOrderDeprovisionDate --Mig Order
from 
oss.[Order] o inner join
enum.OrderType ot on o.OrderTypeId =  ot.Id inner join
oss.[Order] oo on o.LinkedOrderId = oo.Id and oo.MasterOrderTypeId = 6 inner join
oss.[Order] ooo on oo.MasterOrderId = ooo.Id and ooo.OrderTypeId = 6 left outer join
people.Person p on ooo.ProjectManagerId = p.Id left outer join
enum.OrderStatus os on ooo.OrderStatusId = os.Id
union all
select 
	  o.Id as OrderId
	 ,isnull((p.FirstName + ' ' + p.LastName), 'Unassigned') as PMName
	 ,ot.Name as OrderType
	 ,'Migration' as MasterOrderType
	 ,ooo.Id as MigrationOrderId
	 ,os.Name as MigrationOrderStatus
	 ,ooo.DeprovisionDate  as MigrationOrderDeprovisionDate --Mig Order
from 
oss.[Order] o inner join
enum.OrderType ot on o.OrderTypeId =  ot.Id inner join
oss.[Order] ooo on o.MasterOrderId = ooo.Id and ooo.OrderTypeId = 6 left outer join
people.Person p on ooo.ProjectManagerId = p.Id  left outer join
enum.OrderStatus os on ooo.OrderStatusId = os.Id
union all
select 
	  ooo.Id as OrderId
	 ,isnull((p.FirstName + ' ' + p.LastName), 'Unassigned') as PMName
	 ,ot.Name as OrderType
	 ,'Migration' as MasterOrderType
	 ,ooo.Id as MigrationOrderId
	 ,os.Name as MigrationOrderStatus
	 ,ooo.DeprovisionDate  as MigrationOrderDeprovisionDate --Mig Order
from 
oss.[Order] ooo    inner join
enum.OrderType ot on ooo.OrderTypeId =  ot.Id left outer join
people.Person p on ooo.ProjectManagerId = p.Id  left outer join
enum.OrderStatus os on ooo.OrderStatusId = os.Id
where  ooo.OrderTypeId = 6
