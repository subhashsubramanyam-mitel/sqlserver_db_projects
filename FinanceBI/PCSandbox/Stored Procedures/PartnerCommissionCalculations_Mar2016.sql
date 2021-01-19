

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
-- =============================================
Create PROCEDURE [PCSandbox].[PartnerCommissionCalculations_Mar2016]
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
		[CreditingPartnerLichenPartnerId] = 0,
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
	and 
	  [LichenAccountId]	in
	  (select distinct [LichenAccountId]from PCSandbox.AccountRateTable where [Include Usage?] = 'Yes')

	update PCSandbox.[RawDataWCalcs]
    set 
	IsCommisssionable = 0
	where IsCommisssionable  is null

	--------Crediting Partner Calculation------
	--1. Track account change
	 update PCSandbox.[RawDataWCalcs]
      set
		[RawDataWCalcs].[CreditingPartner] = hac.[Crediting Partner],
		[RawDataWCalcs].[CreditingPartnerLichenPartnerId]= hac.[Crediting Partner Id],
		[RawDataWCalcs].[AccountChange] = 1
		from PCSandbox.AccountRateTable hac
		 inner join PCSandbox.[RawDataWCalcs] rd
		 on rd.[LichenAccountId] = hac.[LichenAccountID]
		 where  hac.[Crediting Partner] is not null

	--2. Track Location change
	update PCSandbox.[RawDataWCalcs]
	 set
	 [RawDataWCalcs].[CreditingPartner] = prl.[Crediting Partner],
	 [RawDataWCalcs].[CreditingPartnerLichenPartnerId]= prl.[Crediting Partner ID],
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
		[CreditingPartnerLichenPartnerId]= prs.[Crediting Partner ID],
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
		 from PCSandbox.AccountRateTable hac
		 inner join PCSandbox.[RawDataWCalcs] rd
		 on rd.[LichenAccountId] = hac.[LichenAccountID]
		 where
		 (rd.[ServiceChange] <> 1 or rd.[ServiceChange] is NULL)
		 and (rd.[LocationChange] <> 1 or rd.[LocationChange] is NULL)
		 and (rd.AccountChange = 1)
		 /* no longer needed
		 update PCSandbox.[RawDataWCalcs]
		 set [CommRate] = prt.[PartnerCommRate]
		 from  PCSandbox.[PartnerRateTable] prt
		 inner join PCSandbox.[RawDataWCalcs] rd
		 on rd.[CreditingPartnerLichenPartnerId] = prt.[LichenPartnerID]
		 --rd.[LichenAccountId] = hac.[LichenAccountID]
		 where 
		 (rd.[ServiceChange] <> 1 or rd.[ServiceChange] is NULL)
		 and (rd.[LocationChange] <> 1 or rd.[LocationChange] is NULL)
		 and rd.[LichenAccountId] 
		 not in
		 (
		 select  hac.[LichenAccountID]
			from commission.HistoricalAccountRateTable hac
		 ) */

		 update PCSandbox.[RawDataWCalcs]
		 set [PartnerCommissionAmount] = [CommRate] * [CommissionableBillingsAmount]
		 
 		 
END


