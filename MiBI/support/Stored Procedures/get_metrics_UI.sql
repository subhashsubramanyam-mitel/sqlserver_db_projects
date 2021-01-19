

 
CREATE PROCEDURE [support].[get_metrics_UI]
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	--@interact_Type varchar(20), -- Email, Chat, Case Comment, Call(s)
	@db_Type varchar(20), -- Dashboard Type: ALL, CLOUD, Legacy Cloud, ACCT,CI
	@acct_Team varchar(20) -- ALL, Platinum, Gold, Silver, Bronze
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @total_cases INT;
	DECLARE @CC_Intract INT;
	DECLARE @Chat_Intract INT;
	DECLARE @email_Intract INT;
	DECLARE @call_Intract INT;
	DECLARE @total_sla decimal(5,3);
	DECLARE @total_fcr decimal(5,3);
	DECLARE @total_csat decimal(5,3);
	DECLARE @total_cage decimal(5,3);
	DECLARE @CSAT_survey int;
	DECLARE @fcr1 int;
	DECLARE @fcr2 int;


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

	if(@db_Type like 'ALL')
		Begin
		PRINT('ALL dashboard'); 

			--Total Cases
			Select @total_cases = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole );
	
			--Email Interaction
			Select @email_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Email';
		
			--Chat Interaction
			Select @Chat_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Chat';
		
			--CASE Comment Interaction
			Select @CC_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Case Comment';
		
			--Call Interactions
			select @call_Intract = sum([OutboundACDAnswered])+sum([ACDansweredcalls])
			from dbo.ECC_AGENTBYDATE where Date >= @crd_Dt_From and Date <= @crd_Dt_To;
			

			--Average SLA
			select @total_sla = AVG(s.SLA)
			from support.vw_MICS_SLA s join support.[vw_MICS_Sntmt] m on s.CaseNumber = m.CaseNumber
			where
			s.CreatedDate >= @crd_Dt_From and s.CreatedDate <= @crd_Dt_To
			and s.CustomerType in ('CLOUD','Legacy Cloud')
			and s.CaseOwnerRole in ( Select COR from @CORole )
			and m.Score is not null;

			--AVG CaseAge
			select @total_cage=avg(CaseAge)
			from support.vw_MICS_CaseAge 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole );
		
			--Average CSAT
			select @total_csat=avg(CSAT)
			from support.vw_MICS_CSAT 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole );
		
			--csatSurvey
					
			select @CSAT_survey = count(CSAT)
			from support.vw_MICS_CSAT
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and CSAT is not null;
		
			--FCR
			select @fcr1 = count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR is not null;

			select @fcr2= count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR =1;

			set @total_fcr = @fcr2 *100 / @fcr1;

		end
	else if(@db_Type in ('CLOUD','Legacy Cloud'))
		BEGIN
		PRINT('product db'); 

			--Total Cases
			Select @total_cases = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type
			and CaseOwnerRole in ( Select COR from @CORole );
	
			--Email Interaction
			Select @email_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Email';
		
			--Chat Interaction
			Select @Chat_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null 
			and TransactionType = 'Chat';
		
			--CASE Comment Interaction
			Select @CC_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type 
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null 
			and TransactionType = 'Case Comment';
		
			--Call Interactions
			select @call_Intract = sum([OutboundACDAnswered])+sum([ACDansweredcalls])
			from dbo.ECC_AGENTBYDATE where Date >= @crd_Dt_From and Date <= @crd_Dt_To;

			--Average SLA
			select @total_sla = AVG(s.SLA)
			from support.vw_MICS_SLA s join [support].[vw_MICS_Sntmt] m on s.CaseNumber = m.CaseNumber
			where
			s.CreatedDate >= @crd_Dt_From and s.CreatedDate <= @crd_Dt_To
			and s.CustomerType = @db_Type 
			and s.CaseOwnerRole in ( Select COR from @CORole )
			and m.Score is not null;

			--AVG CaseAge
			select @total_cage=avg(CaseAge)
			from support.vw_MICS_CaseAge 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type
			and CaseOwnerRole in ( Select COR from @CORole );
		
			--Average CSAT
			select @total_csat=avg(CSAT)
			from support.vw_MICS_CSAT 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type
			and CaseOwnerRole in ( Select COR from @CORole );
		
			--csatSurvey
					
			select @CSAT_survey = count(CSAT)
			from support.vw_MICS_CSAT
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type
			and CaseOwnerRole in ( Select COR from @CORole )
			and CSAT is not null;
		
			--FCR
			select @fcr1 = count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR is not null;

			select @fcr2= count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @db_Type 
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR =1;

			set @total_fcr = @fcr2 *100 / @fcr1;

		END
	else if(@db_Type like 'ACCT')
		BEGIN
		PRINT('Account db'); 

			--Total Cases
			Select @total_cases = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and AccountTeam = @acct_Team;
	
			--Email Interaction
			Select @email_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Email'
			and AccountTeam = @acct_Team;
		
			--Chat Interaction
			Select @Chat_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Chat'
			and AccountTeam = @acct_Team;
		
			--CASE Comment Interaction
			Select @CC_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null 
			and TransactionType = 'Case Comment'
			and AccountTeam = @acct_Team;
		
			--Call Interactions
			select @call_Intract = sum([OutboundACDAnswered])+sum([ACDansweredcalls])
			from dbo.ECC_AGENTBYDATE where Date >= @crd_Dt_From and Date <= @crd_Dt_To;

			--Average SLA
			select @total_sla = AVG(s.SLA)
			from support.vw_MICS_SLA s join [support].[vw_MICS_Sntmt] m on s.CaseNumber = m.CaseNumber
			where
			s.CreatedDate >= @crd_Dt_From and s.CreatedDate <= @crd_Dt_To
			and s.CustomerType in ('CLOUD','Legacy Cloud')
			and s.CaseOwnerRole in ( Select COR from @CORole )
			and m.Score is not null
			and s.AccountTeam = @acct_Team;

			--AVG CaseAge
			select @total_cage=avg(CaseAge)
			from support.vw_MICS_CaseAge 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and AccountTeam = @acct_Team;
		
			--Average CSAT
			select @total_csat=avg(CSAT)
			from support.vw_MICS_CSAT 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and AccountTeam = @acct_Team;
		
			--csatSurvey					
			select @CSAT_survey = count(CSAT)
			from support.vw_MICS_CSAT
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and CSAT is not null
			and AccountTeam = @acct_Team;
		
			--FCR
			select @fcr1 = count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR is not null
			and AccountTeam = @acct_Team;

			select @fcr2= count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR =1
			and AccountTeam = @acct_Team;

			set @total_fcr = @fcr2 *100 / @fcr1;

		END
	else if(@db_Type like 'CI')
		Begin
		PRINT('customer interactions'); 
		/*
			Select Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt]
			where 
			CreatedDate >= '01-01-2020' and CreatedDate <= '08-08-2020'
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
			and IsCustomer = 'Yes'
		*/

			--Total Cases
			Select @total_cases = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt_CI]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and IsCustomer = 'Yes';
	
			--Email Interaction
			Select @email_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt_CI]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Email'
			and IsCustomer = 'Yes';
		
			--Chat Interaction
			Select @Chat_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt_CI]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Chat'
			and IsCustomer = 'Yes';
		
			--CASE Comment Interaction
			Select @CC_Intract = Count(Distinct CaseNumber)
			from [support].[vw_MICS_Sntmt_CI]
			where 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and Score is not null
			and TransactionType = 'Case Comment'
			and IsCustomer = 'Yes';
		
			--Call Interactions
			select @call_Intract = sum([OutboundACDAnswered])+sum([ACDansweredcalls])
			from dbo.ECC_AGENTBYDATE where Date >= @crd_Dt_From and Date <= @crd_Dt_To;

			--Average SLA
			select @total_sla = AVG(s.SLA)
			from support.vw_MICS_SLA s join support.[vw_MICS_Sntmt_CI] m on s.CaseNumber = m.CaseNumber
			where
			s.CreatedDate >= @crd_Dt_From and s.CreatedDate <= @crd_Dt_To
			and s.CustomerType in ('CLOUD','Legacy Cloud')
			and s.CaseOwnerRole in ( Select COR from @CORole )
			and m.Score is not null;
			--and m.IsCustomer = 'Yes';

			--AVG CaseAge
			select @total_cage=avg(CaseAge)
			from support.vw_MICS_CaseAge 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole );
		
			--Average CSAT
			select @total_csat=avg(CSAT)
			from support.vw_MICS_CSAT 
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole );
		
			--csatSurvey
					
			select @CSAT_survey = count(CSAT)
			from support.vw_MICS_CSAT
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and CSAT is not null;
		
			--FCR
			select @fcr1 = count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR is not null;

			select @fcr2= count(FCR)
			from support.vw_MICS_FCR
			where
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole in ( Select COR from @CORole )
			and FCR =1;

			set @total_fcr = @fcr2 *100 / @fcr1;

		end	
	
	select @total_cases as Total_cases,
	@CC_Intract as CC_Interact, 
	@Chat_Intract as Chat_Interact, 
	@email_Intract as Email_Interact, 
	@call_Intract as Call_Interact, 
	@total_sla as Tot_SLA,
	@total_fcr as Tot_FCR, 
	@total_csat as Tot_CSAT, 
	@total_cage as Tot_CAGE,
	@CSAT_survey as CSAT_Survey;

END
