

CREATE PROCEDURE [support].[get_Acc_Combo_List]
@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@acct_Team varchar(20) -- ALL, Platinum, Gold, Silver, Bronze

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
	
	
	select top 10 AccountName as Accounts ,Count(ID)
	from dbo.Cases (NOLOCK)
		where
		CustomerType in ('CLOUD','Legacy Cloud') 
		and CaseOwnerRole in ( select COR from @CORole ) 
		and	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and AccountTeam = @acct_Team
		Group by AccountName
		order by COUNT(ID) Desc;


END
