

-- =============================================
-- Author:		Payal Mukhi
-- Create date: 2015-03-05
-- Description:	Partner Commission Calculations
-- Change Log:
--  2015-10-18 Tarak porting to PC
--  2015-10-18 Tarak Removed incorrect reference to HistoricalAccountRateTable, Add clearing of fields
--  2015-10-19 commented out code section updating crediting partners from raw data partner name
--  2015-10-19 corrected incorrect join for updating comm rate of servicechange
--  2015-10-19 corrected usage pattern
--  2016-07-07 Added PaymentPlan from AccountRateTable
--  2016-10-21 Include Usage can come from Location table as well
--  2016-11-08 Override Account Rates by Product-Specific Commission Rates when present
--  2016-11-17 revised using ProductId from data without external join
--  2017-08-14 Align with revamped Billing table with Local currency and USD, and Region, AccountID, LocationID
-- =============================================
CREATE PROCEDURE [PCSandbox].[PartnerCommissionCalculations]
	-- Add the parameters for the stored procedure here
	--@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	---------Clear Fields --------------
	update rd
	set IsCommisssionable = 0,
		[CommissionableBillingsAmount] = 0,
		[CommissionableBillingsAmount LC] = 0,
		[CreditingPartner] = null,
		[PaymentPlan] = null,
		[SubAgent] = null, 
		[SubAgentId] = null,
		[RepName] = null,
		[CreditingPartnerId] = 0,
		[AccountChange]=0,
		[LocationChange]=0,
		[ServiceChange]=0,
		[CommRate]=0,
		[PartnerCommissionAmount]=0,
		[PartnerCommissionAmount LC]=0
	from PCSandbox.BaseBillingWithPC rd

	---------Commissionable Amount------
	update PCSandbox.[BaseBillingWithPC] 
	set IsCommisssionable = 1,
	[CommissionableBillingsAmount LC] = [charge LC],
	[CommissionableBillingsAmount] = [charge]
	from PCSandbox.[BaseBillingWithPC] rd
	where rd.[chargetype] in ('Monthly Fee','Credit')
	and 
	[Description] not in 
	   (select distinct [ChargeDescription]	from PCSandbox.[CreditExclusionTable])
	   
    update rd
    set 
	IsCommisssionable = 1,
	[CommissionableBillingsAmount LC] = [charge LC],
	[CommissionableBillingsAmount] = [charge]
	from PCSandbox.[BaseBillingWithPC] rd
	left join (select distinct Region, AccountID from PCSandbox.AccountRateTable where [Include Usage?] = 'Yes') AR 
		on rd.Region = AR.Region and rd.AccountID = AR.AccountID
	left join (select distinct Region, LocationID from PCSandbox.PartnerReplacementLocation where [Include Usage?] = 'Yes') LR
		on rd.Region = LR.Region and rd.AccountID = LR.LocationID
	where rd.[chargetype] like '%Usage%'
	and 
	[Description] in 
	   (select distinct [ChargeDescription]	from PCSandbox.[UsageInclusionTable])
	and (
	  AR.AccountID is not null 
	  OR -- 2016-10-21 Include Usage can also come from location
	  LR.LocationID is not null 
	  )  

	update PCSandbox.[BaseBillingWithPC]
    set 
	IsCommisssionable = 0
	where IsCommisssionable  is null

	--------Crediting Partner Calculation------
	--1. Track account change
	 update PCSandbox.[BaseBillingWithPC]
      set
		[BaseBillingWithPC].[CreditingPartner] = hac.[Crediting Partner],
		[BaseBillingWithPC].[CreditingPartnerId]= hac.[Crediting Partner Id],
		[BaseBillingWithPC].[SubAgent] = hac.[SubAgent],
		[BaseBillingWithPC].SubAgentId = hac.[SubAgentId],
		[BaseBillingWithPC].RepName = hac.[RepName],
		[BaseBillingWithPC].[AccountChange] = 1
		from PCSandbox.AccountRateTable hac
		 inner join PCSandbox.[BaseBillingWithPC] rd
		 on rd.[AccountID] = hac.[AccountID] and rd.Region = hac.Region
		 where  hac.[Crediting Partner] is not null

	--2. Track Location change
	update PCSandbox.[BaseBillingWithPC]
	 set
	 [BaseBillingWithPC].[CreditingPartner] = prl.[Crediting Partner],
	 [BaseBillingWithPC].[CreditingPartnerId]= prl.[Crediting Partner ID],
		[BaseBillingWithPC].[SubAgent] = prl.[SubAgent],
		[BaseBillingWithPC].SubAgentId = prl.[SubAgentId],
		[BaseBillingWithPC].RepName = prl.[RepName],
	 [BaseBillingWithPC].[LocationChange] = 1
	 from PCSandbox.[PartnerReplacementLocation] prl
	 inner join PCSandbox.[BaseBillingWithPC] rd
	 on rd.LocationID = prl.LocationID and rd.Region = prl.Region
	 where  prl.[Crediting Partner] is not null
	 and prl.[Crediting Partner] <> 'Exclude'
	 
	 update PCSandbox.[BaseBillingWithPC] 
	 set [CommRate] = prl.[Location Adjusted Commission Rate]
	 from PCSandbox.[PartnerReplacementLocation] prl
		 inner join PCSandbox.[BaseBillingWithPC] rd
		  on rd.LocationID = prl.LocationID and rd.Region = prl.Region
	 where
	 rd.[LocationChange]= 1

	 
	 --3. Track Service Change
	 update PCSandbox.[BaseBillingWithPC]
	  set
		[CreditingPartner] = prs.[Crediting Partner],
		[CreditingPartnerId]= prs.[Crediting Partner ID],
		[SubAgent] = prs.[SubAgent],
		[BaseBillingWithPC].SubAgentId = prs.[SubAgentId],
		[BaseBillingWithPC].RepName = prs.[RepName],
		 [ServiceChange] = 1
		 from PCSandbox.[PartnerReplacementServiceID] prs
		 inner join PCSandbox.[BaseBillingWithPC] rd
		 on rd.[serviceID] = prs.[Service ID] and rd.Region = prs.Region
		 --on rd.AccountID = prs.AccountID
		 where  prs.[Crediting Partner] is not null

     /* Don't take it from original raw data
		update PCSandbox.[BaseBillingWithPC]
	   set [BaseBillingWithPC].[CreditingPartner] = rd.[Partnername]
		from PCSandbox.[BaseBillingWithPC] rd
		where
			 (rd.[ServiceChange] <> 1 or rd.[ServiceChange] is NULL)
		 and (rd.[LocationChange] <> 1 or rd.[LocationChange] is NULL)
		 and ( rd.[AccountChange] <> 1 or rd.[AccountChange] is null)
	*/

		update PCSandbox.[BaseBillingWithPC]
		set [CommRate] = prs.[Service Commission Rate]
		 from PCSandbox.[PartnerReplacementServiceID] prs
		 inner join PCSandbox.[BaseBillingWithPC] rd
		 on rd.[serviceID] = prs.[Service ID] and  rd.Region = prs.Region
		 where
		 rd.[ServiceChange] = 1

	
		----Commission Rates----

		update PCSandbox.[BaseBillingWithPC]
		 set [CommRate] = hac.[Account CommRate]
			,[PaymentPlan] = hac.[PaymentPlanOfRecord]
		 from PCSandbox.AccountRateTable hac
		 inner join PCSandbox.[BaseBillingWithPC] rd
		 on rd.AccountID = hac.AccountID  and rd.Region = hac.Region
			--and hac.PCPlanName is null -- default plan rates  (Always apply default plan rates)
		 where
		 (rd.[ServiceChange] <> 1 or rd.[ServiceChange] is NULL)
		 and (rd.[LocationChange] <> 1 or rd.[LocationChange] is NULL)
		 and (rd.AccountChange = 1)

		 -- Update with Product Specific Plan rates

		 update RDC	
			set [CommRate] = APR.ProdCommRate  -- Override default rate with Product Specific rate
		 from PCSandbox.[BaseBillingWithPC] RDC
		 --inner join oss.VwServiceProduct_Ranked_EX SP on SP.ServiceId = RDC.ServiceId and SP.RankNum = 1
		 inner join PCSandbox.VwAccountProdRate APR 
			on APR.AccountID = RDC.AccountID and APR.ProductId = RDC.ProductId and APR.Region = RDC.Region
		 where RDC.ProductId is not null

		 ---------- For ALL, calcualte

		 update PCSandbox.[BaseBillingWithPC]
		 set [PartnerCommissionAmount] = [CommRate] * [CommissionableBillingsAmount],
		 	[PartnerCommissionAmount LC] = [CommRate] * [CommissionableBillingsAmount LC]
		 ;
 		 
END


