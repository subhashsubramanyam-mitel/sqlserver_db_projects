




CREATE view [oss].[VwServiceProduct_Ranked] as

				select SP.*, P.ServiceClassId ProdServiceClassId,
						 ROW_NUMBER() over (partition by serviceId, SP.productId 
												order by DateBillingValidFrom desc) RankNum
				from oss.VwServiceProduct2 SP with(nolock)
				left join enum.Product P on P.Id = SP.ProductId



