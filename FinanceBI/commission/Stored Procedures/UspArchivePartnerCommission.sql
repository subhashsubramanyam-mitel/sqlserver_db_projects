
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2015-10-21
-- Description:	Archive Partner Commissions from PCSandbox to Commission schema's history tables
-- =============================================
CREATE PROCEDURE [commission].[UspArchivePartnerCommission] 
	-- Add the parameters for the stored procedure here
	@CommMonth  date = NULL
AS
BEGIN

delete from commission.History_AccountRate where PCMonth = @CommMonth;
insert into commission.History_AccountRate
select @CommMonth PCMonth, *, null, null, null
from PCSandbox.AccountRateTable

delete from commission.History_CreditExclusion where PCMonth = @CommMonth;
insert 
into commission.History_CreditExclusion
select @CommMonth PCMonth, * 
from PCSandbox.CreditExclusionTable


delete from commission.History_UsageInclusion where PCMonth = @CommMonth;
insert 
into commission.History_UsageInclusion
select @CommMonth PCMonth, * 
from PCSandbox.UsageInclusionTable

delete from commission.History_PartnerReplacementLocation where PCMonth = @CommMonth;
insert 
into commission.History_PartnerReplacementLocation
select @CommMonth PCMonth, * 
from PCSandbox.PartnerReplacementLocation

delete from commission.History_PartnerReplacementServiceId where PCMonth = @CommMonth;
insert 
into commission.History_PartnerReplacementServiceId
select @CommMonth PCMonth, * 
from PCSandbox.PartnerReplacementServiceId

delete from commission.History_PartnerCommission where PCMonth = @CommMonth;
insert 
into commission.History_PartnerCommission
select  * 
from PCSandbox.BaseBillingWithPC

delete from commission.History_Adjustment where [PCMonth] = @CommMonth;
insert 
into commission.History_Adjustment
select  * 
from PCSandbox.Adjustment

/* Deprecated
delete from commission.History_PartnerTable where PCMonth = @CommMonth;
insert 
into commission.History_PartnerTable
select @CommMonth PCMonth, * 
from PCSandbox.PartnerTable
*/

delete from commission.History_PlanProductRate where PCMonth = @CommMonth;
insert 
into commission.History_PlanProductRate
select @CommMonth PCMonth, * 
from PCSandbox.PlanProductRate;

END
