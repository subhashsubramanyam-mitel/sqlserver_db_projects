CREATE PROCEDURE support.CSM_All_Cases
@CSM nvarchar(50)
AS
BEGIN
	Select CaseNumber,AccountName
	FROM  support.vw_MICS_Sntmt 
	WHERE CSM = @CSM and CustomerType in ('CLOUD') 
	and CreatedDate between DATEADD(month, -1, GETDATE()) AND GETDATE()
	and CaseOwnerRole in ('CV Support','T1 Services ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA','MiCC Adv Support TAC','CC Services EMEA','T1 Services EMEA','Customer Success Manager','ACC - East Pending Cases','ACC - Global Pending Cases','T1 - East Pending Cases','T1 - Global Pending Cases')
END
