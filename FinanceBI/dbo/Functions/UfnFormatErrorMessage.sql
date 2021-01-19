-- ============================================================================================
-- Author:  Gerard Amitrano
-- Create date:   3/7/2013
-- Description:   This function accepts 5 input parameters containing Error values, and 
--                concatenates them into a formatted string.
--                This function is expected to be called from a BEGIN CATCH .. END CATCH block as follows:
--                    dbo.UfnFormatErrorMessage(ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_LINE(), ERROR_MESSAGE())
-- Return value:  The formatted Error Message
-- ============================================================================================

create FUNCTION UfnFormatErrorMessage
(
  @pNumber    int ,
  @pSeverity  int ,
  @pState     int ,
  @pLine      int ,
  @pMessage   varchar(4000)
)

RETURNS varchar(1000)

 AS

  BEGIN

    -- Declare local variables
    DECLARE @msg  varchar(1000);

    -- Format the error message
    SET @msg = 'ERROR: '
             + 'NUMBER='     + CONVERT(varchar, @pNumber)
             + '; SEVERITY=' + CONVERT(varchar, @pSeverity)
             + '; STATE='    + CONVERT(varchar, @pState)
             + '; LINE='     + CONVERT(varchar, @pLine)
             + '; MESSAGE='  + SUBSTRING(@pMessage, 1, 800);

    -- Return
    RETURN @msg;

  END
