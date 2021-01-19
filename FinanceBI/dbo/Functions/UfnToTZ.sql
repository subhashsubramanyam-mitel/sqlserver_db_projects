CREATE FUNCTION [dbo].[UfnToTZ]
(@date DATETIME, @timeZone NVARCHAR (4000))
RETURNS DATETIME
AS
 EXTERNAL NAME [M5SqlFunctions].[UserDefinedFunctions].[UfnToTZ]

