
-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2014-11-25
-- Description: Start of the Quarter containing the given date
-- =============================================
CREATE FUNCTION [dbo].[UfnFirstOfQuarter]
(
	@GivenDate date
)
RETURNS date
AS
BEGIN

	RETURN    DATEADD(q, DATEDIFF(q, 0, @GivenDate), 0) 

END

