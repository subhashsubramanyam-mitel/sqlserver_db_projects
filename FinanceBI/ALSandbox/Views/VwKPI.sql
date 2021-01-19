CREATE VIEW ALSandbox.VwKPI AS

WITH CTE AS (
--  MRR Delta
SELECT CASE WHEN [MRR Category] = 'Install' THEN 'New Installs'
			 WHEN [MRR Category] IN ('Add', 'Reinstated') THEN 'Adds'
			 ELSE 'MRR Loss' 
			 END AS KPI
	,Region
	,ServiceMonth
	,SUM(MRR) AS 'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwMidMonthMRRDelta_Global
WHERE PipelineStage in ('Secured', 'Reinstated', 'AOP')
	AND ServiceMonth < GETDATE()
	AND ServiceMonth >= dateadd(month,-14,GETDATE())
	AND (Region NOT IN ('EMEA','UK','APAC','ANZ') OR ServiceMonth >= '20170701') -- Do not include APAC and EMEA until FY18 when their targets are included
GROUP BY CASE WHEN [MRR Category] = 'Install' THEN 'New Installs'
			  WHEN [MRR Category] IN ('Add', 'Reinstated') THEN 'Adds'
			  ELSE 'MRR Loss' 
			  END
		,ServiceMonth
		,Region

-- Migration
UNION ALL

SELECT 'Sky to Connect Migrations' KPI
	,Region
	,dateadd(month, -1,InvoiceMonth) AS ServiceMonth
	,SUM([MRR Delta]) AS 'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,[MRR Category] AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM invoice.VwMatVwIncrMRRNRR_EX MRRD
LEFT JOIN ALSandbox.VwAccountWRegion A
	ON A.[Ac Id] = MRRD.AccountId
WHERE [MRR Category] IN ('Migrate In')
GROUP BY Region, InvoiceMonth,[MRR Category] 

-- CSAT
UNION ALL

SELECT CASE WHEN lower(CustomerType) LIKE '%onsite%' OR lower(CustomerType) LIKE 'hybrid%'
				THEN 'Onsite Support CSAT' 
				ELSE 'Hosted Support CSAT' 
				END AS KPI
	,CASE WHEN Theater  = 'North America' THEN Region 
		ELSE Theater 
		END AS Region  
	,dateadd(month, DATEDIFF(month, 0 , ResponseReceivedDate),0) AS ServiceMonth
	,AVG(PrimaryScore / 1.0000) AS 'Value'
	,COUNT(S.ID) AS NumRecords
	,STDEV(PrimaryScore) AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM [$(MiBI)].dbo.Surveys S
LEFT JOIN [$(MiBI)].dbo.CUSTOMERS C
	ON S.AccountID COLLATE SQL_Latin1_General_CP1_CS_AS 
		= C.SfdcId COLLATE SQL_Latin1_General_CP1_CS_AS 

WHERE ResponseReceivedDate >=  dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND DataCollectionName = 'ShoreTel Technical Support Survey'
	AND CustomerType != 'Former Customer'
GROUP BY CASE WHEN Theater = 'North America' THEN Region 
		ELSE Theater 
		END
	,CASE WHEN lower(CustomerType) LIKE '%onsite%' OR lower(CustomerType) LIKE 'hybrid%'
				THEN 'Onsite Support CSAT' 
				ELSE 'Hosted Support CSAT' 
				END
	,dateadd(month, DATEDIFF(month, 0 , ResponseReceivedDate),0) 

-- NPS
UNION ALL

SELECT 'Hosted NPS' AS KPI
	,CASE WHEN Theater  = 'North America' THEN Region 
		ELSE Theater 
		END AS Region  
	,dateadd(month, DATEDIFF(month, 0 , ResponseReceivedDate),0) AS ServiceMonth
	,(SUM(CASE WHEN PrimaryScore >8 THEN 1.000 ELSE 0.000 END) 
		- SUM(CASE WHEN PrimaryScore < 7 THEN 1.000 ELSE 0.000 END))
		/SUM(CASE WHEN PrimaryScore IS NOT NULL THEN 1.000 ELSE 0.000 END) * 100 AS'Value' -- NPS Calculation
	,COUNT(S.ID) AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,SUM(CASE WHEN PrimaryScore >8 THEN 1 ELSE 0 END)  AS Promoters
	,SUM(CASE WHEN PrimaryScore < 7 THEN 1 ELSE 0 END) AS Detractors
	,NULL AS Total
FROM [$(MiBI)].dbo.Surveys S
LEFT JOIN [$(MiBI)].dbo.CUSTOMERS C
	ON S.AccountID COLLATE SQL_Latin1_General_CP1_CS_AS 
		= C.SfdcId COLLATE SQL_Latin1_General_CP1_CS_AS 

WHERE ResponseReceivedDate >=  dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND lower(DataCollectionName) LIKE '%nps%'
	AND (CustomerType != 'Former Customer' OR C.M5DBAccountID IS NOT NULL)
	AND lower(CustomerType) NOT LIKE 'hybrid%'
	AND lower(CustomerType) NOT LIKE '%onsite%'
	AND PrimaryScore IS NOT NULL
GROUP BY CASE WHEN Theater = 'North America' THEN Region 
		ELSE Theater 
		END
	,dateadd(month, DATEDIFF(month, 0 , ResponseReceivedDate),0) 

-- New Opportunity Creation
UNION ALL

SELECT 'New Opportunity Creation' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0 , CreateDateAdjFromUTC),0) AS ServiceMonth -- Start of month (Adjusted back 8 hours from UTC)
	,COUNT(OpportunityID) AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE RecordType = 'Standard'
	AND CASE WHEN lower(Name) LIKE  'cloud migration quote:%' 
			 THEN CASE WHEN Qualified = 'true'
					   THEN 1
					   ELSE 0
					   END
		ELSE CASE WHEN (EstimatedMRR > 0 OR lower(ProductInterest) LIKE '%cloud service%')
			      THEN 1
				  ELSE 0
				  END
		END	= 1 
	AND ([Type] IS NULL OR [Type] != 'Moves, Splits, Changes')
	AND (OwnerName IS NULL OR OwnerName != 'Alan Davies (Sky Admin)')
	AND (SubType IS NULL OR SubType != 'Cross-Sell')
	AND (Name IS NULL OR lower(Name) NOT LIKE '%corvisa import%')
	AND CreateDateAdjFromUTC >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0 , CreateDateAdjFromUTC),0)

-- Hosted Bookings
UNION ALL

SELECT 'Hosted Bookings' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0) AS ServiceMonth -- Start of month 
	,SUM(EstimatedMRR) AS'Value'
	,COUNT(OpportunityID) AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE (RecordType IS NULL OR RecordType != 'Secondary')
	AND EstimatedMRR > 0 
	AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
	AND ([Type] IS NULL OR [Type] != 'Moves, Splits, Changes')
	AND Won = 'true'
	AND CloseDate >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0)

-- Hosted Bookings (EMEA/APAC)
UNION ALL

SELECT 'Hosted Bookings (EMEA/APAC)' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0) AS ServiceMonth -- Start of month 
	,SUM(EstimatedMRR) AS'Value'
	,COUNT(OpportunityID) AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE (RecordType IS NULL OR RecordType != 'Secondary')
	AND EstimatedMRR > 0 
	AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
	AND ([Type] IS NULL OR [Type] != 'Moves, Splits, Changes')
	AND Won = 'true'
	AND CloseDate >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND Region IN ('EMEA', 'APAC')
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0)

-- Cross Sell 
UNION ALL

SELECT 'Cross-Sell' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0) AS ServiceMonth -- Start of month 
	,SUM(EstimatedMRR) AS'Value'
	,COUNT(OpportunityID) AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE (RecordType IS NULL OR RecordType != 'Secondary')
	AND EstimatedMRR > 0 
	AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
	AND ([Type] IS NULL OR [Type] != 'Moves, Splits, Changes')
	AND Won = 'true'
	AND CloseDate >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND SubType = 'Cross-Sell'
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0)

-- New Cloud Bookings on Connect
UNION ALL

SELECT 'New Cloud Bookings on Connect' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0) AS ServiceMonth -- Start of month 
	,SUM(CASE WHEN lower(SubType) LIKE '%connect%' 
                    OR (Region = 'EMEA' AND SubType = 'Private and Other Cloud')
				THEN EstimatedMRR 
				ELSE 0 END) AS'Value'
	,COUNT(OpportunityID) AS NumRecords
	,NULL AS StdDev
	,SUM(EstimatedMRR) AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE (RecordType IS NULL OR RecordType != 'Secondary')
	AND EstimatedMRR > 0 
	AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
	AND [Type] LIKE '%New Business%'
	AND Won = 'true'
	AND CloseDate >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND SubType NOT LIKE 'Flex CC%'
	AND lower(SubType) NOT LIKE '%onsite%'
	AND lower(SubType) NOT LIKE '%premise%'
	AND NOT (Region = 'APAC' AND CloseDate < '20170609')
	AND NOT (Region LIKE 'US%' AND SubType = 'Private and Other Cloud')
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0)

-- PBL Bookings
UNION ALL

SELECT 'PBL Bookings' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0) AS ServiceMonth -- Start of month 
	,SUM(EstimatedMRR) AS'Value'
	,COUNT(OpportunityID) AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE (RecordType = 'Standard' OR RecordType = 'Cloud_Account_Management')--(RecordType IS NULL OR RecordType != 'Secondary')
	AND EstimatedMRR > 0 
	AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
	AND Won = 'true'
	AND CloseDate >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND SubType IN ('Add Cloud Site to Onsite Customer', 'Migrate Premises to Cloud')
	AND (PartnerSelectedCampaign IS NULL OR PartnerSelectedCampaign NOT LIKE '%Trade-Up to ShoreTel%')
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0)

-- Premise Migrations to Cloud
UNION ALL

SELECT 'Premises Migrations to Cloud' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0) AS ServiceMonth -- Start of month 
	,COUNT(OpportunityID) AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE RecordType = 'Standard' --(RecordType IS NULL OR RecordType != 'Secondary')
	AND EstimatedMRR > 0 
	AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
	AND Won = 'true'
	AND CloseDate >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND SubType = 'Migrate Premises to Cloud'
	AND (PartnerSelectedCampaign IS NULL OR PartnerSelectedCampaign != 'Avaya Trade-Up to ShoreTel')
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0)

-- Cloud Bookings in New Connect Markets
UNION ALL

SELECT 'Cloud Bookings in New Connect Markets' AS KPI
	,Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0) AS ServiceMonth -- Start of month 
	,SUM(EstimatedMRR) AS'Value'
	,COUNT(OpportunityID) AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.VwOppKPI
WHERE (RecordType IS NULL OR RecordType != 'Secondary')
	AND EstimatedMRR > 0 
	AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
	AND Won = 'true'
	AND CloseDate >= dateadd(month, DATEDIFF(month, 0, dateadd(month,-14,GETDATE())),0)
	AND (lower(SubType) LIKE '%connect%'
		OR SubType = 'Migrate Premises to Cloud')
	AND Region NOT LIKE 'US%'
	AND ([Type] IS NULL OR [Type] != 'Moves, Splits, Changes')
	AND lower(Name) NOT LIKE '%test%'
	AND lower(Name) NOT LIKE '%training%'
	AND lower(Name) NOT LIKE '%demo%'
GROUP BY Region
	,dateadd(month, DATEDIFF(month, 0, CloseDate),0)

-- ServiceAvailability
UNION ALL

SELECT 'User Minutes Down' AS KPI
	,'Global' AS Region
	,ServiceMonth
	,UserMinDown AS'Value'
	,ActiveUsers AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL  AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_UserMinDown

UNION ALL

SELECT 'Service Availability - ' + Direction AS KPI
	,'Global' AS Region
	,ServiceMonth
	,MinDown AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NumComponents
	,ComponentType
	,Method AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_SvcAvail

-- Incoming Defects

UNION ALL

SELECT 'High Priority Defects Incoming' AS KPI
	,'Global' AS Region
	,ServiceMonth
	,DefectCount AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_IncomingHPD

-- EOM Defects

UNION ALL

SELECT 'Outstanding High Priority Defects at Month End' AS KPI
	,'Global' AS Region
	,ServiceMonth
	,DefectCount AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_EOM_HPD

-- EOM Defects

UNION ALL

SELECT 'SIP and Platform Billings' AS KPI
	,'Global' AS Region
	,ServiceMonth
	,Billings AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_CorvBillings

-- Summit Accounts

UNION ALL

SELECT 'Summit Account Growth' AS KPI
	,'Global' AS Region
	,ServiceMonth
	,Qty AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,AcSize AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_SummitAccounts

-- Onsite Upgrades
UNION ALL

SELECT 'Premises Upgrades to Connect Onsite' AS KPI
	,'Global' AS Region
	,ServiceMonth
	,CustomerCount AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_OnsiteUpgrades

-- New Onsite on Connect
UNION ALL

SELECT 'New Onsite Customers on Connect' AS KPI
	,'Global' AS Region
	,ServiceMonth
	,NewConnectCustomers AS'Value'
	,NewCustomersTotal AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NewCustomersTotal AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_NewOnsiteConnect


-- Non-NorthAmerica Onsite Billings
UNION ALL

SELECT 'Onsite Billings (EMEA/APAC)' AS KPI
	,Region AS Region
	,ServiceMonth
	,Billings AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_NonNA_OnsiteBillings


-- Non-NorthAmerica Onsite Billings
UNION ALL

SELECT 'Hosted Revenue (EMEA/APAC)' AS KPI
	,Region AS Region
	,ServiceMonth
	,HostedRevenue AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_NonNA_HostedRev

-- NorthAmerica Hosted Revenue
UNION ALL

SELECT 'Hosted Revenue' AS KPI
	,Region AS Region
	,ServiceMonth
	,HostedRevenue AS 'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,RevenueSource AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_HostedRevenue

/*
-- SHV Hosted Revenue
SELECT 'Hosted Revenue (EMEA/APAC)' AS KPI
	,'APAC' AS Region
	,dateadd(month,-1,ServiceMonth) AS InvMonth
	,SUM(Charge)*EX.exchrate/100 AS Value
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
  FROM [SMD].[SMD].[dbo].[Australia_SHV_BillingsData] SHV
  INNER JOIN [SMD].[SMD].[dbo].[V_AX_EXCHRATE_ALL] EX
	ON dateadd(day,-1,dateadd(month,-1,ServiceMonth)) = EX.FromDate
  WHERE lower(ChargeType) != 'tax'
	AND currencycode = 'AUD'
  GROUP BY ServiceMonth
	, EX.exchrate
*/


-- ASA

UNION ALL

SELECT CASE WHEN Team = 'Onsite T1' THEN 'Onsite ASA' 
			WHEN Team IN ('All ACC Combined', 'Cloud T1') THEN 'Hosted ASA' END AS KPI
	,'Global' AS Region
	,[Date] AS ServiceMonth
	,ASA AS 'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,CASE WHEN Team = 'All ACC Combined' THEN 'ACC' ELSE Team END AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,NULL AS Total
FROM ALSandbox.KPI_ASA

-- B2B
UNION ALL

SELECT 'B2B' AS KPI
	,Region AS Region
	,dateadd(month, datediff(month,0,DateSvcLiveActual),0) AS ServiceMonth
	,SUM(B2BxMRR) AS'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,SUM(MonthlyCharge) AS Total
FROM ALSandbox.VwB2B_Global B2B
WHERE B2BxMRR IS NOT NULL
	AND B2B >= 0
	AND DateSvcLiveActual <= eomonth(GETDATE(),0)
GROUP BY Region
	,dateadd(month, datediff(month,0,DateSvcLiveActual),0)

/*
-- Agings > 90
UNION ALL

SELECT 'Aging > 90' AS KPI
	,Region AS Region
	,[Date] AS ServiceMonth
	,SUM(CASE WHEN Age > 90 THEN MonthlyCharge ELSE 0 END) AS 'Value'
	,NULL AS NumRecords
	,NULL AS StdDev
	,NULL AS TotalBookings
	,NULL AS NumComponents
	,NULL AS ComponentType
	,NULL AS 'Type'
	,NULL AS TotalCustomers
	,NULL AS Promoters
	,NULL AS Detractors
	,SUM(MonthlyCharge) AS Total
FROM
	(
	SELECT [Date]
			,DATEDIFF(dd,coalesce([Date Closed], DateInitialOrderCreated),D.[Date]) AS Age
			,Region
			,SUM(MonthlyCharge) AS MonthlyCharge
		FROM 
			(SELECT [Date] FROM enum.VwDate WHERE (eomonth([Date],0) = [Date] OR [Date] = GETDATE()) AND YEAR([Date]) >= 2017 AND [Date] <= GETDATE()) D -- EOM OR Today
		LEFT JOIN ALSandbox.VwB2B_Global B2B
			ON D.[Date] >= coalesce([Date Closed], DateInitialOrderCreated)
				AND (D.[Date] <= coalesce(DateSvcSetToActive, DateSvcVoided) OR coalesce(DateSvcSetToActive, DateSvcVoided) IS NULL)
		WHERE MonthlyCharge != 0
		GROUP BY [Date]
			,DATEDIFF(dd,coalesce([Date Closed], DateInitialOrderCreated),D.[Date])
			,Region
	) Aging
GROUP BY [Date]
	,Region
*/
)		

SELECT tbl1.*
	,D.RuthlessPriority
	,D.ValueDesc
	,D.Timeframe
	,D.RP_Order
	,D.KPI_Order
	,D.DashboardURL
	,D.RegionalView
	,D.Active AS ActiveKPI
	,D.Category
	,D.Category_Order
	,D.SubCategory
	,D.SubCategory_Order
	,D.FY_Relevant
FROM 
	(
	SELECT COALESCE(CTE.KPI, T.KPI) AS KPI
		,COALESCE(CTE.Region COLLATE SQL_Latin1_General_CP1_CI_AS 
			,T.Region COLLATE SQL_Latin1_General_CP1_CI_AS ) AS Region
		,COALESCE(CTE.ServiceMonth, T.ServiceMonth) AS ServiceMonth
		,CTE.[Value]
		,CTE.NumRecords
		,CTE.StdDev
		,CTE.TotalBookings
		,CTE.NumComponents
		,CTE.ComponentType
		,CTE.[Type]
		,CTE.TotalCustomers
		,CTE.Promoters
		,CTE.Detractors
		,CTE.[Total]
		,T.GreenThreshold
		,T.YellowThreshold 
	FROM CTE 
	FULL OUTER JOIN 
		(
		SELECT KPI
			,COALESCE(Region,'Global') AS Region
			,ServiceMonth 
			,TargetType
			,SUM(GreenThreshold) AS GreenThreshold
			,SUM(YellowThreshold) AS YellowThreshold
		FROM ALSandbox.ExecKPITargets
		GROUP BY KPI
			,Region
			,ServiceMonth 
			,TargetType
		) T
	ON CTE.ServiceMonth = T.ServiceMonth
		AND CTE.KPI = T.KPI
		AND CTE.Region COLLATE SQL_Latin1_General_CP1_CI_AS 
			=T.Region COLLATE SQL_Latin1_General_CP1_CI_AS
		AND ( (CTE.[Type] IS NULL) OR (CTE.[Type] = T.TargetType)) 
	) tbl1
INNER JOIN ALSandbox.KPI_Details D
ON D.KPI COLLATE SQL_Latin1_General_CP1_CI_AS
		= tbl1.KPI COLLATE SQL_Latin1_General_CP1_CI_AS
--WHERE D.KPI IN ('Hosted Revenue (EMEA/APAC)', 'Onsite Billings (EMEA/APAC)')

--ORDER BY KPI, Region, [Type], ServiceMonth