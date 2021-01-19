
CREATE FUNCTION [dbo].[udf_ParseHTMLFromString]
(
 @HTML_STRING VARCHAR(MAX) -- Variable for string
)
RETURNS VARCHAR(MAX)
BEGIN
 
    DECLARE @STRING VARCHAR(MAX)
    Declare @Xml AS XML
    SET @Xml = CAST(('<A>'+ REPLACE(REPLACE(REPLACE(REPLACE(@HTML_STRING
        ,'<','@*'),'>','!'),'@','</A><A>'),'!','</A><A>') +'</A>') AS XML)
 
    ;WITH CTE AS (SELECT A.value('.', 'VARCHAR(MAX)') [A] 
         FROM @Xml.nodes('A') AS FN(A) WHERE CHARINDEX('*',
         A.value('.', 'VARCHAR(MAX)'))=0 
         AND ISNULL(A.value('.', 'varchar(max)'),'')<>'')
 
    SELECT @STRING=STUFF((SELECT ' ' + [A] FROM CTE FOR XML PATH('')),1,1,'')
    RETURN @STRING
END
