
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-04-16
-- Description:	Prepare monthly usage summary for Profile Service Billing Audit
-- =============================================
CREATE PROCEDURE [audit].[UspPrepareMonthlyUsageForPSBAudit]
AS
BEGIN

IF OBJECT_ID('audit.mVwTnMonthlyUsageSummary', 'U') IS NOT NULL 
  DROP TABLE audit.mVwTnMonthlyUsageSummary; 

select *
into audit.mVwTnMonthlyUsageSummary
from usage.VwTnMonthlySummary


END

