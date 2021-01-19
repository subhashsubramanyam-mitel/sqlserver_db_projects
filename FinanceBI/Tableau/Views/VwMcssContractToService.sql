
Create view Tableau.VwMcssContractToService as
-- Compare contract products to activated services by account
-- MW 02102020
select 
	 a.AccountId
	,a.LocationId
	,a.ProductName
	,a.TotalContractQty
	,a.TotalContractMRR
	,isnull(b.TotalServiceQty,0) as TotalServiceQty
	,isnull(b.TotalServiceMRR,0) as TotalServiceMRR
FROM
(
-- Contract Qty by Location
				select c.AccountId, b.[Prod Id] as ProductId, cl.LocationId, b.[Prod Name] as ProductName, SUM(cl.Quantity) as TotalContractQty, SUM(cl.MRR*cl.Quantity) as TotalContractMRR
				from 
				company.AccountAttr c  (nolock)  inner join
				 sales.Contract s (nolock) on c.AccountId = s.AccountId inner join
				 sales.ContractLineItem (nolock) cl on s.Id = cl.ContractId inner join
				 enum.VwProduct b (nolock) on cl.ProductId = b.[Prod Id] --and b.[Prod Category] = 'Profiles'  
				where   c.IsMCSSEnabled = 1 and 
				  b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
				group by c.AccountId , b.[Prod Id]  , cl.LocationId ,b.[Prod Name]
) a
left outer join (
				-- Active Services
				select c.AccountId, b.[Prod Id] as ProductId, s.LocationId, b.[Prod Name] as ProductName, count(s.ServiceId) as TotalServiceQty, SUM(s.MonthlyCharge) as TotalServiceMRR
				from 
				company.AccountAttr c  (nolock)  inner join
				oss.VwServiceProduct_EX s (nolock) on c.AccountId = s.AccountId and s.ServiceStatusId = 1 inner join
				 enum.VwProduct b (nolock) on s.ProductId = b.[Prod Id] --and b.[Prod Category] = 'Profiles'  
				where   c.IsMCSSEnabled = 1 and 
				  b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
				group by c.AccountId , b.[Prod Id]  , s.LocationId ,b.[Prod Name]
		) b on a.AccountId = b.AccountId and a.LocationId = b.LocationId and a.ProductId = b.ProductId


UNION ALL

 
 -- no Contract Link
 select 
	 a.AccountId
	,a.LocationId
	,a.ProductName
	,0 as TotalContractQty
	,0 as TotalContractMRR
	,isnull(a.TotalServiceQty,0) as TotalServiceQty
	,isnull(a.TotalServiceMRR,0) as TotalServiceMRR
FROM
 (
				-- Active Services
				select c.AccountId, b.[Prod Id] as ProductId, s.LocationId, b.[Prod Name] as ProductName, count(s.ServiceId) as TotalServiceQty, SUM(s.MonthlyCharge) as TotalServiceMRR
				from 
				company.AccountAttr c  (nolock)  inner join
				oss.VwServiceProduct_EX s (nolock) on c.AccountId = s.AccountId and s.ServiceStatusId = 1 inner join
				 enum.VwProduct b (nolock) on s.ProductId = b.[Prod Id] --and b.[Prod Category] = 'Profiles'  
				where   c.IsMCSSEnabled = 1 and 
				  b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
				group by c.AccountId , b.[Prod Id]  , s.LocationId ,b.[Prod Name]
		) a left outer join
(
			-- Contract Qty by Location
				select c.AccountId, b.[Prod Id] as ProductId, cl.LocationId, b.[Prod Name] as ProductName, SUM(cl.Quantity) as TotalContractQty, SUM(cl.MRR*cl.Quantity) as TotalContractMRR
				from 
				company.AccountAttr c  (nolock)  inner join
				 sales.Contract s (nolock) on c.AccountId = s.AccountId inner join
				 sales.ContractLineItem (nolock) cl on s.Id = cl.ContractId inner join
				 enum.VwProduct b (nolock) on cl.ProductId = b.[Prod Id] --and b.[Prod Category] = 'Profiles'  
				where   c.IsMCSSEnabled = 1 and 
				  b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
				group by c.AccountId , b.[Prod Id]  , cl.LocationId ,b.[Prod Name]
) b on a.AccountId = b.AccountId and a.LocationId = b.LocationId and a.ProductId = b.ProductId
where b.LocationId is null