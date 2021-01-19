﻿/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View gainsight.VwAccountInfo as
-- MW 10152018 view for CostGaurd Account Info
SELECT 

			[Ac ActiveMRR]
			,[Ac Id]
			,[Ac Industry]
			,[Ac Name]
			,[Ac Number]
			,[Ac Status]
			,[Ac SubIndustry]
			,[Ac Team]
			,[AccountCategoryId]
			,[AccountSubCategoryId]
			,[CCClusterName]
			,[CCPlatformName]
			,[Cluster]
			,[Company Type]
			,[CompanySalesChannelId]
			,[CreditRisk]
			,[DateFirstInvoiced]
			,[DateFirstScored]
			,[DateFirstServiceLive]
			,[DateLastInvoiced]
			,[DateLastScored]
			,[FirstNPS]
			,[FirstScore]
			,[IsActive]
			,[IsBillable]
			,[IsHybrid]
			,[LastNPS]
			,[LastScore]
			,[LichenAccountId]
			--,[Ac Id] as M5DBID -- ?
			,[MonthsInService]
			,[NumCisco]
			,[NumLocationsActive]
			,[NumLocationsPending]
			,[NumLocationsTotal]
			,[NumLocationsWithSeats]
			,[NumPendingProfiles]
			,[NumProfiles]
			,[NumProfilesLastMonth]
			,[OutDialDigit]
			,[PartnerId]
			,[Platform]
			,[PrimaryClusterId]
			,[PrimaryHandset]
			,[SMRPlatformName]
  FROM [company].[VwAccount]
