﻿


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_Interact_Pie_CI] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Score_from Decimal(5,2),
	@Score_to Decimal(5,2),
	@Trans_type Varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @scr1 INT;
	DECLARE @scr2 INT;
	DECLARE @score_prct Decimal(5,2);

	select  @scr1 = count(CaseNumber)
	from support.vw_MICS_Sntmt_CI 
	where Score > @Score_from and Score < @Score_to
	--Score > -0.25 
	and TransactionType=@Trans_type 
	and CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	and CustomerType in ('CLOUD')
	and IsCustomer = 'Yes'
	and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA') 
	
	 

	select  @scr2 = count(CaseNumber)
	from support.vw_MICS_Sntmt_CI 
	where Emotion is not null   
	and TransactionType=@Trans_type
	and CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	and CustomerType in ('CLOUD')
	and IsCustomer = 'Yes'
	and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA') 
	
 
	--Select @scr1 as pos,@scr2 as tot
	if @scr2 > 0 
		SET @score_prct=@scr1*100.0/@scr2;
	else
		SET @score_prct=0;

	Select @score_prct as Score_Prct;
END
