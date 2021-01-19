-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2019-11-21
-- Description:	Compute MCSS backlog on Billing database and copy it to this database. 
-- Change Log :  
-- =============================================
CREATE PROCEDURE mcss.[UspPrepareMcssBacklog]
AS
BEGIN

    EXEC M5DB_Prod.Billing.mcss.[UspComputeBacklogAndAllocate];

 	truncate table mcss.AccountProductProfileSummary_Staging; 
	insert into mcss.AccountProductProfileSummary_Staging
	select * from M5DB_Prod.Billing.mcss.AccountProductProfileSummary;

	BEGIN TRANSACTION
	exec sp_rename 'mcss.AccountProductProfileSummary', 'AccountProductProfileSummary_Old';
	exec sp_rename 'mcss.AccountProductProfileSummary_Staging', 'AccountProductProfileSummary';
	exec sp_rename 'mcss.AccountProductProfileSummary_Old', 'AccountProductProfileSummary_Staging';

	COMMIT
 

END
