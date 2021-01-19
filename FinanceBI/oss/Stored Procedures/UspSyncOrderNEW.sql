

-- ==========================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-05-06
-- Description:	Sync Order data
-- Change Log:  
--  TG	11112015	Optimize, Add InFirstContract
--  SS	05192020	Used [DeprovisionDate] column from Source to merge oss.Order
-- ==========================================================================================
CREATE PROCEDURE [oss].[UspSyncOrderNEW] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Order data';

	Declare @SyncTIme Varchar(12) = Convert(varchar(10), DateAdd(day, 0, @lastSync), 120); -- 0 day safety window
	DECLARE @SS varchar(8000) = '
	MERGE oss.[Order] as target
	USING (
		SELECT * FROM OpenQuery([M5DB],
	''select * from Billing.dbo.UfnOrdersToBeSynced(''''' + @SyncTime + ''''')'')
	)
	AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.Name = source.Name, 
			target.OrderTypeId = source.OrderTypeId, 
			target.OrderStatusId = source.OrderStatusId, 
			target.AccountId = source.AccountId, 
			target.LocationId = source.LocationId, 
			target.DateLiveScheduledOriginal = source.DateLiveScheduled, -- no longer Original :-)
			target.DateLiveScheduled = source.DateLiveScheduled, 
			target.DateBillingStart= source.DateBillingStart, 
			target.DateBillingStopped = source.DateBillingStopped, 
			target.OrderedById = source.OrderedById, 
			target.ProjectManagerId = source.ProjectManagerId, 
			target.SalesPersonId = source.SalesPersonId, 
			target.ContractNumber = source.ContractNumber, 
			target.LichenQuoteId = source.LichenQuoteId, 
			target.LinkedOrderId = source.LinkedOrderId, 
			target.IsAutoCommit = source.IsAutoCommit, 
			target.IsWebOrder = source.IsWebOrder, 
			target.CloseReasonId = source.CloseReasonId, 
			target.LichenOrderId = source.LichenOrderId, 
			target.SalesForceId = source.SalesForceId, 
			target.DateCreatedOriginal = source.DateCreatedOriginal, 
			target.CreatedByPersonId = source.CreatedByPersonId, 
			target.DateModifiedOriginal = source.DateModified, --DateModifiedOriginal no longer available
			target.ModifiedByPersonId = source.ModifiedByPersonId, 
			target.DateModified = source.DateModified, 
			target.DateCreated = source.DateCreated, 
			target.ModifiedBy = source.ModifiedBy, 
			target.OtherEmails = source.OtherEmails, 
			target.MasterOrderId = source.MasterOrderId, 
			target.OrderRequestSourceId = source.OrderRequestSourceId, 
			target.CaseNumber = source.CaseNumber,
			target.OrderSubtypeId = source.OrdersubtypeId,
			target.ClientProgrammerId = source.ClientProgrammerId,
			target.DataEngineerId = source.DataEngineerId,
			target.InFirstContract = source.InFirstContract,
			target.SalesContractId = source.SalesContractId,
			target.MasterOrderTypeId = source.MasterOrderTypeId, 
			target.DeprovisionDate = source.DeprovisionDate,
			target.OrderSalesContractId = source.OrderSalesContractId
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( 			
			Id, Name, OrdertypeId, OrderStatusId, Accountid, LocationId, 
			DateLiveScheduledOriginal, 
			DateLiveScheduled, 
			DateBillingStart, 
			DateBillingStopped,
			OrderedById, ProjectManagerId, SalespersonId, ContractNumber,
			LichenQuoteId, LinkedOrderId,
			IsAutoCommit, IsWebOrder, CloseREasonId, LichenOrderId,
			SalesForceid, 
			DateCreatedOriginal, CreatedByPersonId, DateModifiedOriginal, ModifiedByPersonid,
			DateModified, DateCreated, ModifiedBy, OtherEmails,
			MasterOrderId, OrderRequestSourceId, CaseNumber, OrdersubtypeId,ClientProgrammerId,DataEngineerId,
			InFirstContract, SalesContractId,
			MasterOrderTypeId, DeprovisionDate, OrderSalesContractId
			) 
		VALUES ( 			
			Id, Name, OrdertypeId, OrderStatusId, Accountid, LocationId, 
			DateLiveScheduled, 
			DateLiveScheduled, 
			DateBillingStart, 
			DateBillingStopped,
			OrderedById, ProjectManagerId, SalespersonId, ContractNumber,
			LichenQuoteId, LinkedOrderId,
			IsAutoCommit, IsWebOrder, CloseREasonId, LichenOrderId,
			SalesForceid, 
			DateCreatedOriginal, CreatedByPersonId, DateModified, ModifiedByPersonid,
			DateModified, DateCreated, ModifiedBy, OtherEmails,
			MasterOrderId, OrderRequestSourceId, CaseNumber, OrdersubtypeId,ClientProgrammerId,DataEngineerId,
			InFirstContract, SalesContractId,
			MasterOrderTypeId, DeprovisionDate, OrderSalesContractId
			) 
	OUTPUT ''oss.Order'', $action INTO SyncChanges;
	';
	--print @SS;
	EXEC (@SS);
	PRINT convert(varchar,getdate(),14) + N': End syncing Order data';

END
