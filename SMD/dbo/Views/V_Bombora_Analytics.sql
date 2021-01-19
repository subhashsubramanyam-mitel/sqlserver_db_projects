


CREATE VIEW [dbo].[V_Bombora_Analytics]
AS

select distinct
bs.[Date],
bs.[Company]
,bs.[Company Size]
,bs.[Industry]
,bs.[Score]
,bs.[Topic Count]
,isnull(bs.[SalesRep], '') as [SalesRep],
--bs.*,
 bc.[Topic Name],isNULL([Topic_Competitor_name], '') as [Topic_Competitor_name]
from [dbo].[Bombora_ Surge_ Report] bs
inner join [dbo].[Bombora_Comprehensive_ReportV2]  bc
on bs.[Company] = bc.[Company]
and bs.date = bc.date
--where bs.company = 'providence.org'




