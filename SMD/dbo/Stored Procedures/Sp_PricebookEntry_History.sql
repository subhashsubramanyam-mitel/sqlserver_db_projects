



-- =============================================
-- Author:		<Payal Mukhi>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sp_PricebookEntry_History]
AS
BEGIN

	SET NOCOUNT ON;

	declare @Changed_Record table
(
[Hist_id] [int],
[Id] [varchar](50) NOT NULL,
[CreatedDate] [datetime] NULL,
[CurrencyIsoCode] [varchar](50) NULL,
	[EndDate] [datetime] NULL,
	[IsActive] [varchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[NAME] [varchar](max) NULL,
	[PricebookId] [varchar](50) NULL,
	[ProductId] [varchar](50) NULL,
	[SkuNumber] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[UnitPrice] [decimal](16, 2) NULL,
	[Current_Flag] [varchar](5) NULL

)
insert into @Changed_Record
(
[Hist_id] ,
[Id],
[CreatedDate],
[CurrencyIsoCode],
	[EndDate] ,
	[IsActive] ,
	[LastModifiedDate] ,
	[NAME] ,
	[PricebookId],
	[ProductId] ,
	[SkuNumber] ,
	[StartDate] ,
	[UnitPrice] ,
	[Current_Flag] 

)
SELECT 
h.[Hist_id],
      p.[Id]
      ,p.[CreatedDate]
      ,p.[CurrencyIsoCode]
      ,p.[EndDate]
      ,p.[IsActive]
      ,p.[LastModifiedDate]
      ,p.[NAME]
      ,p.[PricebookId]
      ,p.[ProductId]
      ,p.[SkuNumber]
      ,p.[StartDate]
      ,p.[UnitPrice]
	  ,h.Current_Flag
  FROM [dbo].[PricebookEntry_History] h
     join [SVLCORPSILO1].[MEGASILO].[dbo].[PricebookEntry] p
	on p.[Id] COLLATE DATABASE_DEFAULT = h.[id] COLLATE DATABASE_DEFAULT
	and p.[CurrencyIsoCode] COLLATE DATABASE_DEFAULT = h.CurrencyIsoCode COLLATE DATABASE_DEFAULT
	 where
  (
 (p.[CurrencyIsoCode] = 'GBP' and  p.[PricebookId] = '01s1A0000009BKWQA2')
or 
(p.[PricebookId] = '01sC00000003SrqIAE' and p.[CurrencyIsoCode] <>'GBP' )
 )
 and 
 (p.name COLLATE DATABASE_DEFAULT <> h.name COLLATE DATABASE_DEFAULT
 or 
p.[UnitPrice]  <> h.UnitPrice 
or
p.[StartDate] <> h.StartDate
)
if (select [Hist_id] from @Changed_Record) > 0
begin
update h
set
 h.[Current_Flag] = 'false'
,h.EndDate = isnull(h.EndDate,getdate())
--,c.SkuNumber
--,c.UnitPrice
--,h.UnitPrice
 FROM [dbo].[PricebookEntry_History] h
 join  @Changed_Record c
 on h.[Hist_id] = c.[Hist_id]

 INSERT INTO [dbo].[PricebookEntry_History]
           ([Id]
           ,[CreatedDate]
           ,[CurrencyIsoCode]
           ,[EndDate]
           ,[IsActive]
           ,[LastModifiedDate]
           ,[NAME]
           ,[PricebookId]
           ,[ProductId]
           ,[SkuNumber]
           ,[StartDate]
           ,[UnitPrice]
		   ,[Current_Flag]
        )

select
		[Id],
[CreatedDate],
[CurrencyIsoCode],
	[EndDate] ,
	[IsActive] ,
	[LastModifiedDate] ,
	[NAME] ,
	[PricebookId],
	[ProductId] ,
	[SkuNumber] ,
	[StartDate] ,
	[UnitPrice] ,
    'true'

from @Changed_Record
 
 end

 end

