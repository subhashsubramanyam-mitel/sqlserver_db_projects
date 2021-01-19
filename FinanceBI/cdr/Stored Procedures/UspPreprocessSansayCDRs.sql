
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description: Preprocess Sansay CDRS from Teledynamics
--
-- Change Log:
-- ================================================================================================================================

create PROCEDURE cdr.UspPreprocessSansayCDRs 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME Table cdr.SAN_InProcess
DECLARE @ServiceMonth date = DateAdd(month, -1, @InvoiceMonth); 

-- delete if possibility of more than last month CDRs
-- delete from FinanceBI.cdr.SAN_InProcess where (call_begin < @ServiceMonth or call_begin >= @InvoiceMonth)
-- (0 row(s) affected) in 1 minutes

-- Delete rows with non-zero duration -- ONLY if non-zero duration filter wasn't used
delete from CallData.cdr.SAN_InProcess where call_duration <=0 or call_duration is null
-- (0 row(s) affected) in 0:00:27 seconds

update CallData.cdr.SAN_InProcess
set NPA_NXX_X = null
where NPA_NXX_X = ''
-- (1431298 row(s) affected) in 29 seconds

-- For north american numbers, ensure NPA_NXX_X and NPA_NXX are filled
update CallData.cdr.SAN_InProcess
set NPA_NXX_X = Substring(E164_DIALED_NUMBER,2,7),
	NPA_NXX = Substring(E164_DIALED_NUMBER,2,6)
where Substring(E164_DIALED_NUMBER,1,1) = 1 and LEN(E164_DIALED_NUMBER) = 11
-- (9725054 row(s) affected) in 3.4 minutes 

-- extract TERMT and ORIGT,and called TN last 10 digits

update CallData.cdr.SAN_InProcess 
	set TERMT = convert(int,SUBSTRING(TERM_TRUNK,8,10)),
		ORIGT = convert(int,SUBSTRING(Orig_TRUNK,8,10)),
		CalledTN_Last10Digits = SUBSTRING(E164_DIALED_NUMBER, len(E164_DIALED_NUMBER)-9, 10), 
		CallingTN_Last10Digits = SUBSTRING(ANI, len(ANI)-9, 10) 
		--- (10772567 row(s) affected) in 4 minutes

END
