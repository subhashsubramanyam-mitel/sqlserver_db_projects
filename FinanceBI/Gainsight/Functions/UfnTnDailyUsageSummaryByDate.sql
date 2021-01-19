
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Feb 16, 2016
-- Description:	Daily Usage Summary for a given date 
-- Change Log: 
--     2016-02-23 Using materialized view for performance
-- =============================================
CREATE FUNCTION [Gainsight].[UfnTnDailyUsageSummaryByDate] 
(	
	@CallDate  Date -- Call Date
)
RETURNS TABLE 
AS
RETURN 
(
select -- top 10
	*
from FinanceBI.Gainsight.mVwTnDailyUsageSummary TU with(nolock)
where TU.CallDate = @CallDate
)

