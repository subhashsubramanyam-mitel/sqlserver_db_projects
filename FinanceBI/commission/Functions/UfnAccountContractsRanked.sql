

-- =============================================
-- Author:		Tarak Goradia
-- Create date: Feb 9, 2017
-- Description:	Ranked Contracts applicatble for a specific Invoice Month
-- =============================================
CREATE FUNCTION [commission].[UfnAccountContractsRanked] 
(	
	@InvMonth  Date -- Invoice Month
)
RETURNS TABLE 
AS
RETURN 
(
	select AR.AccountId PortalId, SC.*,
		ROW_NUMBER() over (partition by AR.AccountId order by SfdcModifiedDate desc, SfdcCreateDate desc) RankNum
	from commission.History_AccountRate AR
	inner join sfdc.SkyContract SC on SC.M5dbAccountId = convert(float, AR.AccountId) 
										  and (@InvMonth  between SC.ContractStartDate and SC.ContractEndDate)   
	where AR.PCMonth = DATEADD(month, 1, @InvMonth)
)

