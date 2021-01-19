-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[getNullAccounts] 
AS
BEGIN
	SET NOCOUNT ON;
	select sum(t.Accounts) as 'NullAccounts' from 
	(select count(distinct AccountID) as 'Accounts' from [support].[vw_MICS_Active_Account_New]--12143
	where CustomerType = 'CLOUD'
	group by AccountID
	having Avg(Score) is NULL) t

END
