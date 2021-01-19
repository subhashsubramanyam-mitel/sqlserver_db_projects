Create procedure CleanLiveAgentTable as
--Delete duplicated records (updates) called from ECCReports orch MW 03162018
delete from CASE_LiveChat where Id in 
(
select Id from  
(
SELECT  
Id, ChatTxId, row_number() over (partition by ChatTxId order By Created desc) rn
FROM [dbo].[CASE_LiveChat]
) s
where rn > 1
)
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CleanLiveAgentTable] TO [ITApps]
    AS [dbo];

