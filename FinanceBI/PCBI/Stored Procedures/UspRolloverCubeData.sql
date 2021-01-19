
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2017-12-18
-- Description:	Rollover Cube data for Partner Commission Cube From Sandbox to prepare for Next month
--                (assume data from history tables is already present).
--
-- Change Log:  
-- ================================================================================================================================

CREATE PROCEDURE [PCBI].[UspRolloverCubeData] 
AS
BEGIN

-- Regenerate
	EXEC PCBI.UspRegenerateFromSandbox; 

-- Commission Data from Sandbox to Archive
	Insert into 
		PCBI.mVwPartnerCommissionReview
		select * 
		from PCBI.mVwPartnerCommissionReview_Incr;
	truncate table  PCBI.mVwPartnerCommissionReview_Incr

-- Global Account
	drop table PCBI.GlobalAccount;
	select 0 FromSandbox, AccountGUID, AccountId, ClientName 
	into PCBI.GlobalAccount
		from (
			select AccountGUID, AccountId, ClientName,
				ROW_NUMBER() over (partition by AccountGUID order by AccountId, ClientName) RankNum
				from
			(
				select distinct AccountGUID, AccountID, ClientName
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		where RankNum = 1

-- Global Location
	drop table PCBI.GlobalLocation;
	select 0 FromSandbox, LocationGUID, LocationId
	into PCBI.GlobalLocation
		from (
			select LocationGUID, LocationID,
				ROW_NUMBER() over (partition by LOcationGUID order by LocationID) RankNum
					 from
			(
				select distinct LocationGUID, LocationID
				from PCBI.mVwPartnerCommissionReview
	
			) foo
		) bar
		where RankNum = 1

-- Global Product
	drop table PCBI.GlobalProduct;
	select 0 FromSandbox, ProductGUID, ProductId, ProductName 
	into PCBI.GlobalProduct
		from (
			select ProductGUID, ProductID, ProductName,
				ROW_NUMBER() over (partition by ProductGUID order by ProductId, ProductName) RankNum
			 from
			(
				select distinct ProductGUID, ProductID, ProductName
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		where RankNum = 1

-- Global Partner
	drop table PCBI.GlobalPartner;

	select 0 FromSandbox, CreditingPartnerId CreditingPartnerId, CreditingPartner 
	into PCBI.GlobalPartner
		from (
			select CreditingPartnerId, CreditingPartner,
				ROW_NUMBER() over (partition by CreditingPartnerId order by CreditingPartner) RankNum
			 from
			(
				select distinct CreditingPartnerId, CreditingPartner
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		where RankNum = 1

-- PaymentPlan 
	drop table PCBI.PaymentPlan;
	select 0 FromSandbox, PaymentPlan
	into  PCBI.PaymentPlan
		from (
			select PaymentPlan
					 from
			(
				select distinct PaymentPlan
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar

-- SubAgent
	drop table PCBI.SubAgent;
	select 0 FromSandbox, SubAgentGUID, SubAgentId, SubAgent
	into PCBI.SubAgent
		from (
			select SubAgentGUID, SubAgentId, SubAgent,
				ROW_NUMBER() over (partition by SubAgentGUID order by SubAgentId, SubAgent) RankNum
			 from
			(
				select distinct SubAgentGUID, SubAgentId, SubAgent
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		where RankNum = 1 and bar.SubAgentGUID is not null														

-- RepName
	drop table PCBI.RepName
	select 0 FromSandbox, RepName
		into PCBI.RepName
		from (
			select RepName
					 from
			(
				select distinct RepName
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar

-- Description
	drop table PCBI.Description;
	select 0 FromSandbox, Description
	into PCBI.Description
		from (
			select Description
					 from
			(
				select distinct Description
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
END

