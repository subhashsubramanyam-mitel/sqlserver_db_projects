CREATE FUNCTION [dbo].[UfnGetCredentials]
(
)
RETURNS varchar(127)
AS
BEGIN
	-- Declare the return variable here
	declare @Length tinyint;
	declare @Ctx varbinary(128);

	set @Ctx = CONTEXT_INFO();
	set @Length = convert(tinyint, substring(@Ctx, 1, 1));
	
	return convert(varchar(127), substring(@Ctx, 2, 1 + @Length));
END

