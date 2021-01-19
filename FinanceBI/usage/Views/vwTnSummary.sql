


CREATE view usage.[vwTnSummary]
  as 
  Select S.[AccountId]
      ,[LichenAccountid]
      ,S.[LocationId]
      ,[LichenLocationId]
      ,Right(S.[Tn],10) Tn
      ,[CdrCallTypeid]
      ,[CdrServiceTypeId]
      ,[CdrRegionTypeId]
      ,[NumCalls]
      ,[Minutes]
      ,[Charge]
      ,[ServiceMonth]
  from usage.TNSummary S
  inner join provision.VwUniqueTn T on Right(T.Id,10) = Right(S.Tn,10)
  --where coalesce(S.TN,'') <> ''



