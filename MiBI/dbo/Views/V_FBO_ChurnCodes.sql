





CREATE view [dbo].[V_FBO_ChurnCodes] as 
 -- MW 10202020  to be included in jason's Costgaurd churn reporting. Referenced from CostguardBI

SELECT
		 b.OtherERPNumber as CustomerNumber
		,[RootCausePrimary]
		,[RootCauseSecondary]
		,RelatedProduct
		,max ([EffectiveMRRChangeDate]) as ed
		,row_number() over (partition by b.OtherERPNumber order by  RootCausePrimary) rn
FROM  
	ARS a inner join
	CUSTOMERS b on a.AccountID = b.SfdcId
where  
			b.CustomerType = 'MiCloud Flex' 
		and a.[Status] = 'Lost'
Group by
		 b.OtherERPNumber  
		,[RootCausePrimary]
		,[RootCauseSecondary]
		,RelatedProduct
