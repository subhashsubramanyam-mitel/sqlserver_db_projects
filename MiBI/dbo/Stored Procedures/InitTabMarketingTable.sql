

CREATE  procedure [dbo].[InitTabMarketingTable] as
-- Run from marketing datasource from Tableau server
-- MW 10052019  not needed.

select 0

--IF (select count(*) from V_TABLEAU_B_SFDC_LEADS ) > 70000
-- MW 03052019 Check Both tables since view looks at them
--IF  ((select count(*) from V_TABLEAU_B_SFDC_LEADS ) > 70000)
--and  ((select count(*) from V_TABLEAU_B_SFDC_OPPORTUNITY ) > 300000)

-- BEGIN 
--IF OBJECT_ID('TABLEAU_B_SFDC_LEADS', 'U') IS NOT NULL
--drop table TABLEAU_B_SFDC_LEADS

--select  * INTO TABLEAU_B_SFDC_LEADS  from V_TABLEAU_B_SFDC_LEADS

----For Monitor
--insert into   testTabLog (RanDate)
--select getdate() as RanDate
 
--END 
--ELSE

--RAISERROR ('SFDC Data Not Initialized', 16, 1)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[InitTabMarketingTable] TO [ITApps]
    AS [dbo];

