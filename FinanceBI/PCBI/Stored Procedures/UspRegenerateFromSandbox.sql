

-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2017-12-18
-- Description:	Regenerate data for Partner Commission Cube From Sandbox
--                (assume data from history tables is already present).
--
-- Change Log:  
-- ================================================================================================================================

CREATE PROCEDURE [PCBI].[UspRegenerateFromSandbox] 
AS
BEGIN

-- Commission Data from Sandbox
	truncate table PCBI.mVwPartnerCommissionReview_Incr
	
	Insert into 
		PCBI.mVwPartnerCommissionReview_Incr
		select * 
		from PCBI.VwPartnerCommissionReview_Incr;

-- Global Account
	delete from PCBI.GlobalAccount where FromSandbox = 1;
	insert into PCBI.GlobalAccount
		select 1 FromSandbox, bar.AccountGUID, bar.AccountId, bar.ClientName
		from (
			select AccountGUID, AccountId, ClientName,
				ROW_NUMBER() over (partition by AccountGUID order by AccountId, ClientName) RankNum
			 from
			(
				select distinct AccountGUID, AccountID, ClientName
				from PCBI.mVwPartnerCommissionReview_Incr
			) foo
		) bar
		left join PCBI.GlobalAccount GA on GA.AccountGUID = bar.AccountGUID
		where bar.RankNum = 1 and GA.AccountGUID is null 

-- Global Location
	delete from PCBI.GlobalLocation where FromSandbox = 1;
	insert into PCBI.GlobalLocation
		select 1 FromSandbox, bar.LocationGUID, bar.LocationId
		from (
			select LocationGUID, LocationID,
				ROW_NUMBER() over (partition by LOcationGUID order by LocationID) RankNum
					 from
			(
				select distinct LocationGUID, LocationID
				from PCBI.mVwPartnerCommissionReview_Incr
	
			) foo
		) bar
		left join PCBI.GlobalLocation GL on GL.LocationGUID  = bar.LocationGUID
		where RankNum = 1 and GL.LocationGUID is null 

-- Global Product
	delete from PCBI.GlobalProduct where FromSandbox = 1;

	insert into PCBI.GlobalProduct
		select 1 FromSandbox, bar.ProductGUID, bar.ProductId, bar.ProductName 
		from (
			select ProductGUID, ProductID, ProductName,
				ROW_NUMBER() over (partition by ProductGUID order by ProductId, ProductName) RankNum
			 from
			(
				select distinct ProductGUID, ProductID, ProductName
				from PCBI.mVwPartnerCommissionReview_Incr
			) foo
		) bar
		left join PCBI.GlobalProduct GA on GA.ProductGUID = bar.ProductGUID
		where bar.RankNum = 1 and GA.ProductGUID is null 

-- Global Partner
	delete from PCBI.GlobalPartner where FromSandbox = 1;
	insert into PCBI.GlobalPartner
		select 1 FromSandbox, bar.CreditingPartnerId, bar.CreditingPartner
		from (
			select CreditingPartnerId, CreditingPartner,
				ROW_NUMBER() over (partition by CreditingPartnerId order by CreditingPartner) RankNum
			 from
			(
				select distinct CreditingPartnerId, CreditingPartner
				from PCBI.mVwPartnerCommissionReview_Incr
			) foo
		) bar
		left join PCBI.GlobalPartner GA on GA.CreditingPartnerId = bar.CreditingPartnerId
		where bar.RankNum = 1 and GA.CreditingPartnerId is null 

-- PaymentPlan 
	delete from PCBI.PaymentPlan where FromSandbox = 1;
	insert into PCBI.PaymentPlan
		select 1 FromSandbox, bar.PaymentPlan
		from (
			select PaymentPlan
					 from
			(
				select distinct PaymentPlan
				from PCBI.mVwPartnerCommissionReview_Incr
			) foo
		) bar
		left join PCBI.PaymentPlan GL on GL.PaymentPlan = bar.PaymentPlan
		where GL.PaymentPlan is null

-- SubAgent
	delete from PCBI.SubAgent where FromSandbox = 1;
	insert into PCBI.SubAgent
		select 1 FromSandbox, bar.SubAgentGUID, bar.SubAgentId, bar.SubAgent
		from (
			select SubAgentGUID, SubAgentId, SubAgent,
				ROW_NUMBER() over (partition by SubAgentGUID order by SubAgentId, SubAgent) RankNum
			 from
			(
				select distinct SubAgentGUID, SubAgentId, SubAgent
				from PCBI.mVwPartnerCommissionReview_Incr
			) foo
		) bar
		left join PCBI.SubAgent GA on GA.SubAgentGUID = bar.SubAgentGUID
		where bar.RankNum = 1 and GA.SubAgentGUID is null and bar.SubAgentGUID is not null 

-- RepName
	delete from PCBI.RepName where FromSandbox = 1;
	insert into PCBI.RepName
		select 1 FromSandbox, bar.RepName
		from (
			select RepName
					 from
			(
				select distinct RepName
				from PCBI.mVwPartnerCommissionReview_Incr
			) foo
		) bar
		left join PCBI.RepName GL on GL.RepName = bar.RepName
		where GL.RepName is null 

-- Description
	delete from PCBI.Description where FromSandbox = 1;
	insert into PCBI.Description
		select 1 FromSandbox, bar.Description
		from (
			select Description
					 from
			(
				select distinct Description
				from PCBI.mVwPartnerCommissionReview_Incr
			) foo
		) bar
		left join PCBI.Description GL on GL.Description = bar.Description
		where GL.Description is null 

		
END