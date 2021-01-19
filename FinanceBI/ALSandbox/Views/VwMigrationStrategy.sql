CREATE VIEW ALSandbox.VwMigrationStrategy AS
SELECT *
	,SeatPriceDiff*Seats AS SeatDelta
	,CASE WHEN CourtesyPriceDiff > 0 THEN 0
		ELSE CourtesyPriceDiff * CourtesyProfile_Quantity END AS CourtDelta
	,CASE WHEN  VirtualPriceDiff > 0 THEN 0
		ELSE VirtualPriceDiff * VirtualProfile_Quantity END AS VirtDelta
	,CASE WHEN  AnalogPriceDiff > 0  THEN 0
		ELSE AnalogPriceDiff * AnalogProfile_Quantity END AS AnalogDelta
	,CASE WHEN ScribePriceDiff  > 0  THEN 0
		ELSE ScribePriceDiff * Scribe_Quantity END AS ScribeDelta
	,CASE WHEN  CallRecordingPriceDiff  > 0 THEN 0
		ELSE CallRecordingPriceDiff * CallRecording_Quantity END AS CR_Delta
	,CASE WHEN FaxPriceDiff   > 0 THEN 0
		ELSE FaxPriceDiff * Fax_Quantity END AS FaxDelta
	,CASE WHEN [Primary Handset] like 'IP4nn%' THEN 0
		ELSE (Seats + CourtesyProfile_Quantity)*6 - Rental_TotalMRR 
		END AS RentalDelta
	,CASE WHEN [Call Center] = 'Yes' THEN 1495
			ELSE 0
			END AS CC_NRR
	,(Seats + CourtesyProfile_Quantity+VirtualProfile_Quantity+AnalogProfile_Quantity)*50 AS Bundle_NRR
FROM

(
SELECT *
	,[New_SeatPrice]-[Seat Price] AS SeatPriceDiff
	,New_CourtesyProfile_Price - CourtesyProfile_Price AS CourtesyPriceDiff
	,New_VirtualProfile_Price - VirtualProfile_Price AS VirtualPriceDiff
	,New_Scribe_Price - Scribe_Price AS ScribePriceDiff
	,New_CallRecording_Price - CallRecording_Price AS CallRecordingPriceDiff
	,New_Fax_Price - Fax_Price AS FaxPriceDiff
	,New_AnalogProfile_Price - AnalogProfile_Price AS AnalogPriceDiff

	,ROW_NUMBER()	
		OVER(ORDER BY [At Risk Now] ASC
					  ,[Call Center] ASC
					  ,Age/12 ASC
					  ,MRR ASC
			) AS ChurnRisk
			
	,ROW_NUMBER()
		OVER( ORDER BY CASE WHEN [Primary Handset] = 'IP4nn' THEN 3
							WHEN [Primary Handset] IS NULL THEN 2
							ELSE 1 
							END ASC
						,CASE WHEN LocCount = 0 THEN 0
							ELSE MRR / [LocCount]
							END ASC
					   --Partner
					   ,AllOffNet ASC
			) AS Benefit
	,CASE WHEN [At Risk Now] = 1
			THEN 'Group 1 - At Risk'
		  WHEN [Call Center] = 'Yes'
			THEN 'Group 2 - SCC'
		  WHEN [Seat Segment] = '100+'
			THEN 'Group 3 - Remaining 100+'
		  WHEN [Primary Handset] = 'IP4nn' AND [Age]/12.00 > 3
			THEN 'Group 4 - IP400 & > 3 years'
		  WHEN [Age] / 12.00 > 4 
			THEN 'Group 5 - Age > 4 Years'
		END AS Groups

FROM 
(

select 
	[Ac Id] as [Acct ID]
	,[Ac Name] as [Name]
	,[Ac ActiveMRR] as [MRR]
	,[Cluster] as [Instance]
	,datediff(month,[DateFirstInvoiced],getdate()) as [Age]
	--,[EndDate] as [Renewal Date] 
	,CASE WHEN [PrimaryHandset] IS NOT NULL THEN PrimaryHandset
		WHEN Cluster IN ('GRA','JAK','KAY','OLA','RED','ABE','ICE','LOU','WIL','YIN','SKY') THEN 'Cisco - Assumed' 
		WHEN Cluster IN ('PEZ','OBI','KIP','JIL') THEN 'IP4nn - Assumed'
		END as [Primary Handset]
	,COALESCE([AtRiskNow],0) as [At Risk Now]
	,COALESCE([Times at Risk],0) AS [Times at Risk]
	,[Date of Most Recent At Risk]
	,CASE WHEN LocCount > 1 THEN 'MULTI' ELSE 'SINGLE' END AS [Location Segment]
	,LocCount
	,OnNetPercent
	,CASE WHEN OnNetPercent = 0 THEN 1 ELSE 0 END AS AllOffNet
	,CASE WHEN [Seat Price] < $36 THEN 'UNDER' ELSE 'OVER' END AS [Above $36/SEAT]
	
	,CASE WHEN [CCPlatformName] IS NULL THEN 'No' ELSE 'Yes' END AS [Call Center]
	,CASE 
		WHEN ManagedProfile_Quantity < 10 THEN 'UNDER 10'
		WHEN ManagedProfile_Quantity < 26 THEN '10-25'
		WHEN ManagedProfile_Quantity < 51 THEN '26-50'
		WHEN ManagedProfile_Quantity < 76 THEN '51-75'
		WHEN ManagedProfile_Quantity < 101 THEN '76-100'
		ELSE '100+' END as [Seat Segment]
	,[Seat Price]
	,CASE WHEN ManagedProfile_Quantity <= 10 THEN 30.99
		WHEN ManagedProfile_Quantity <= 50 THEN 27.89
		WHEN ManagedProfile_Quantity <= 100 THEN 26.34
		WHEN ManagedProfile_Quantity <= 500 THEN 24.79
		WHEN ManagedProfile_Quantity <= 1000 THEN 21.69
		WHEN ManagedProfile_Quantity > 1000 THEN 20.14
		END AS New_SeatPrice
	,ManagedProfile_Quantity as  [Seats]
	,CourtesyProfile_Quantity
	,CourtesyProfile_Price
	,14.99 AS New_CourtesyProfile_Price
	,VirtualProfile_Quantity
	,VirtualProfile_Price
	,14.99 AS New_VirtualProfile_Price
	,AnalogProfile_Quantity
	,AnalogProfile_Price
	,14.99 AS New_AnalogProfile_Price
	,Scribe_Quantity
	,Scribe_Price
	,5.99 AS New_Scribe_Price
	,CallRecording_Quantity
	,CallRecording_Price
	,CASE WHEN ManagedProfile_Quantity <= 10 THEN 37.99-30.99
		WHEN ManagedProfile_Quantity <= 50 THEN 34.19-27.89
		WHEN ManagedProfile_Quantity <= 100 THEN 32.29-26.34
		WHEN ManagedProfile_Quantity <= 500 THEN 30.39-24.79
		WHEN ManagedProfile_Quantity <= 1000 THEN 26.59-21.69
		WHEN ManagedProfile_Quantity > 1000 THEN 24.69-20.14
		END AS New_CallRecording_Price
	,Fax_Quantity
	,Fax_Price
	,10 AS New_Fax_Price
	,Rental_TotalMRR
	,OnNetLocCount

from [company].[VwAccount] as acct
--left join [ALSandbox].[VwMostRecentContract] as cntrct
--	on cntrct.AccountId = acct.[Ac Id]
left join ALSandbox.VwCurrentAtRiskStatus as atrsk
	on atrsk.M5DBAccountId = acct.[Ac Id]
left join 
	(SELECT AccountId
		,CASE WHEN COUNT(*) = 0 THEN  0
			ELSE SUM([Loc IsOnNet]) * 1.0000 /COUNT(*) 
			END AS OnNetPercent
		,SUM([Loc IsOnNet]) AS OnNetLocCount
		,COUNT(*) AS LocCount
	FROM company.VwLocation
	GROUP BY AccountId
	) L
	ON L.AccountId = acct.[Ac Id]
left join 
	(
		select
			[M5DBAccountId],
			count(id) as [Times at Risk],
			max(closedate) as [Date of Most Recent At Risk]
		from
			(
			SELECT M5DBAccountId
				,ID
				,case
					when datesaved is null and datelost is not null then datelost
					when datelost is null and datesaved is not null then datesaved
					when datelost is null and datesaved is null then getdate()
					when datelost > datesaved then datelost
					else datesaved 
				end as closedate
			from sfdc.vwars
			) as tbl1
		group by M5DBAccountId
	) as ARS
	on ARS.[M5DBAccountId] = acct.[Ac Id]

left join 
	(
	select 
		[AccountId]
		,avg(CASE WHEN ProdSubCategory = 'Managed Profiles'
				and [Prod Category] = 'Profiles'
			THEN MonthlyCharge
			ELSE NULL 
			END) as [Seat Price]
		,SUM(CASE WHEN ProdSubCategory = 'Managed Profiles'
				and [Prod Category] = 'Profiles'
			THEN 1
			ELSE 0
			END) AS ManagedProfile_Quantity
		,SUM(CASE WHEN ProdSubCategory = 'Courtesy Profiles'
				and [Prod Category] = 'Profiles'
			THEN 1
			ELSE 0
			END) AS CourtesyProfile_Quantity
		,avg(CASE WHEN ProdSubCategory = 'Courtesy Profiles'
				and [Prod Category] = 'Profiles'
			THEN MonthlyCharge
			ELSE NULL
			END) AS CourtesyProfile_Price
		,SUM(CASE WHEN ProdSubCategory = 'Virtual Profiles'
				and [Prod Category] = 'Profiles'
			THEN 1
			ELSE 0
			END) AS VirtualProfile_Quantity
		,avg(CASE WHEN ProdSubCategory = 'Virtual Profiles'
				and [Prod Category] = 'Profiles'
			THEN MonthlyCharge
			ELSE NULL
			END) AS VirtualProfile_Price
		,SUM(CASE WHEN ProdSubCategory = 'Analog Profiles'
				and [Prod Category] = 'Profiles'
			THEN 1
			ELSE 0
			END) AS AnalogProfile_Quantity
		,avg(CASE WHEN ProdSubCategory = 'Analog Profiles'
				and [Prod Category] = 'Profiles'
			THEN MonthlyCharge
			ELSE NULL
			END) AS AnalogProfile_Price
		,SUM(CASE WHEN ProdSubCategory = 'Scribe'
			THEN 1
			ELSE 0
			END) AS Scribe_Quantity
		,AVG(CASE WHEN ProdSubCategory = 'Scribe'
			THEN MonthlyCharge
			ELSE NULL
			END) AS Scribe_Price
		,SUM(CASE WHEN ProdSubCategory = 'Call Recording'
			THEN 1
			ELSE 0
			END) AS CallRecording_Quantity
		,avg(CASE WHEN ProdSubCategory = 'Call Recording'
			THEN MonthlyCharge
			ELSE NULL
			END) AS CallRecording_Price
		,SUM(CASE WHEN lower([Prod Name]) like '%fax%'
			THEN 1
			ELSE 0
			END) AS Fax_Quantity
		,avg(CASE WHEN lower([Prod Name]) like '%fax%'
			THEN MonthlyCharge
			ELSE NULL
			END) AS Fax_Price
		,SUM(CASE WHEN [Class Group] = 'Rental Phones'
			THEN MonthlyCharge
			ELSE 0
			END) AS Rental_TotalMRR
	from [oss].[VwServiceProduct_EX] as sc
	left join [enum].[VwProduct] as pr
		on pr.[Prod Id] = sc.[ProductId]
	where ServiceStatusId IN (1,16,27)

	group by AccountId
	) as asdf
	on asdf.[AccountId] = acct.[Ac Id]

where acct.IsBillable = 1
	and [Platform]  = 'Call Conductor'
	and NumProfilesLastMonth != 0
) A


) B
-- Look at product counts and associated MRR 

--select [Prod Name],  
--		sum(MonthlyCharge) as [MRR],
--		count([Prod Id]) as [Count]
--from [oss].[VwServiceProduct_EX] as svc
--left join enum.vwproduct as prod
--	on prod.[Prod Id] = svc.productid
--where svcplatform = 'Call Conductor' and [ServiceStatusId] != 5
--group by [Prod Name]
--order by sum(MonthlyCharge) desc









