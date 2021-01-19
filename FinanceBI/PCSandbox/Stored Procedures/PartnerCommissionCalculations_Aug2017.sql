


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
-- =============================================
CREATE PROCEDURE [PCSandbox].[PartnerCommissionCalculations_Aug2017]
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
		[CreditingPartner] = null,
		[SubAgent] = null, 
		[SubAgentId] = null,
		[RepName] = null,
		[CreditingPartnerId] = 0,
		[AccountChange]=0,
		[LocationChange]=0,
		[ServiceChange]=0,
		[CommRate]=0,
		[PartnerCommissionAmount]=0
	from PCSandbox.[RawDataWCalcs] rd

	---------Commissionable Amount------
	update PCSandbox.[RawDataWCalcs] 
	set IsCommisssionable = 1,
	[CommissionableBillingsAmount] = [charge]
	from PCSandbox.[RawDataWCalcs] rd
	where rd.[chargetype] in ('Monthly Fee','Credit')
	and 
	[Description] not in 
	   (select distinct [ChargeDescription]	from PCSandbox.[CreditExclusionTable])
	   
    update PCSandbox.[RawDataWCalcs]
    set 
	IsCommisssionable = 1,
	[CommissionableBillingsAmount] = [charge]
	from PCSandbox.[RawDataWCalcs] rd
	where rd.[chargetype] like '%Usage%'
	and 
	[Description] in 
	   (select distinct [ChargeDescription]	from PCSandbox.[UsageInclusionTable])
	and (
	  [LichenAccountId]	in
	  (select distinct [LichenAccountId]from PCSandbox.AccountRateTable where [Include Usage?] = 'Yes')
	  OR -- 2016-10-21 Include Usage can also come from location
	  [lichenlocationid] in
	  (select distinct [lichenlocationid] from PCSandbox.PartnerReplacementLocation where [Include Usage?] = 'Yes')
	  )  

	update PCSandbox.[RawDataWCalcs]
    set 
	IsCommisssionable = 0
	where IsCommisssionable  is null

	--------Crediting Partner Calculation------
	--1. Track account change
	 update PCSandbox.[RawDataWCalcs]
      set
		[RawDataWCalcs].[CreditingPartner] = hac.[Crediting Partner],
		[RawDataWCalcs].[CreditingPartnerId]= hac.[Crediting Partner Id],
		[RawDataWCalcs].[SubAgent] = hac.[SubAgent],
		[RawDataWCalcs].SubAgentId = hac.[SubAgentId],
		[RawDataWCalcs].RepName = hac.[RepName],
		[RawDataWCalcs].[AccountChange] = 1
		from PCSandbox.AccountRateTable hac
		 inner join PCSandbox.[RawDataWCalcs] rd
		 on rd.[LichenAccountId] = hac.[LichenAccountID]
		 where  hac.[Crediting Partner] is not null

	--2. Track Location change
	update PCSandbox.[RawDataWCalcs]
	 set
	 [RawDataWCalcs].[CreditingPartner] = prl.[Crediting Partner],
	 [RawDataWCalcs].[CreditingPartnerId]= prl.[Crediting Partner ID],
		[RawDataWCalcs].[SubAgent] = prl.[SubAgent],
		[RawDataWCalcs].SubAgentId = prl.[SubAgentId],
		[RawDataWCalcs].RepName = prl.[RepName],
	 [RawDataWCalcs].[LocationChange] = 1
	 from PCSandbox.[PartnerReplacementLocation] prl
	 inner join PCSandbox.[RawDataWCalcs] rd
	 on rd.[lichenlocationid] = prl.[lichenlocationid]
	 where  prl.[Crediting Partner] is not null
	 and prl.[Crediting Partner] <> 'Exclude'
	 
	 update PCSandbox.[RawDataWCalcs] 
	 set [CommRate] = prl.[Location Adjusted Commission Rate]
	 from PCSandbox.[PartnerReplacementLocation] prl
		 inner join PCSandbox.[RawDataWCalcs] rd
		  on rd.[lichenlocationid] = prl.[lichenlocationid]
	 where
	 rd.[LocationChange]= 1

	 
	 --3. Track Service Change
	 update PCSandbox.[RawDataWCalcs]
	  set
		[CreditingPartner] = prs.[Crediting Partner],
		[CreditingPartnerId]= prs.[Crediting Partner ID],
		[SubAgent] = prs.[SubAgent],
		[RawDataWCalcs].SubAgentId = prs.[SubAgentId],
		[RawDataWCalcs].RepName = prs.[RepName],
		 [ServiceChange] = 1
		 from PCSandbox.[PartnerReplacementServiceID] prs
		 inner join PCSandbox.[RawDataWCalcs] rd
		 on rd.[serviceID] = prs.[Service ID]
		 --on rd.[LichenAccountId] = prs.[LichenAccountID]
		 where  prs.[Crediting Partner] is not null

     /* Don't take it from original raw data
		update PCSandbox.[RawDataWCalcs]
	   set [RawDataWCalcs].[CreditingPartner] = rd.[Partnername]
		from PCSandbox.[RawDataWCalcs] rd
		where
			 (rd.[ServiceChange] <> 1 or rd.[ServiceChange] is NULL)
		 and (rd.[LocationChange] <> 1 or rd.[LocationChange] is NULL)
		 and ( rd.[AccountChange] <> 1 or rd.[AccountChange] is null)
	*/

		update PCSandbox.[RawDataWCalcs]
		set [CommRate] = prs.[Service Commission Rate]
		 from PCSandbox.[PartnerReplacementServiceID] prs
		 inner join PCSandbox.[RawDataWCalcs] rd
		 on rd.[serviceID] = prs.[Service ID]
		 where
		 rd.[ServiceChange] = 1

	
		----Commission Rates----

		update PCSandbox.[RawDataWCalcs]
		 set [CommRate] = hac.[Account CommRate]
			,[PaymentPlan] = hac.[PaymentPlanOfRecord]
		 from PCSandbox.AccountRateTable hac
		 inner join PCSandbox.[RawDataWCalcs] rd
		 on rd.[LichenAccountId] = hac.[LichenAccountID] 
			--and hac.PCPlanName is null -- default plan rates  (Always apply default plan rates)
		 where
		 (rd.[ServiceChange] <> 1 or rd.[ServiceChange] is NULL)
		 and (rd.[LocationChange] <> 1 or rd.[LocationChange] is NULL)
		 and (rd.AccountChange = 1)

		 -- Update with Product Specific Plan rates

		 update RDC	
			set [CommRate] = APR.ProdCommRate  -- Override default rate with Product Specific rate
		 from PCSandbox.[RawDataWCalcs] RDC
		 --inner join oss.VwServiceProduct_Ranked_EX SP on SP.ServiceId = RDC.ServiceId and SP.RankNum = 1
		 inner join PCSandbox.VwAccountProdRate APR on APR.LichenAccountId = RDC.LichenAccountId and APR.ProductId = RDC.ProductId
		 where RDC.ProductId is not null

		 ---------- For ALL, calcualte

		 update PCSandbox.[RawDataWCalcs]
		 set [PartnerCommissionAmount] = [CommRate] * [CommissionableBillingsAmount]
		 
 		 
END



