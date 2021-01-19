




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_NPS_Product] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@CustType Varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @scr1 INT;
	DECLARE @scr2 INT;
	DECLARE @scr3 INT;
	DECLARE @total_Scr Decimal(5,5);


    -- Insert statements for procedure here
	
	select  @scr1 = Count(s.AccountID) 
	from dbo.Surveys s join  dbo.CUSTOMERS c on  s.AccountID=c.SfdcId --dbo.Cases c on  s.AccountID=c.AccountID
	where s.DataCollectionName like '%NPS%' 
	and s.PrimaryScore > 9 and s.ResponseReceivedDate > @crd_Dt_From and s.ResponseReceivedDate < @crd_Dt_To
	and c.CustomerType = @CustType

	select  @scr2 = Count(s.AccountID) 
	from dbo.Surveys s join  dbo.CUSTOMERS c on  s.AccountID=c.SfdcId --dbo.Cases c on  s.AccountID=c.AccountID
	where s.DataCollectionName like '%NPS%' 
	and s.PrimaryScore > 0 and s.PrimaryScore < 6 and s.ResponseReceivedDate > @crd_Dt_From and s.ResponseReceivedDate < @crd_Dt_To
	and c.CustomerType = @CustType

	select  @scr3 = Count(s.AccountID) 
	from dbo.Surveys s join  dbo.CUSTOMERS c on  s.AccountID=c.SfdcId --dbo.Cases c on  s.AccountID=c.AccountID
	where s.DataCollectionName like '%NPS%' 
	and s.PrimaryScore is not NUll and s.ResponseReceivedDate > @crd_Dt_From and s.ResponseReceivedDate < @crd_Dt_To
	and c.CustomerType = @CustType
	
	
	Select @scr1,@scr2,@scr3
	
END
