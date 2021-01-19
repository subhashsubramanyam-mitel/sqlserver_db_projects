 

CREATE view V_LiveChat_Daily as
-- Link to ECC report
-- MW 070920191
SELECT 
      convert(char(10),[RequestTime],101) as ReportDate
	  ,[OwnerName] as AgentName
	  ,count(*) as Chats
  FROM [dbo].[CASE_LiveChat]
--where [RequestTime] >getdate() -30
group by 
	convert(char(10),[RequestTime],101)
	,OwnerName 