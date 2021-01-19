
Create Function [dbo].[UfnFindStringInJobs] (@string varchar(100))
returns @tbl  Table([JobName] varchar(500), StepNum int, StepName varchar(500), ExecutableCommand varchar(5000))
AS 
BEGIN
insert into @tbl(JobName, StepNum, StepName, ExecutableCommand)
SELECT
     [sJOB].[name] AS [JobName]
    , [sJSTP].[step_id] AS [StepNo]
    , [sJSTP].[step_name] AS [StepName]
    , [sJSTP].[command] AS [ExecutableCommand]

FROM
    [msdb].[dbo].[sysjobsteps] AS [sJSTP]
    INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
        ON [sJSTP].[job_id] = [sJOB].[job_id]
    LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sOSSTP]
        ON [sJSTP].[job_id] = [sOSSTP].[job_id]
        AND [sJSTP].[on_success_step_id] = [sOSSTP].[step_id]
    LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sOFSTP]
        ON [sJSTP].[job_id] = [sOFSTP].[job_id]
        AND [sJSTP].[on_fail_step_id] = [sOFSTP].[step_id]
    LEFT JOIN [msdb].[dbo].[sysproxies] AS [sPROX]
        ON [sJSTP].[proxy_id] = [sPROX].[proxy_id]
WHERE [sJSTP].[command] LIKE '%'+@string+'%'
ORDER BY [JobName], [StepNo]

return
END

