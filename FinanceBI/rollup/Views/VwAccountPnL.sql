



CREATE view [rollup].[VwAccountPnL] as
SELECT		foo.*
		,( CASE WHEN PC.L1 = 'Revenue' and PC.L2 = 'Seat' then Amount else 0 END) SeatRevenue
		,( CASE WHEN PC.L1 = 'Cost' and PC.L2 = 'Seat' then Amount else 0 END) SeatCost
		,( CASE WHEN PC.L2 = 'Seat' then Amount else 0 END) SeatProfit
		,( CASE WHEN PC.L1 = 'Revenue' and PC.L2 = 'Access' then Amount else 0 END) AccessRevenue
		,( CASE WHEN PC.L1 = 'Cost' and PC.L2 = 'Access' then Amount else 0 END) AccessCost
		,( CASE WHEN PC.L2 = 'Access'  then Amount else 0 END) AccessProfit
		,( CASE WHEN PC.L1 = 'Revenue' and PC.L2 = 'Options' then Amount else 0 END) OptionsRevenue
		,( CASE WHEN PC.L1 = 'Cost' and PC.L2 = 'Options' then Amount else 0 END) OptionsCost
		,( CASE WHEN PC.L2 = 'Options' then Amount else 0 END) OptionsProfit
		,( CASE WHEN PC.L1 = 'Revenue' and PC.L2 = 'Credits' then Amount else 0 END) TotalCredits
		,( CASE WHEN PC.L1 = 'Revenue' then Amount else 0 END) TotalRevenue
		,( CASE WHEN PC.L1 = 'Cost'  then Amount else 0 END) CMCost
		,( CASE WHEN 1=1  then Amount else 0 END) CMProfit
		,( CASE WHEN PC.L1 = 'Cost' and PC.L2 not in ('OpEx', 'Credits') then Amount else 0 END) GMCost
		,( CASE WHEN PC.L2 not in ('OpEx', 'Credits') then Amount else 0 END) GMProfit
FROM
	(	SELECT  -[Id] Id
			  ,[AccountId]
			  ,SvcMonth
			  ,[CostComponentId] PnLComponentId
			  ,null ProductId
			  ,[Cost] Amount
			  ,0 Quantity
		  FROM [rollup].[AccountCost] AC
		Union all
		SELECT [Id]
			  ,[AccountId]
			  ,SvcMonth
			  ,AR.[RevenueComponentId] PnLComponentId -- not all are products
			  ,AR.ProductId
			  ,[Revenue] Amount
			  ,Quantity
	  FROM [rollup].[AccountRevenue] AR

	 ) foo

	left join enum.PnLComponent PC on PC.Id = foo.PnLComponentId


