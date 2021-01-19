 
 CREATE view [dbo].[V_TMP_ASSETNAME_OC] as
 select  top 100 percent
a.SfdcId,
p.Name + ' - PO#: '+ PONum as Description
FROM
CUSTOMER_ASSETS a inner join
PRODUCT p on a.SKU = p.SKU inner join
CUSTOMERS c on a.ImpactNumber = c.ImpactNumber
where c.Type = 'Customer (Installed)' and c.Status = 'Active'
order by c.ImpactNumber desc
