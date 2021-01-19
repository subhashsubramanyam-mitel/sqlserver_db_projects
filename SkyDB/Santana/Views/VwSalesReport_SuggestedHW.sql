create view santana.VwSalesReport_SuggestedHW as
 -- for link to sales report for suggested hw.
 -- MW 06232020
with HW as 
(
SELECT  
		 a.tn
		,e.[Prod Name] as [Suggested Connect Hardware] 
		,row_number() over (partition by a.tn order by aa.AccountId desc) rn
  FROM 
		(
		SELECT  [tn]
			  ,[device]
		  FROM  
		[app_skydb].[SkyCSData] where  ISNUMERIC(device) = 1
		UNION ALL
		SELECT  [tn]
			  ,[device]
		  FROM  
		[app_skydb].[SkySipData] where  ISNUMERIC(device) = 1
		 )					 a inner join
		MWSandbox.ElvisHWMap b on a.device = b.Id inner join
		[$(FinanceBI)].provision.Tn t on a.tn = t.Id  and isnumeric( AccountId) = 1 inner join
		MWSandbox.MigrationCustList aa on t.AccountId = aa.AccountId inner join
	    [$(FinanceBI)].enum.VwProduct e on b.ProductId = e.[Prod Id]
)
 

select tn, [Suggested Connect Hardware] from HW where rn =1