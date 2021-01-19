CREATE view expinvoice.VwIACP_V4 as
--   * EX.EXCHRATE / 100 
select 
	[MRR Category]
      ,[Client]
      ,[AccountId]
      ,[LocationId]
      ,[Loc Name]
      ,[Account Team]
      ,[Order Creator]
      ,[Order PM]
      ,[Price Incr/Decr]     
      ,[New MRR]  * EX.EXCHRATE / 100  [New MRR]
      ,[Prev MRR]  * EX.EXCHRATE / 100  [Prev MRR]
      ,[MRR Delta]  * EX.EXCHRATE / 100  [MRR Delta]
	  ,CC.CurrencyCode
      ,[New MRR] [New MRR LC]
      ,[Prev MRR] [Prev MRR LC]
      ,[MRR Delta] [MRR Delta LC]
      ,[OrderId]
      ,[Order Type]
      ,[Order Status]
      ,[Order Name]
      ,[Date Created]
      ,[Date Closed]
      ,[Date Live Actual]
      ,[Portal ServiceId]
      ,[Svc Name]
      ,[Service Class]
      ,[Service Status]
      ,[CurrencyId]
  FROM [expinvoice].[IACP_V3] IA
	inner join    enum.CurrencyCode CC on CC.Id = IA.CurrencyId
	inner join (select getdate() dt ) D on 1=1
	inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and D.dt >= EX.DateFrom and D.dt < EX.DateTo