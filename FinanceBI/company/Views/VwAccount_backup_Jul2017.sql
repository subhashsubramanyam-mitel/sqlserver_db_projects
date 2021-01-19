





Create VIEW [company].[VwAccount_backup_Jul2017]
AS
SELECT     A.Id AS [Ac Id], A.Name AS [Ac Name], A.ParentAccountId, A.LichenAccountId, A.PartnerId,
 A.IsActive, A.OutDialDigit, A.Number AS [Ac Number], AA.AccountStatus AS [Ac Status], 
                      Coalesce(AA.IsBillable,0) IsBillable, Coalesce(AA.CreditHoldtype, 'Unspecified') CreditRisk,
                      AA.DateFirstInvoiced, AA.DateFirstServiceLive, COALESCE (AA.ActiveMRR, 0.0) AS [Ac ActiveMRR], COALESCE (AA.NumLocationsWithSeats, 0) 
                      AS NumLocationsWithSeats, COALESCE(AA.NumProfiles,0) as NumProfiles, COALESCE (AA.NumLocationsTotal, 0) AS NumLocationsTotal, 
                      COALESCE (AA.NumLocationsActive, 0) AS NumLocationsActive, 
                      COALESCE (AA.NumLocationsPending, 0) AS NumLocationsPending, 
                      AA.AccountTeam AS [Ac Team], AC.Name AS [Ac Industry], 
                      ASubC.Name AS [Ac SubIndustry], PT.Name AS Platform, C.Name AS Cluster, CT.Name AS [Company Type], A.AccountSubCategoryId, 
                      A.AccountCategoryId, A.CompanySalesChannelId, A.PrimaryClusterId,
                      ANPS.FirstScore, 
                      ANPS.DateFirstScored, 
                      CASE 
						WHEN ANPS.FirstScore is null then null 
						WHEN ANPS.FirstScore > 8 then 1 -- Promoter
						WHEN ANPS.FirstScore < 7 then -1 -- Detractor
						ELSE 0
					  END as FirstNPS,
                      ANPS.LastScore, ANPS.DateLastScored,
                      CASE 
						WHEN ANPS.LastScore is null then null 
						WHEN ANPS.LastScore > 8 then 1 -- Promoter
						WHEN ANPS.LastScore < 7 then -1 -- Detractor
						ELSE 0
					  END as LastNPS, 
 CallCenter.CCClusterName,
 CallCenter.CCPlatformName,
 AA.DateLastInvoiced,
 COALESCE(AA.NumPendingProfiles,0) as NumPendingProfiles,
 DATEDIFF(month, DateFirstInvoiced, DateLastInvoiced)+1 MonthsInService,
 A.IsHybrid,
 AA.AccountManagerId,
 Coalesce(AA.NumCisco,0) NumCisco, Coalesce(AA.NumIP4nn,0) NumIP4nn, AA.PrimaryHandset,
 Coalesce(MBS.NumProfiles,0) NumProfilesLastMonth,
 SMR.SMRClusterName,
 SMR.SMRPlatformName,
 AM.SfdcTerritoryId
                      
FROM         company.Account AS A 
LEFT OUTER JOIN company.AccountAttr AS AA ON A.Id = AA.AccountId 
LEFT OUTER JOIN oss.VwAccountNPS as ANPS ON A.Id = ANPS.AccountId
LEFT OUTER JOIN enum.AccountCategory AS AC ON A.AccountCategoryId = AC.Id 
LEFT OUTER JOIN enum.AccountSubCategory AS ASubC 
	ON A.AccountSubCategoryId = ASubC.Id AND AC.Id = ASubC.AccountCategoryId 
LEFT OUTER JOIN enum.CompanyType AS CT ON A.CompanyTypeId = CT.Id 
LEFT OUTER JOIN enum.Cluster AS C ON A.PrimaryClusterId = C.Id 
LEFT OUTER JOIN enum.PlatformType AS PT ON C.PlatformTypeId = PT.Id
LEFT OUTER JOIN (
	SELECT AccountId, CCClusterName, CCPlatformName 
	FROM 
		(SELECT AC.AccountId,  
			ROW_NUMBER () over (PARTITION BY AC.AccountId ORDER BY PT.Id DESC) num,
			CC.Name CCClusterName,
			PT.Name CCPlatformName
		FROM company.Account A
		INNER JOIN company.AccountCluster AC on AC.AccountId = A.Id 
		INNER JOIN enum.Cluster CC on CC.Id = AC.ClusterId 
		INNER JOIN enum.PlatformType PT on PT.Id = CC.PlatformTypeId and PT.Id in ( 3, 6, 19)
		) foo
		where num =1
		) CallCenter on CallCenter.AccountId = A.id
INNER JOIN (Select dbo.UfnFirstOfMonth(DateAdd(month, -1, getdate())) LastMonth) M on 1=1
LEFT JOIN invoice.AccountMonthlyBillingStats MBS on MBS.AccountId = A.Id and MBS.InvoiceMonth = M.LastMonth
LEFT OUTER JOIN (
	SELECT AccountId, SMRClusterName, SMRPlatformName 
	FROM 
		(SELECT AC.AccountId,  
			ROW_NUMBER () over (PARTITION BY AC.AccountId ORDER BY AC.Id DESC) num,
			SMRC.Name SMRClusterName,
			PT.Name SMRPlatformName
		FROM company.Account A
		INNER JOIN company.AccountCluster AC on AC.AccountId = A.Id 
		INNER JOIN enum.Cluster SMRC on SMRC.Id = AC.ClusterId 
		INNER JOIN enum.PlatformType PT on PT.Id = SMRC.PlatformTypeId and PT.Id in ( 12,13,14)
		) foo
		where num =1
		) SMR on SMR.AccountId = A.id
LEFT OUTER JOIN sfdc.VwAccountMap AM on AM.M5dbAccountId = A.Id





