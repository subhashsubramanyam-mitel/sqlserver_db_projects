CREATE PROCEDURE [support].[CSM_Priority_Procedure] 
@CSM nvarchar(40)
AS
BEGIN
	SELECT cases.CaseNumber,cases.AccountName,cases.Priority,convert(varchar(10), cases.CreatedDate, 120) as CreatedDate 
	FROM Cases AS cases LEFT JOIN dbo.CUSTOMERS AS customer
	ON cases.AccountID = customer.SfdcId
	WHERE customer.CSM = @CSM and cases.Priority = 'P1' and cases.CustomerType in ('CLOUD') 
	and cases.CreatedDate between DATEADD(month, -1, GETDATE()) AND GETDATE()
END
