-- =============================================
-- Author:		Yaniv Schahar
-- Create date: 3/22/2011
-- Description:	Canonicalize a phone number
-- =============================================
create FUNCTION provision.UfnCanonicalizeTn 
(
	-- Add the parameters for the function here
	@Tn varchar(50),
	@AccountId int = NULL
)
RETURNS varchar(50)
AS
BEGIN
	IF @Tn IS NULL
		RETURN NULL;
		
	SET @Tn = RTRIM(LTRIM(@Tn));

	DECLARE @Len int; 
	SET @Len = LEN(@Tn);

	-- Handle the easy cases first	
	IF @Len = 10 
		RETURN @Tn;
	ELSE IF (@Len = 11 AND (LEFT(@Tn,1) = '1' OR LEFT(@Tn,1) = '9' OR LEFT(@Tn,1) = '+')) OR
			(@Len = 12 AND (LEFT(@Tn,2) = '91' OR LEFT(@Tn,2) = '+1')) OR
			(@Len = 14 AND (LEFT(@Tn,4) = '9*67') OR @Len = 15 AND (LEFT(@Tn,5) = '9*671'))
		RETURN RIGHT(@Tn,10)

	-- Handle some special cases
	IF @AccountId IS NOT NULL
	BEGIN
		-- In case the out dial digit is not the standard 9,
		-- get it from the account record and check for it
		DECLARE @OutDialDigit char(1);
		IF @Len = 11 OR @Len = 12 OR @Len = 14 OR @Len = 15
		BEGIN
			SELECT @OutDialDigit = A.OutDialDigit
			FROM DimAccount A
			WHERE A.Id = @AccountId;
			
			IF (@Len = 11 AND LEFT(@Tn,1) = @OutDialDigit) OR
			   (@Len = 12 AND LEFT(@Tn,2) = @OutDialDigit+'1') OR
			   (@Len = 14 AND LEFT(@Tn,4) = @OutDialDigit+'*67') OR
			   (@Len = 15 AND LEFT(@Tn,5) = @OutDialDigit+'*671')
				RETURN RIGHT(@Tn,10)
		END
	END
		
	RETURN @Tn;

END
