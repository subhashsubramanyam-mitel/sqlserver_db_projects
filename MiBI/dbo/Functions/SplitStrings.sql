﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION dbo.SplitStrings (
	@List NVARCHAR(MAX)
	,@Delimiter NVARCHAR(255)
	)
RETURNS TABLE
AS
RETURN (
		SELECT Number = ROW_NUMBER() OVER (
				ORDER BY Number
				)
			,Item
		FROM (
			SELECT Number
				,Item = LTRIM(RTRIM(SUBSTRING(@List, Number, CHARINDEX(@Delimiter, @List + @Delimiter, Number) - Number)))
			FROM (
				SELECT ROW_NUMBER() OVER (
						ORDER BY s.object_id
						)
				FROM sys.all_objects AS s
				CROSS APPLY sys.all_objects
				) AS n(Number)
			WHERE Number <= CONVERT(INT, LEN(@List))
				AND SUBSTRING(@Delimiter + @List, Number, 1) = @Delimiter
			) AS y
		);