-- =============================================
-- Author:		TaoJie Chen
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE FindFirstSRs 
	-- Add the parameters for the stored procedure here
	@num int = 1, 
	@p2 int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET ROWCOUNT @num
	SELECT *
	FROM dbo.Quality_SR_View
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindFirstSRs] TO [TacEngRole]
    AS [dbo];

