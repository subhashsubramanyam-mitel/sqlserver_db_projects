



-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2013-03-26
-- Description:	Wrapper around dimension sync SPs
--
-- Change Log:  2015-09-09 call to optimized sync procs for ServiceProduct and TN
--				2015-11-24 sync of AccountContract
--              2019-07-23 sync of Sales Contract Lineitems
--              2020-01-25 Tarak, call to materliaze views for better sync performance
--				2020-06-04 Subhash, included oss.UspSyncServiceSettings per Mark
--				2020-07-09 Subhash, included enum.UspSyncContractBusinessTermVersion as per Mark in Line 52
--				2020-08-10	Subhash,included company.UspSyncM5dbCircuitCircuit as per Mark in line 123
-- ================================================================================================================================

CREATE PROCEDURE [dbo].[UspSyncMini] 
AS
BEGIN

	DECLARE @LastSync	date = dbo.UfnTruncateDay(getdate()); -- since the beginning of the day

     
    		-- Dimension tables (sync changes only, for those that change)
    		EXEC enum.UspSyncCluster @lastSync
    		EXEC company.UspSyncAccountAttr @lastSync
    		EXEC company.UspSyncAccount @lastSync
    		EXEC company.UspSyncAccountCluster @lastSync
    		EXEC company.UspSyncInvoiceGroup @lastSync
    		EXEC company.UspSyncLocationAttr @lastSync
    		EXEC company.UspSyncLocation @lastSync
    		EXEC company.UspSyncPartner @lastSync
			EXEC company.UspsyncAccountContract @lastSync 
			EXEC company.UspSyncM5dbCircuitCircuit @lastSync
			
			EXEC sales.UspSyncContract @lastSync
			EXEC sales.UspSyncContractLineItem @lastSync

    		EXEC provision.UspSyncTnNEW @LastSync 
    		EXEC provision.UspSyncProfile @lastSync, 1111;   
    		EXEC people.UspSyncPerson @lastSync
    		EXEC enum.UspSyncAccessRole @lastSync
    		
    		EXEC people.UspSyncAccessRoleMember @lastSync
    
    		EXEC enum.UspSyncServiceclass @lastSync
    		EXEC enum.UspSyncProduct @lastSync
    		EXEC enum.UspSyncContractBusinessTermVersion  -- no parameter, Added by SS, 2020-07-09

			EXEC M5DB.Billing.dbo.UspMaterializeViews -- 2020-01-25 for Better Perforamnce of syncs
    		
    		--EXEC oss.UspSyncNPS  -- was already stopped
    		-- The followig  may have to be separated
    		EXEC [oss].[UspSyncServiceSettings] -- no parameter, Added by SS, 2020-12-01
			EXEC oss.UspSyncServiceParentProfile -- no parameter, Added by SS, 2020-12-08

			EXEC oss.UspSyncOrderNEW @LastSync 
    		EXEC oss.UspSyncOrderItemNEW @lastSync  
			EXEC oss.UspSyncServiceProductNEW  @LastSync 
			EXEC oss.UspSyncOrderItemService @lastSync	
			EXEC oss.UspUpdateServiceBillingAttributes  @lastSync 
    		EXEC oss.UspSyncOrderNEW @LastSync -- do it again just in case
			
			
			-- Materialize OrderItemDetail View
			IF EXISTS (SELECT 1 
					   FROM INFORMATION_SCHEMA.TABLES 
					   WHERE TABLE_TYPE='BASE TABLE' 
					   AND TABLE_NAME='MatVwOrderItemDetail_Ex_Base') 
				drop  table oss.MatVwOrderItemDetail_Ex_Base;
			select *
			into oss.MatVwOrderItemDetail_Ex_Base
			from oss.VwOrderItemDetail_Ex_Base;

			-- Materialize ServiceProduct
			truncate table oss.MatVwServiceProduct_EX_2_Base;
			insert into oss.MatVwServiceProduct_EX_2_Base
			select * from oss.VwServiceProduct_EX_2_Base

 
END
