


-- =============================================
-- Author:		Naomi Silver
-- Create date: 2013-02-13
-- Description:	Count the TN's in a range. Best guess at the number of TN's in the TnRange column
--				in service_ManageTnParam where there are no standards
-- =============================================
CREATE FUNCTION [dbo].[UfnCountTNsInRange] 
(
	-- Add the parameters for the function here
	@range varchar(64)
)
RETURNS int
--RETURNS varchar(64)
AS
BEGIN

	DECLARE @str1 varchar(16) = '', @str2 varchar(16) = '';
	DECLARE @t int, @l int, @idx int, @i int;	
	DECLARE @cnt bigint=0;
	DECLARE @start int = 1;
	DECLARE @val varchar(128) = '', @val2 varchar(256) = '';
	DECLARE @num1 bigint, @num2 bigint;
		
    WHILE @range LIKE '%[^0-9,\-]%' 
	  SET @range=replace(@range, substring(@range, patindex('%[^0-9,\-]%',@range),1),'');
    
    if (SUBSTRING(@range, 4,1) = '-')
		SET @range = SUBSTRING(@Range, 1, 3) + SUBSTRING(@RANGE, 5, len(@range) - 4);
	if (SUBSTRING(@range, 7,1) = '-')
		SET @range = SUBSTRING(@Range, 1, 6) + SUBSTRING(@RANGE, 8, len(@range) - 7);
		
	set @val = @range	
	WHILE (CHARINDEX(',', @range, @start) > 0 and @start < LEN(@range))
	BEGIN
		set @idx = CHARINDEX(',', @range, @start);
		set @l = @idx - @start;       -- length of the substring
 		set @val = substring(@range, @start, @l);
		IF @val like '%-%'
		BEGIN
			set @i = charindex('-', @val, 1);
			set @t = len(@val);
			set @l = @t - @i;
			set @str2 = substring(@val, @i+1, @l);
			set @l = len(@str2);
			set @str1 = substring(@val, @i-@l, @l);
			WHILE @str2 LIKE '%[^0-9]%' 
				SET @str2=replace(@str2, substring(@str2, patindex('%[^0-9]%',@str2),1),'');
			if (LEN(@str1) = LEN(@str2))
			BEGIN
				set @num1 = CAST(@str1 as bigint);
				set @num2 = CAST(@str2 as bigint);
				set @cnt = @cnt + @num2 - @num1;
				set @val2 = @val2 + ':' + '  (' + @str1  + ' - ' + @str2 + ')';	
			END
			ELSE
			BEGIN
				set @cnt = @cnt + 1;
				set @val2 = @val2 + '  (' + @val  + ')';
			END		
		END
		ELSE IF patindex('%[0-9]%',@val) > 0 
		BEGIN
				set @cnt = @cnt + 1;
		END
		set @val2 = @val2 + '  (' + @val  + ')';
 		set @start = @idx+1;
 		set @val = substring(@range, @start, LEN(@range)-@start+1);
	END

    if ( SUBSTRING(@val, 4, 1) = '-' AND SUBSTRING(@val, 8, 1) = '-' ) 
		SET @val = SUBSTRING(@val, 1, 3) + SUBSTRING(@val, 5, 3) + SUBSTRING(@val, 9, LEN(@val)-8);;
		
	IF @val like '%-%'
	BEGIN
		set @i = charindex('-', @val, 1);
		set @t = len(@val);
		set @l = @t - @i;
		set @str2 = substring(@val, @i+1, @l);
		set @l = len(@str2);
		set @str1 = substring(@val, @i-@l, @l);
		WHILE @str2 LIKE '%[^0-9]%' 
			SET @str2=replace(@str2, substring(@str2, patindex('%[^0-9]%',@str2),1),'');
		if (LEN(@str1) = LEN(@str2))
		BEGIN
			set @num1 = CAST(@str1 as bigint);
			set @num2 = CAST(@str2 as bigint);
			set @cnt = @cnt + @num2 - @num1 + 1;
			set @val2 = @val2 + ':' + '  (' + @str1  + ' - ' + @str2 + ')';	
		END
		ELSE
		BEGIN
			set @cnt = @cnt + 1;
			set @val2 = @val2 + '  (' + @val  + ')';
		END	
	END
	ELSE IF patindex('%[0-9]%',@val) > 0 
	BEGIN
			set @cnt = @cnt + 1;
			set @val2 = @val2 + '  (' + @val  + ')';
	END	
	set @val2 = @val2 + ' ==> ' + CAST (@cnt as varchar(15));
	IF @cnt > 10000
		set @cnt = -1
	RETURN cast (@cnt as int)
	--RETURN @val2
	
END
