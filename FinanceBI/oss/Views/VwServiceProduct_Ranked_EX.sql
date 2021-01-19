







CREATE view [oss].[VwServiceProduct_Ranked_EX] as

				select SP.*, P.ServiceClassId ProdServiceClassId,
						 ROW_NUMBER() over (partition by serviceId, SP.productId 
												order by DateBillingValidFrom desc) RankNum
				from oss.VwServiceProduct_EX SP with(nolock)
				left join enum.Product P on P.Id = SP.ProductId






