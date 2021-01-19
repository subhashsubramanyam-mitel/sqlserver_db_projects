
CREATE FUNCTION [dbo].[UfnLastBilledMonth]
(
)
RETURNS datetime
AS
BEGIN
	DECLARE @Result date = '2021-01-01';

	RETURN @Result;

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UfnLastBilledMonth] TO [app_megasilo]
    AS [dbo];

