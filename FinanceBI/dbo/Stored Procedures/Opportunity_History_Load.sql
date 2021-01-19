


-- =============================================
-- Author:		<Payal Mukhi>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Opportunity_History_Load]
AS
BEGIN

	SET NOCOUNT ON;

--track updates to existing opportunities

declare @Changed_Record table
(
[Created] [datetime],
	[OpportunityId] [varchar](50) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Amount] [numeric](18, 2) NULL,
	[CloseDate] [date] NULL,
	[Stage] [varchar](500) NULL,
	[DateLastModified] [datetime] NULL,
	[SfdcDateLastModified] [datetime] NULL,
	[LastModifiedById] [varchar](50) NULL,
	[Current_Flag] [varchar](10) NULL
)

insert into @Changed_Record
(
[Created]  ,
	[OpportunityId],
	[Name]  ,
	[Amount] ,
	[CloseDate],
	[Stage] ,
	[DateLastModified] ,
	[SfdcDateLastModified] ,
	[LastModifiedById] ,
	[Current_Flag] 
)

select
	p.DateCreated,
	p.[OpportunityId],
	p.[Opportunity Name],
	p.[Amount],
	p.[Date Closed],
	p.[Stage],
	p.DateLastModified,
	p.[SfdcDateLastModified],
	p.[LastModifiedById],
	'true'
	from
	[sfdc].[SFDC_OPP_History] h
	join [sfdc].[VwOpportunity] p
	on p.[OpportunityId] COLLATE DATABASE_DEFAULT = h.[OpportunityId] COLLATE DATABASE_DEFAULT
	where
	DATEPART(QUARTER, p.[Date Closed] ) = DATEPART(QUARTER, getdate()) 
	and DATEPART (year, p.[Date Closed] ) = DATEPART(year, getdate()) 
	and
	(
	 p.[Opportunity Name] <> h.[Name]
	 or p.[Amount] <> h.[Amount]
	 or p.[Date Closed] <> h.[CloseDate]
	 )


	 update  h
	 set [Current_Flag]  = 'false'
	 from [sfdc].[SFDC_OPP_History] h
	join @Changed_Record c
	on h.[OpportunityId] = c.[OpportunityId]

 INSERT INTO [sfdc].[SFDC_OPP_History]
           ([Created]
           ,[OpportunityId]
           ,[Name]
           ,[Amount]
           ,[CloseDate]
           ,[Stage]
           ,[DateLastModified]
           ,[SfdcDateLastModified]
           ,[LastModifiedById]
		   ,[Current_Flag]
		   )
select [Created]  ,
	[OpportunityId],
	[Name]  ,
	[Amount] ,
	[CloseDate],
	[Stage] ,
	[DateLastModified] ,
	[SfdcDateLastModified] ,
	[LastModifiedById] ,
	[Current_Flag] 
	from @Changed_Record


--Inserting new opportunities

	INSERT INTO [sfdc].[SFDC_OPP_History]
           ([Created]
           ,[OpportunityId]
           ,[Name]
           ,[Amount]
           ,[CloseDate]
           ,[Stage]
           ,[DateLastModified]
           ,[SfdcDateLastModified]
           ,[LastModifiedById]
		   ,[Current_Flag]
		   )
	select
	p.DateCreated,
	p.[OpportunityId],
	p.[Opportunity Name],
	p.[Amount],
	p.[Date Closed],
	p.[Stage],
	p.DateLastModified,
	p.[SfdcDateLastModified],
	p.[LastModifiedById],
	'true'
	from
	[sfdc].[SFDC_OPP_History] h
	right outer join [sfdc].[VwOpportunity] p
	on p.[OpportunityId] COLLATE DATABASE_DEFAULT = h.[OpportunityId] COLLATE DATABASE_DEFAULT
	where
	DATEPART(QUARTER, [Date Closed] ) = DATEPART(QUARTER, getdate()) 
	and DATEPART (year, [Date Closed] ) = DATEPART(year, getdate()) 
	and
	h.[OpportunityId] is null



end
