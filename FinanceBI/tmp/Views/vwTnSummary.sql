CREATE view tmp.[vwTnSummary] as 
  Select S.[AccountId] A
      ,[LichenAccountid]
      ,S.[LocationId] L
      ,[LichenLocationId]
      ,Right(S.[Tn],10) Tn
      ,[CdrCallTypeid]
      ,[CdrServiceTypeId]
      ,[CdrRegionTypeId]
      ,[NumCalls]
      ,[Minutes]
      ,[Charge]
      ,[ServiceMonth]
	  ,T.*
  from usage.TNSummary S
  inner join provision.Tn T on T.Id = S.Tn  