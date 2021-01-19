


CREATE view [MWSandbox].[VwElvisData] as
-- MW 12052017 sum Elvis Data
SELECT  b.AccountId  
 
      ,max([ExtLength]) ExtLength
      ,SUM([PageGroupsgt25]) PageGroupsgt25
      ,SUM([Cisco7937]) Cisco7937
      ,SUM([RingGroupsgt16]) RingGroupsgt16
      ,SUM([BargeGroups]) BargeGroups
  FROM [MWSandbox].[ElvisInfo] a inner join
       MWSandbox.BossIdMap b on a.CustomerNum = b.CustomerNum inner join
	   [$(FinanceBI)].company.Account c on b.AccountId = c.Id AND b.ClusterId = c.PrimaryClusterId
  Group by b.AccountId

/*
SELECT 
       PA.ClusterId ,
     
       PA.CustomerNum ,
       PA.AccountId ,
      
       AC.LichenAccountId into   MWSandBox.BossIdMap
 
FROM M5DB.m5db.dbo.Partition PA
    INNER JOIN M5DB.m5db.dbo.Cluster CL
        ON PA.ClusterId = CL.Id
    LEFT JOIN M5DB.m5db.dbo.Account AC
        ON PA.AccountId = AC.Id
    LEFT JOIN M5DB.m5db.dbo.Company CO
        ON AC.CompanyId = CO.Id
*/

