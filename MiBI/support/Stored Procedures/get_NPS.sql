



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_NPS] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @scr1 INT;
	DECLARE @scr2 INT;
	DECLARE @scr3 INT;
	DECLARE @total_Scr Decimal(5,5);


    -- Insert statements for procedure here
	
	select  @scr1 = Count(AccountID) from dbo.Surveys where DataCollectionName like '%NPS%' 
	and PrimaryScore > 9 and ResponseReceivedDate > @crd_Dt_From and ResponseReceivedDate < @crd_Dt_To

	select  @scr2 = Count(AccountID) from dbo.Surveys where DataCollectionName like '%NPS%' 
	and PrimaryScore > 0 and PrimaryScore < 6 and ResponseReceivedDate > @crd_Dt_From and ResponseReceivedDate < @crd_Dt_To

	select  @scr3 = Count(AccountID) from dbo.Surveys where DataCollectionName like '%NPS%' 
	and PrimaryScore is not NUll and ResponseReceivedDate > @crd_Dt_From and ResponseReceivedDate < @crd_Dt_To
	
	--SET @total_Scr= @scr1-@scr2*100.0/@scr3
	Select @scr1,@scr2,@scr3
	--SElect @total_Scr as Score_Prct

	/*
	select @scr1 = Count(s.AccountID) from dbo.Surveys s Left join dbo.Cases c on c.AccountID = s.AccountID  where s.DataCollectionName like '%NPS%' 
	and s.PrimaryScore > 9
	and c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
	and c.CustomerType in ('CLOUD','Legacy Cloud')
	and c.CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')


	select @scr2 = Count(s.AccountID) from dbo.Surveys s Left join dbo.Cases c on c.AccountID = s.AccountID  where s.DataCollectionName like '%NPS%' 
	and s.PrimaryScore > 0 and s.PrimaryScore < 6
	and c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
	and c.CustomerType in ('CLOUD','Legacy Cloud')
	and c.CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')


	select @scr3 = Count(s.AccountID) from dbo.Surveys s Left join dbo.Cases c on c.AccountID = s.AccountID  where s.DataCollectionName like '%NPS%' 
	and PrimaryScore is not NUll
	and c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
	and c.CustomerType in ('CLOUD','Legacy Cloud')
	and c.CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
	*/
	
END
