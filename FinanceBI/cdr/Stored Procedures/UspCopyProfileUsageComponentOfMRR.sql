
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2014-07-02
-- Description:	Copy Profile Usage Component of MRR
--
-- Change Log:
-- ================================================================================================================================

CREATE PROCEDURE [cdr].[UspCopyProfileUsageComponentOfMRR] 
	@InvoiceMonth date  = NULL 
AS
BEGIN
-- ASSUME table cdr.CostAndCharge, 

-- 11-13 minutes June 5
Declare @ServiceMonth Date = DateAdd(month, -1, @InvoiceMonth);
Declare @DateStart Date = DateAdd(month, 1, @ServiceMonth); -- gives first of billing month
Declare @DateEnd Date = DateAdd(day, -1, DateAdd(month, 1, @DateStart));

-- CleanTN -- (33722370 row(s) affected) in 10 minutes
update CallData.cdr.CostAndCharge
  set CleanTN = CASE WHEN LEN(TN) = 10 THEN TN
					 WHEN LEN(TN) > 10 THEN SUBSTRING(TN, LEN(TN)-9, 10)
			         ELSE null
			    END

truncate table cdr.TnRevenue

-- add TNs from CDRs
insert into cdr.TnRevenue (Tn, TnTypeId)
select distinct
FCC.CleanTN, T.TnTypeId  from CallData.cdr.CostAndCharge FCC
inner join FinanceBI.provision.Tn T on T.Id = FCC.CleanTN
inner join FinanceBI.enum.TnType TT on TT.Id = T.TnTypeId
-- (158630 row(s) affected) in 1 minute

--select count(1) from cdr.TnRevenue
-- add TNs left out without coverage
insert into cdr.TnRevenue (Tn, TnTypeId)
	select distinct T.Id, T.TnTypeId 
	from FinanceBI.invoice.VwSPItem LIS
	inner join FinanceBI.enum.Product P on P.Id = LIS.ProductId 
	inner join FinanceBI.oss.ServiceProduct SP 
		on SP.ServiceId = LIS.ServiceId and SP.ProductId = LIS.ProductId
	inner join FinanceBI.provision.Tn T on T.Id = SP.Name 
	inner join FinanceBI.enum.TnType TT on TT.Id = T.TnTypeId  
	left join cdr.TnRevenue TR on TR.Tn = T.Id 
	where LIS.ChargeCategory = 'MRR'
		and P.ProdCategory = 'Profiles' and DateGenerated between @DateStart and @DateEnd
		and TR.Tn is null -- not alrady present
		and LTRIM(T.Id) <> ''
-- (21386 row(s) affected)


--Update Service MRR newly billed in the Billing Month
update cdr.TnRevenue
	set ServiceId = SM.ServiceId,
		MRR = SM.Charge
from cdr.TnRevenue TR 
inner join (
	select SP.Name SvcName,SP.ServiceId, LIS.Charge from invoice.VwSPItem LIS
	inner join FinanceBI.enum.Product P on P.Id = LIS.ProductId 
	inner join FinanceBI.oss.ServiceProduct SP 
		on SP.ServiceId = LIS.ServiceId and SP.ProductId = LIS.ProductId
	where LIS.ChargeCategory = 'MRR'
		and P.ProdCategory = 'Profiles' and DateGenerated between @DateStart and @DateEnd
) SM on SM.SvcName = TR.Tn --like '%'+TR.TN+'%'
where TR.ServiceId is  null
-- (137014 row(s) affected) in 4 seconds

-- Usage Revenue is 25% of Profile MRR -- CHANGED from 37.5 % to 25% in JULY 2014
update cdr.TnRevenue
	 set UsageRevenue = 0.25 * MRR
where MRR is not null
-- (137014 row(s) affected) 2 seconds

-- Insert these into Cost and Charge
insert into CallData.cdr.CostAndCharge
(starttime, CDRServiceTypeId, CDRSource, TN, CleanTN, AccountId, LocationId, ChargeInvoiced)
select --top 100 
@ServiceMonth, 1 CDRServiceTypeId, 'Profile' as CDRSource, TR.Tn, TR.Tn, T.AccountId, T.LocationId, TR.UsageRevenue ChargeInvoiced
from cdr.TnRevenue TR
inner join FinanceBI.provision.Tn T on T.Id = TR.Tn 
where TR.MRR is not null 
-- (137014 row(s) affected)in few seconds
END
