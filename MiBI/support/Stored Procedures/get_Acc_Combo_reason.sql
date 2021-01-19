

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_Acc_Combo_reason]
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@acct_Team varchar(20),
	@acct_Name varchar(300) -- ALL, Platinum, Gold, Silver, Bronze

AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @CORole TABLE(COR varchar(30));
	insert into @CORole Values ('CV Support');
	insert into @CORole Values ('T1 Services ANZ');
	insert into @CORole Values ('CC Services USA');
	insert into @CORole Values ('CC Services Manila');
	insert into @CORole Values ('T1 Services India');
	insert into @CORole Values ('T1 Services USA');
	insert into @CORole Values ('T1 Services Canada');
	insert into @CORole Values ('T2 Services USA');
	insert into @CORole Values ('T2 Services Canada');
	insert into @CORole Values ('MiCC Adv Support TAC');
	
	DECLARE @AccNames TABLE(Accounts varchar(300));
	INSERT INTO @AccNames 
	select top 10 AccountName as Accounts from dbo.Cases (NOLOCK)--,CountID
		where
		CustomerType in ('CLOUD','Legacy Cloud') 
		and CaseOwnerRole in ( select COR from @CORole ) 
		and	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and AccountTeam = @acct_Team
		Group by AccountName
		order by COUNT(ID) Desc;

	--select Accounts from @AccNames;
	/*
	select AccountName,DATEPART(year , CreatedDate),DATENAME(Month , CreatedDate), COUNT(ID)
		from dbo.Cases (NOLOCK) --support.vw_MICS_Sntmt
		where
			AccountName in (Select Accounts from @AccNames)
		and	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		Group by AccountName,DATENAME(Month , CreatedDate),DATEPART(year , CreatedDate),DATEPart(Month , CreatedDate)--,CreatedDate
		order by AccountName,DATEPART(year , CreatedDate),DATEPart(Month , CreatedDate) asc;--,COUNT(ID) Desc;
	*/
	select AccountName,CaseReason, COUNT(CaseReason)
	from dbo.Cases (NOLOCK) 
	where
		AccountName = @acct_Name --in (Select Accounts from @AccNames)
	and	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	Group by AccountName,CaseReason
	order by AccountName,CaseReason asc;
	
END
