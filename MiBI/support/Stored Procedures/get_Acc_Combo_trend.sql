


CREATE PROCEDURE [support].[get_Acc_Combo_trend]
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@acct_Team varchar(20), -- ALL, Platinum, Gold, Silver, Bronze
	@acct_Name varchar(300)
AS
BEGIN
	
	SET NOCOUNT ON;

	
	DECLARE	@scr1 int;
	DECLARE	@scr2 int;
	
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
	/*
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
		*/
	--Declare @TrendList Table(AccountName varchar(300), CreatedDateYear varchar(20), CreatedMonth varchar(20), countID varchar(20));
	
	/*
	-- score value
	DECLARE @posScr TABLE(AccountName varchar(300),yearVal varchar(5), monthVal varchar(15), posCasesCount int);
	insert into @posScr 
		select c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate), COUNT(ID)
	from dbo.Cases c (NOLOCK) join support.vw_MICS_Sntmt s on c.ID = s.CaseId
	where
		c.AccountName =@acct_Name --in (Select Accounts from @AccNames)
	and	c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
	and s.Score > 0
	Group by c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate)--DATENAME(Month , c.CreatedDate),
	order by c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate) asc;
	
	Declare @EmotionScr Table(AccountName varchar(300),yearVal varchar(5), monthVal varchar(15), emotionCasesCount int);
	insert into @EmotionScr 
		select c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate), COUNT(ID)
	from dbo.Cases c (NOLOCK) join support.vw_MICS_Sntmt s on c.ID = s.CaseId
	where
		c.AccountName = @acct_Name--in (Select Accounts from @AccNames)
	and	c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
	and s.Emotion is not null
	Group by c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate) --,DATENAME(Month , c.CreatedDate)
	order by c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate) asc;

	select *--p.AccountName, p.yearVal, p.monthVal, p.posCasesCount, e.emotionCasesCount
	from @posScr p join @EmotionScr e on p.AccountName = e.AccountName;
	*/

	select c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate),
		Cast((count(Case when s.Score > 0 then 1 end)*100.0/count(Case when s.Emotion is not null then 1 end)) as decimal(10,1)) as 'sntmt'
	from dbo.Cases c (NOLOCK) join support.vw_MICS_Sntmt s on c.ID = s.CaseId
	where
		c.AccountName = @acct_Name --in (Select Accounts from @AccNames)
	and	c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
	and c.CaseOwnerRole in ( select COR from @CORole ) 
	Group by c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate)--DATENAME(Month , c.CreatedDate),
	order by c.AccountName,DATEPART(year , c.CreatedDate),DATEPART(Month , c.CreatedDate) asc;
	

	--select @scr1,@scr2;
END
