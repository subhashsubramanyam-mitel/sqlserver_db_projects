
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Oct 12, 2016
-- Description:	Remove unprintable characters
-- =============================================
CREATE FUNCTION [dbo].[UfnRemoveUnprintableChar]
(
	-- Add the parameters for the function here
	@name nvarchar(120)
)
RETURNS nvarchar(120)
AS
BEGIN

	-- Return the result of the function
	RETURN REPLACE(REPLACE(REPLACE(@name, CHAR(10), ''), CHAR(9), ''), CHAR(13), '');

END

