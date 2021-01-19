
Create PROCEDURE [support].[getAccountList]
AS
BEGIN
	SET NOCOUNT ON;

	select c.SfdcId, c.NAME from dbo.CUSTOMERS c
	where 
	c.Status ='Active';
	
END
