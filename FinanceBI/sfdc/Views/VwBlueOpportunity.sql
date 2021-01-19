
CREATE view [sfdc].[VwBlueOpportunity] as
-- MW 10312018  View to pull data into CostGuardBI
select * from [$(MiBI)].dbo.B_SFDC_OPPORTUNITY
where isnull(rtrim(DealId),'') <> '' -- limit to here since we will only link with this.

