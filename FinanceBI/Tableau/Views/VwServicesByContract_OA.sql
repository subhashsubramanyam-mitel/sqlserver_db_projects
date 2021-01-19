create View Tableau.VwServicesByContract_OA as
-- MW for OpenAir Migration  Joined to SFDC Project data
SELECT  
       c.[ContractNumber]
      ,s.[Name] as ContractStatus
	  ,ss.Name as ServiceStatus
	  ,1 as ServiceCount
  FROM 
		[sales].[Contract] c left outer join
		enum.sales_ContractStatus s on c.ContractStatusId = s.Id left outer join
		oss.[Order] o on c.ContractNumber = o.ContractNumber left outer join
		oss.ServiceProduct sp on o.Id = sp.OrderId left outer join
		enum.ServiceStatus ss on sp.ServiceStatusId = ss.Id
where o.OrderStatusId not in (-1,0,3)