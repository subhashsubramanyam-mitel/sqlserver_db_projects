

CREATE PROCEDURE [support].[get_RoleDet_IndivAcc]
	@From_Date DateTime,
	@To_Date DateTime,
	@acc_Name Varchar(20)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @caseStatus TABLE(case_status varchar(30));
	insert into @caseStatus Values ('Duplicate');
	insert into @caseStatus Values ('Closed');
	insert into @caseStatus Values ('Deferred/Denied');
	insert into @caseStatus Values ('Send RFO');
	insert into @caseStatus Values ('Shipped');
	insert into @caseStatus Values ('Void');
	insert into @caseStatus Values ('RFO Sent');
	insert into @caseStatus Values ('Closed - Known Issue');

	-- fetch all related caseowner role
	DECLARE @Acc_COR TABLE(cor varchar(50));
	INSERT INTO @Acc_COR 
	select Distinct(c.CaseOwnerRole) 
	from dbo.Cases c
		where
		c.AccountName=@acc_Name and c.CaseOwnerRole is not NULL
		and	((c.CreatedDate >= @From_Date and c.CreatedDate <= @To_Date)
			or 
			(c.ClosedDate >= @From_Date and c.ClosedDate <= @To_Date))

	-- cases count by Created date
	Declare @Acc_CRD Table(cor_crd varchar(50), crd_cnt int)
	Insert into @Acc_CRD
	select c.CaseOwnerRole,count(c.ID) as cnt
	from dbo.Cases c
		where
			c.CreatedDate >= @From_Date and c.CreatedDate <= @To_Date
				and c.AccountName=@acc_Name
				and c.CaseOwnerRole in (Select cor from @Acc_COR)
				
			Group by c.CaseOwnerRole

	-- cases count by Closed date
	Declare @Acc_CLD Table(cor_cld varchar(50), cld_cnt int, Case_age Decimal(5,2))
	insert into @Acc_CLD
	select c.CaseOwnerRole,Count(c.ID) as cnt,round(Avg(Cast(DATEDIFF(day,CreatedDate,ClosedDate) as decimal(5,2))),1)
	from dbo.Cases c
		where
			c.ClosedDate >= @From_Date and c.ClosedDate <= @To_Date
				and c.AccountName=@acc_Name
				and c.CaseOwnerRole in (Select cor from @Acc_COR)
				
			Group by c.CaseOwnerRole

	--fcr
	Declare @Acc_fcr Table(cor_fcr varchar(50), fcr_cnt decimal(5,2))
	Insert into @Acc_fcr
	Select c.CaseOwnerRole, Cast(ISNULL((count(Case when c.FCR=1 then 1 end)*100.0/ NULLIF(count(Case when c.FCR is not null then 1 end),0)),0) as DECIMAL(5,2))
	from dbo.Cases c
	where
			c.AccountName=@acc_Name
			and c.CaseOwnerRole in (Select cor from @Acc_COR)
			
			and ((c.CreatedDate >= @From_Date and c.CreatedDate <= @To_Date)
			or 
			(c.ClosedDate >= @From_Date and c.ClosedDate <= @To_Date))
	Group by c.CaseOwnerRole

-- export resulset
	select * from @Acc_COR cor
	left join @Acc_CRD crd  on crd.cor_crd = cor.cor
	left join @Acc_CLD cld on cld.cor_cld = cor.cor
	left join @Acc_fcr fcr on fcr.cor_fcr = cor.cor

END
