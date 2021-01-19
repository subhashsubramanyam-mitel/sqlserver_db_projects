
CREATE PROCEDURE [support].[get_Dashboard_trend]
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@trans_Type Varchar(20) -- ALL, Email,Chat,Case Comment
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
	

	if(@trans_Type like 'ALL')
		Begin
			select  Convert(varchar(10), c.CreatedDate, 101),
				Cast((count(Case when s.Score > -0.25 then 1 end)*100.0/nullif(count(Case when s.Emotion is not null then 1 end),0)) as decimal(10,1)) as 'sntmt'
			from dbo.Cases c (NOLOCK) join support.vw_MICS_Sntmt s on c.ID = s.CaseId
			where
				c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
			and c.CaseOwnerRole in ( select COR from @CORole ) 
			Group by Convert(varchar(10), c.CreatedDate, 101)
			order by Convert(varchar(10), c.CreatedDate, 101) asc;
		end	
	else
		begin
			select  Convert(varchar(10), c.CreatedDate, 101),
				Cast((count(Case when s.Score > -0.25 then 1 end)*100.0/nullif(count(Case when s.Emotion is not null then 1 end),0)) as decimal(10,1)) as 'sntmt'
			from dbo.Cases c (NOLOCK) join support.vw_MICS_Sntmt s on c.ID = s.CaseId
			where
				c.CreatedDate >= @crd_Dt_From and c.CreatedDate <= @crd_Dt_To
			and c.CaseOwnerRole in ( select COR from @CORole ) 
			and s.TransactionType like @trans_Type
			Group by Convert(varchar(10), c.CreatedDate, 101)
			order by Convert(varchar(10), c.CreatedDate, 101) asc;
		end
END
