
/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View [dbo].[V_OppHist] as 
-- MW 02122019  Snapshot current State
SELECT  
       getdate() as SnapDate
      ,[DealSize]
      ,[EstimatedMRR]
      ,[LeadSource]
      ,[MRRAmount]
      ,[RecordType]
      ,[Stage]
      ,[Type]
      ,[SubType]
      ,[CountryCode]
      ,[ProductInterest]
      ,[OpportunityRegion]
      ,[OpportunitySubRegion]
      ,[OpportunityTheater]
      ,[ForecastCategory]
	  ,SUM(TotalContractValue) As TCV
	  ,SUM([EstimatedMRR]) as MRR
	  ,Count(*) as Total
	  ,SUM(TotalSeats) as TotalSeats
  FROM [dbo].[OPPORTUNITY] (nolock)
group by [DealSize]
      ,[EstimatedMRR]
      ,[LeadSource]
      ,[MRRAmount]
      ,[RecordType]
      ,[Stage]
      ,[Type]
      ,[SubType]
      ,[CountryCode] 
      ,[ProductInterest]
      ,[OpportunityRegion]
      ,[OpportunitySubRegion]
      ,[OpportunityTheater]
      ,[ForecastCategory]
