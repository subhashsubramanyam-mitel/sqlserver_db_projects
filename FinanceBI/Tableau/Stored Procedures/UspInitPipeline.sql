

-- EXEC [Tableau].[UspInitPipeline]
CREATE PROCEDURE [Tableau].[UspInitPipeline]
AS
-- MW 05212019 Called from Tableau datasource connection 'Initial SQL'

BEGIN

	SET NOCOUNT ON;

	SELECT *
	INTO #mVwServiceProduct_EX_stage
	FROM oss.VwServiceProduct_EX
	
	IF (OBJECT_ID('Tableau.mVwServiceProduct_EX', 'U') IS NOT NULL AND (SELECT count(*) FROM #mVwServiceProduct_EX_stage ) > 1000000)
	BEGIN
		
		--select count(ServiceId), count(Distinct ServiceId) FROM oss.VwServiceProduct_EX

		DROP TABLE Tableau.mVwServiceProduct_EX

		SELECT *
		INTO Tableau.mVwServiceProduct_EX
		FROM #mVwServiceProduct_EX_stage

		CREATE NONCLUSTERED INDEX IX_mVwServiceProduct_EX ON Tableau.mVwServiceProduct_EX (ServiceId)
		WITH (
					STATISTICS_NORECOMPUTE = OFF
					,IGNORE_DUP_KEY = OFF
					,ALLOW_ROW_LOCKS = ON
					,ALLOW_PAGE_LOCKS = ON
				) ON [PRIMARY]



CREATE NONCLUSTERED INDEX IX_mVwServiceProduct_EX_orderid ON Tableau.mVwServiceProduct_EX
	(
	OrderId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 
CREATE NONCLUSTERED INDEX IX_mVwServiceProduct_EX_Statusid ON Tableau.mVwServiceProduct_EX
	(
	ServiceStatusId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]







		INSERT INTO Tableau.Logging (
			Created
			,Msg
			) 
			SELECT getdate()
			,'Loaded Table Tableau.mVwServiceProduct_EX';
			
	END

	DROP TABLE #mVwServiceProduct_EX_stage;


	/*
		-- MW 05212019 Called from Tableau datasource connection 'Initial SQL'
		--select * into #mVwServiceProduct_EX_stage from  oss.VwServiceProduct_EX
	
		IF (OBJECT_ID('tableau.mVwServiceProduct_EX', 'U') IS NOT NULL AND ((SELECT COUNT_BIG(*)  FROM oss.VwServiceProduct_EX_Lite) > 1000000))
		BEGIN
			
			TRUNCATE TABLE [Tableau].[mVwServiceProduct_EX];
		
			INSERT INTO [Tableau].[mVwServiceProduct_EX]
			   ([ServiceId]
			   ,[ProductId]
			   ,[LichenServiceId]
			   ,[LichenPlanId]
			   ,[ServiceClassId]
			   ,[ServiceStatusId]
			   ,[AccountId]
			   ,[InvoiceServiceGroupId]
			   ,[LocationId]
			   ,[ServiceBundleId]
			   ,[Name]
			   ,[IsAttachedToTN]
			   ,[TN]
			   ,[InvoiceLabel]
			   ,[OrderId]
			   ,[OrderTypeId]
			   ,[WasInInitialOrder]
			   ,[OrderProjectManagerId]
			   ,[OrderCreatedByPersonId]
			   ,[OrderedById]
			   ,[OrderSalesPersonId]
			   ,[MonthlyCharge]
			   ,[OneTimeCharge]
			   ,[DateSvcCreated]
			   ,[DateSvcModified]
			   ,[DateSvcLiveScheduled]
			   ,[DateSvcLiveActual]
			   ,[DateSvcCloseOrdered]
			   ,[MonthSvcCloseOrdered]
			   ,[ClosedByPersonId]
			   ,[DateSvcClosed]
			   ,[DateBillingValidFrom]
			   ,[DateBillingValidTo]
			   ,[IsBilledFirstTime]
			   ,[MonthSetupInvoiced]
			   ,[MonthLastInvoiced]
			   ,[MonthMRRFirstInvoiced]
			   ,[MonthMRRLastInvoiced]
			   ,[DateMRRInvoicedTo]
			   ,[MonthCreditIssued]
			   ,[DateCreditedFrom]
			   ,[DateCreditedTo]
			   ,[CreatedByPersonId]
			   ,[ModifiedByPersonId]
			   ,[BillingStage]
			   ,[DataIssueId]
			   ,[Loc Connecticitytype]
			   ,[Loc InvoiceGroupId]
			   ,[Ac FirstNps]
			   ,[Ac LastNps]
			   ,[Ac DateFirstServiceLive]
			   ,[Ac DateFirstInvoiced]
			   ,[Ac PartnerId]
			   ,[NumLifeDays]
			   ,[LifeDaysSegmentId]
			   ,[IsMRRZero]
			   ,[IsNRCZero]
			   ,[CircuitStatusId]
			   ,[LifeDaysNewSegmentId]
			   ,[InFirstContract]
			   ,[SvcCluster]
			   ,[SvcPlatform]
			   ,[DateSvcVoided]
			   ,[DateSvcSetToActive]
			   ,[CurrencyCode]
			   ,[CurrencyId]
			   ,[MonthlyCharge_LC]
			   ,[OneTimeCharge_LC]
			   ,[DateLocLiveForecast]
			   ,[MasterOrderTypeId])
		SELECT  [ServiceId]
			   ,[ProductId]
			   ,[LichenServiceId]
			   ,[LichenPlanId]
			   ,[ServiceClassId]
			   ,[ServiceStatusId]
			   ,[AccountId]
			   ,[InvoiceServiceGroupId]
			   ,[LocationId]
			   ,[ServiceBundleId]
			   ,[Name]
			   ,[IsAttachedToTN]
			   ,[TN]
			   ,[InvoiceLabel]
			   ,[OrderId]
			   ,[OrderTypeId]
			   ,[WasInInitialOrder]
			   ,[OrderProjectManagerId]
			   ,[OrderCreatedByPersonId]
			   ,[OrderedById]
			   ,[OrderSalesPersonId]
			   ,[MonthlyCharge]
			   ,[OneTimeCharge]
			   ,[DateSvcCreated]
			   ,[DateSvcModified]
			   ,[DateSvcLiveScheduled]
			   ,[DateSvcLiveActual]
			   ,[DateSvcCloseOrdered]
			   ,[MonthSvcCloseOrdered]
			   ,[ClosedByPersonId]
			   ,[DateSvcClosed]
			   ,[DateBillingValidFrom]
			   ,[DateBillingValidTo]
			   ,[IsBilledFirstTime]
			   ,[MonthSetupInvoiced]
			   ,[MonthLastInvoiced]
			   ,[MonthMRRFirstInvoiced]
			   ,[MonthMRRLastInvoiced]
			   ,[DateMRRInvoicedTo]
			   ,[MonthCreditIssued]
			   ,[DateCreditedFrom]
			   ,[DateCreditedTo]
			   ,[CreatedByPersonId]
			   ,[ModifiedByPersonId]
			   ,[BillingStage]
			   ,[DataIssueId]
			   ,[Loc Connecticitytype]
			   ,[Loc InvoiceGroupId]
			   ,[Ac FirstNps]
			   ,[Ac LastNps]
			   ,[Ac DateFirstServiceLive]
			   ,[Ac DateFirstInvoiced]
			   ,[Ac PartnerId]
			   ,[NumLifeDays]
			   ,[LifeDaysSegmentId]
			   ,[IsMRRZero]
			   ,[IsNRCZero]
			   ,[CircuitStatusId]
			   ,[LifeDaysNewSegmentId]
			   ,[InFirstContract]
			   ,[SvcCluster]
			   ,[SvcPlatform]
			   ,[DateSvcVoided]
			   ,[DateSvcSetToActive]
			   ,[CurrencyCode]
			   ,[CurrencyId]
			   ,[MonthlyCharge_LC]
			   ,[OneTimeCharge_LC]
			   ,[DateLocLiveForecast]
			   ,[MasterOrderTypeId] 
			FROM [oss].[VwServiceProduct_EX_Lite];

			INSERT INTO  Tableau.Logging 
			(	Created
			, Msg)
			SELECT  GETDATE()
			, 'Loaded tableau.mVwServiceProduct_EX for Pipeline';
	 
		END 
	*/

	SELECT *
	INTO #mVwSFDCCustInfo_stage
	FROM [MegaSILO].MEGASILO.dbo.V_TABLEAU_SFDC_CUST_INFO
	WHERE rn = 1; -- MW 04182019  no duplicates allowed

	-- MW 03162020 Update cust info
	IF (OBJECT_ID('Tableau.mVwSFDCCustInfo', 'U') IS NOT NULL AND ((SELECT COUNT_BIG(*)  FROM #mVwSFDCCustInfo_stage) > 10000))
	BEGIN
		
		DROP TABLE Tableau.mVwSFDCCustInfo

		SELECT *
		INTO Tableau.mVwSFDCCustInfo
		FROM #mVwSFDCCustInfo_stage;

		INSERT INTO Tableau.Logging (
			Created
			,Msg
			) 
			SELECT getdate()
			,'Loaded Table Tableau.mVwSFDCCustInfo';
	END

	DROP TABLE #mVwSFDCCustInfo_stage;
		

		/*
		-- MW 03162020 Update cust info
		IF (OBJECT_ID('Tableau.mVwSFDCCustInfo', 'U') IS NOT NULL AND ((SELECT COUNT_BIG(*)  FROM [$(MiBI)].dbo.V_TABLEAU_SFDC_CUST_INFO) > 10000))
		BEGIN
		
				TRUNCATE TABLE [Tableau].[mVwSFDCCustInfo]; 

				INSERT INTO [Tableau].[mVwSFDCCustInfo]
				   ([SfdcId]
				   ,[AccountId]
				   ,[PartnerName]
				   ,[CSD_MA]
				   ,[Employees]
				   ,[CSM]
				   ,[PartnerName_Onsite]
				   ,[AccountTeam]
				   ,[BOSS_Support_Partner__c]
				   ,[MiCloud_Connect_Business_Model__c]
				   ,[PartnerDisplayName__c]
				   ,[PartnerSupportEmailAddress__c]
				   ,[PartnerSupportInformation__c]
				   ,[PartnerSupportPhoneNumber__c]
				   ,[PartnerSupportWebPage__c]
				   ,[Support_Partner_Enabled__c]
				   ,[PartnerOfRecordCloudSAPNumber]
				   ,[rn])
				SELECT [SfdcId]
				   ,[AccountId]
				   ,[PartnerName]
				   ,[CSD_MA]
				   ,[Employees]
				   ,[CSM]
				   ,[PartnerName_Onsite]
				   ,[AccountTeam]
				   ,[BOSS_Support_Partner__c]
				   ,[MiCloud_Connect_Business_Model__c]
				   ,[PartnerDisplayName__c]
				   ,[PartnerSupportEmailAddress__c]
				   ,[PartnerSupportInformation__c]
				   ,[PartnerSupportPhoneNumber__c]
				   ,[PartnerSupportWebPage__c]
				   ,[Support_Partner_Enabled__c]
				   ,[PartnerOfRecordCloudSAPNumber]
				   ,[rn]
				FROM [$(MiBI)].dbo.V_TABLEAU_SFDC_CUST_INFO;

				INSERT INTO  Tableau.Logging 
				(	Created
					, Msg
				)
			SELECT  GETDATE()
			, 'Loaded Tableau.mVwSFDCCustInfo';
	END 
	
	*/

END	
