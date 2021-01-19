
-- =============================================
-- Author:		Tarak Goradia
-- Create date: April 5, 2012
-- Description:	Materialize the Final SP Item View
-- =============================================
create PROCEDURE [invoice].[UspMaterializeSPItems]
	@LastBilledMonth date 
AS
BEGIN


	-- Start from scratch
	TRUNCATE TABLE invoice.mVwFinalSPItem;
	
	-- 0. MRR for Billing Items
	INSERT INTO invoice.mVwFinalSPItem 
	SELECT * 
		FROM invoice.VwFinalSPItem2
		
	;
END

