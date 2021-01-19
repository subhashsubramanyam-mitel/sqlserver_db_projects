
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description:	Rate/estimate costs for DirInfo Calls
--
-- Change Log:
-- ================================================================================================================================

create PROCEDURE cdr.UspRateDirInfoCalls 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge, 
update CallData.cdr.CostAndCharge
	set CostRateTableId = 5,
		Cost_60_60 = 0.25, Cost_30_6 = 0.25
where CDRCallTypeId  in (1, 4)
-- (2288 row(s) affected) in 1 min -- Jun 5 
END
