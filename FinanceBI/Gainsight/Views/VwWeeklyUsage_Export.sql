
Create view gainsight.VwWeeklyUsage_Export as
-- MW 10142020  for export to Gainsight weekly usage
SELECT  
		a.CallDate ServiceMonth,
		a.PortalAccountId Accountid,
		p.LocationId,
		null as ProfileId,
		a.TN,
		null as TnExtension,
		null as CdrServiceTypeId,
		a.IsIncoming as CdrCallTypeId,
		null CdrRegionTypeId,
		null ClusterId,
		NumCalls,
		Minutes,
		Charge,
	   cast(DATEADD(day, -1*(DATEPART(WEEKDAY, a.CallDate)-1), a.CallDate) as DATE) as	ServiceWeek
  FROM [Gainsight].[mVwTnDailyUsageSummary] a left outer join
        people.Person p on a.PortalPersonId = p.Id