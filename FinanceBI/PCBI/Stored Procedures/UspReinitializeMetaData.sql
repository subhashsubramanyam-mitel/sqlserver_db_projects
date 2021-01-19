
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2017-12-18
-- Description:	Regenerate meta data for Partner Commission Cube from materialized view 
--
-- Change Log:  
-- ================================================================================================================================

CREATE PROCEDURE [PCBI].[UspReinitializeMetaData] 
AS
BEGIN


-- Global Account
	truncate table PCBI.GlobalAccount ;
	insert into PCBI.GlobalAccount
		select 0 FromSandbox, bar.AccountGUID, bar.AccountId, bar.ClientName
		from (
			select AccountGUID, AccountId, ClientName,
				ROW_NUMBER() over (partition by AccountGUID order by AccountId, ClientName) RankNum
			 from
			(
				select distinct AccountGUID, AccountID, ClientName
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		--left join PCBI.GlobalAccount GA on GA.AccountGUID = bar.AccountGUID
		where bar.RankNum = 1 
		--and GA.AccountGUID is null 

-- Global Location
	truncate table PCBI.GlobalLocation ;
	insert into PCBI.GlobalLocation
		select 0 FromSandbox, bar.LocationGUID, bar.LocationId
		from (
			select LocationGUID, LocationID,
				ROW_NUMBER() over (partition by LOcationGUID order by LocationID) RankNum
					 from
			(
				select distinct LocationGUID, LocationID
				from PCBI.mVwPartnerCommissionReview
	
			) foo
		) bar
		--left join PCBI.GlobalLocation GL on GL.LocationGUID  = bar.LocationGUID
		where RankNum = 1 
		-- and GL.LocationGUID is null 

-- Global Product
	truncate table PCBI.GlobalProduct;

	insert into PCBI.GlobalProduct
		select 0 FromSandbox, bar.ProductGUID, bar.ProductId, bar.ProductName 
		from (
			select ProductGUID, ProductID, ProductName,
				ROW_NUMBER() over (partition by ProductGUID order by ProductId, ProductName) RankNum
			 from
			(
				select distinct ProductGUID, ProductID, ProductName
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		--left join PCBI.GlobalProduct GA on GA.ProductGUID = bar.ProductGUID
		where bar.RankNum = 1 
		--and GA.ProductGUID is null 

-- Global Partner
	truncate table PCBI.GlobalPartner ;
	insert into PCBI.GlobalPartner
		select 0 FromSandbox, bar.CreditingPartnerId, bar.CreditingPartner
		from (
			select CreditingPartnerId, CreditingPartner,
				ROW_NUMBER() over (partition by CreditingPartnerId order by CreditingPartner) RankNum
			 from
			(
				select distinct CreditingPartnerId, CreditingPartner
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		--left join PCBI.GlobalPartner GA on GA.CreditingPartnerId = bar.CreditingPartnerId
		--where bar.RankNum = 1 and GA.CreditingPartnerId is null 
		where bar.RankNum = 1

		-- Cleanup
	delete from PCBI.GlobalPartner where CreditingPartner = 0 and CreditingPartner = ''

-- PaymentPlan 
	truncate table PCBI.PaymentPlan ;
	insert into PCBI.PaymentPlan
		select 0 FromSandbox, bar.PaymentPlan
		from (
			select PaymentPlan
					 from
			(
				select distinct PaymentPlan
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		--left join PCBI.PaymentPlan GL on GL.PaymentPlan = bar.PaymentPlan
		--where GL.PaymentPlan is null

-- SubAgent
	truncate table PCBI.SubAgent ;
	insert into PCBI.SubAgent
		select 0 FromSandbox, bar.SubAgentGUID, bar.SubAgentId, bar.SubAgent
		from (
			select SubAgentGUID, SubAgentId, SubAgent,
				ROW_NUMBER() over (partition by SubAgentGUID order by SubAgentId, SubAgent) RankNum
			 from
			(
				select distinct SubAgentGUID, SubAgentId, SubAgent
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		--left join PCBI.SubAgent GA on GA.SubAgentGUID = bar.SubAgentGUID
		--where bar.RankNum = 1 and GA.SubAgentGUID is null and bar.SubAgentGUID is not null 

-- RepName
	truncate table PCBI.RepName ;
	insert into PCBI.RepName
		select 0 FromSandbox, bar.RepName
		from (
			select RepName
					 from
			(
				select distinct RepName
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		--left join PCBI.RepName GL on GL.RepName = bar.RepName
		--where GL.RepName is null 

-- Description
	truncate table PCBI.Description ;
	insert into PCBI.Description
		select 0 FromSandbox, bar.Description
		from (
			select Description
					 from
			(
				select distinct Description
				from PCBI.mVwPartnerCommissionReview
			) foo
		) bar
		--left join PCBI.Description GL on GL.Description = bar.Description
		--where GL.Description is null 

END

