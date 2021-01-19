




CREATE view [oss].[VwService_Ranked] as

				select SP.*,
						 ROW_NUMBER() over (partition by serviceId
												order by DateBillingValidFrom desc, DateSvcCreated desc) RankNum
				from oss.VwServiceProduct SP with(nolock)



