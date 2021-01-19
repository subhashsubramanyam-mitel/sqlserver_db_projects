-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-25
-- Description:	Sync Account Attr data
-- =============================================
CREATE PROCEDURE [company].[UspSyncAccountAttr] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing account attr data';

	MERGE Company.AccountAttr as target
	USING (
		SELECT
			A.Id as AccountId,
			A.AccountStatus,
			dbo.UfnFirstOfMonth(INV.DateFirstInvoiced) as DateFirstInvoiced, 
			A.DateFirstServiceLive,
			--A.ActiveMRR, -- incorrect computation on m5db side. To Recompute on OLAP side.
			A.LocationsWithSeatsNumber as NumLocationsWithSeats, 
			A.ProfilesNumber as NumProfiles,
			A.LocationsNumber as NumLocationsTotal,
			A.LocationsActiveNumber as NumLocationsActive,
			A.LocationsPendingNumber as NumLocationsPending,
			A.AccountTeam,
			A.IsBillable,
			A.IsUsfChargeable,
			CH.Name CreditHoldType,
			dbo.UfnFirstOfMonth(INV.DateLASTInvoiced) as DateLastInvoiced,
			A.AccountManagerId
		,AA.[InternalAccountTypeId]
      ,AA.[PartnerTypeId] 
      ,AA.[AccountGuid] 
      ,AA.[IsQualifiedForAob] 
      ,AA.[IsMCSSEnabled]
      ,AA.[IsCompliant]
		FROM 
			M5DB.Billing.Dbo.VwAccountDetails2 A with(nolock)
		inner join M5DB.M5DB.dbo.Account AA with (nolock)
			on AA.Id = A.Id
		left join M5DB.M5DB.dbo.billing_CreditHoldType CH 
			on CH.Id = AA.CreditHoldTypeId
		Left Join (
			select I.AccountId, MIN(DateGenerated) DateFirstInvoiced, MAX(DateGenerated) DateLastInvoiced
			from invoice.Invoice I
			group by I.AccountId
			) INV on INV.AccountId = A.Id
		--WHERE
			--A.DateModified >= @lastSync 
	) AS source
	ON target.AccountId = source.AccountId
	WHEN MATCHED THEN	
		UPDATE SET 
		target.AccountStatus = source.AccountStatus, 
		target.DateFirstInvoiced = source.DateFirstInvoiced, 
		target.DateFirstServiceLive = source.DateFirstServiceLive, 
		--target.ActiveMRR = source.ActiveMRR, 
		target.NumLocationsWithSeats = source.NumLocationsWithSeats, 
		-- target.NumProfiles = source.NumProfiles, -- NumProfiles are now computed based on Actual Billing
		target.NumLocationsTotal = source.NumLocationsTotal, 
		target.NumLocationsActive=source.NumLocationsActive,
		target.NumLocationsPending=source.NumLocationsPending,
		target.AccountTeam = source.AccountTeam,
		target.IsBillable = source.IsBillable,
		target.IsUsfChargeable = source.IsUsfChargeable,
		target.CreditHoldType = source.CreditHoldType,
		target.DateLastInvoiced = source.DateLastInvoiced,
		target.AccountManagerId = source.AccountManagerId
	  ,target.[InternalAccountTypeId] = source.[InternalAccountTypeId]
      ,target.[PartnerTypeId]  = source.[PartnerTypeId]
      ,target.[AccountGuid]  = source.[AccountGuid]
      ,target.[IsQualifiedForAob]  = source.[IsQualifiedForAob]
      ,target.[IsMCSSEnabled] = source.[IsMCSSEnabled]
      ,target.[IsCompliant] = source.[IsCompliant]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( AccountId,AccountStatus,DateFirstInvoiced,DateFirstServiceLive,NumLocationsWithSeats,NumProfiles,
				 NumLocationsTotal,NumLocationsActive,NumLocationsPending,AccountTeam,IsBillable,IsUsfChargeable,CreditHoldType,
				 DateLastInvoiced, AccountManagerId
				 	  ,[InternalAccountTypeId]
      ,[PartnerTypeId] 
      ,[AccountGuid] 
      ,[IsQualifiedForAob] 
      ,[IsMCSSEnabled]
      ,[IsCompliant]) 
		VALUES ( AccountId,AccountStatus,DateFirstInvoiced,DateFirstServiceLive,NumLocationsWithSeats,NumProfiles,
				 NumLocationsTotal,NumLocationsActive,NumLocationsPending,AccountTeam,IsBillable,IsUsfChargeable,CreditHoldType,
				 DateLastInvoiced, AccountManagerId
				 	  ,[InternalAccountTypeId]
      ,[PartnerTypeId] 
      ,[AccountGuid] 
      ,[IsQualifiedForAob] 
      ,[IsMCSSEnabled]
      ,[IsCompliant]) 
	OUTPUT 'DimAccountAttr', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing account attr data';
	
	-- cleanup bad data
	 update company.AccountAttr set DateFirstServiceLive = DateFirstInvoiced
		 where DateFirstServiceLive < '2000-01-01';

END
