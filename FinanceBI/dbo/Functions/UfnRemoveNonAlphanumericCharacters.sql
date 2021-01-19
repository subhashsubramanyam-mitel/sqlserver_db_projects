create Function UfnRemoveNonAlphanumericCharacters(@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
    WHILE PATINDEX('%[^0-Z]%', @strText) > 0
    BEGIN
        SET @strText = STUFF(@strText, PATINDEX('%[^0-Z]%', @strText), 1, '')
    END
    
    RETURN @strText
END
