-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-05-07
-- Description:	Computes monthly billing stats of accounts & locations 
-- Precondition: Run this once after the monthly billing has been run and approved. 
-- ChangeLog: 
-- =============================================
CREATE PROCEDURE [invoice].[UspComputeMonthlyBillingStats]
   @FirstOfBillingMonth Date = null
AS
BEGIN
Declare  @DateStart date = @FirstOfBillingMonth;
Declare  @DateEnd  date = DateAdd(day, -1, DateAdd(month, 1, @FirstofBillingMonth));

delete from invoice.AccountMonthlyBillingStats where InvoiceMonth between @DateStart and @DateEnd;

Insert Into invoice.AccountMonthlyBillingStats
	(AccountId, InvoiceMonth, LastInvoiceId, NumProfiles, NumInvoices, NumManagedProfiles, ClusterId, PlatformTypeId)
select foo.*, C.Id ClusterId, C.PlatformTypeId 
from (
Select 
	  A.AccountId, Inv.InvoiceMonth, 
	  MAX(Inv.InvoiceId) LastInvoiceId, Coalesce(SUM(Pr.NumProfiles),0) NumProfiles,
	SUM(CASE WHEN Inv.InvoiceId is not null THEN 1 ELSE 0 END) NumInvoices,
	 Coalesce(SUM(Pr.NumManagedProfiles),0) NumManagedProfiles
from  company.AccountAttr A
left join (
	select 
		Ig.AccountId,
		I.ID InvoiceId,
		dbo.UfnFirstOfMonth(DateGenerated) InvoiceMonth
	 from invoice.Invoice I
	 inner join company.InvoiceGroup IG on IG.Id = I.InvoiceGroupId
	 where 	 DateGenerated between @DateStart and @DateEnd
	 ) Inv on Inv.AccountId = A.AccountId 
 left join (
	select L.AccountId, FI.InvoiceId, SUM(FI.Quantity) NumProfiles,
	SUM(Case WHEN FI.ProductId = 108 THEN FI.Quantity ELSE 0 END) NumManagedProfiles
	from invoice.vwLineitem FI 
	inner join company.Location L on L.Id = FI.LocationId
	inner join enum.VwProduct P on P.[Prod Id] = FI.ProductId
	where FI.ChargeCategory = 'MRR' 
	and P.[Class Group] = 'Profiles' --and L.AccountId = 11624
	group by L.AccountId, FI.InvoiceId
) Pr on Pr.InvoiceId = Inv.InvoiceId
where A.IsBillable = 1
 group by A.AccountId, Inv.InvoiceMonth
 having SUM(CASE WHEN Inv.InvoiceId is not null THEN 1 ELSE 0 END) > 0 
 ) foo
INNER JOIN  Company.Account A on A.Id = foo.AccountId 
 LEFT OUTER JOIN enum.Cluster AS C ON A.PrimaryClusterId = C.Id 


 
 
 
 -- Location stats
 delete from invoice.LocationMonthlyBillingStats where InvoiceMonth between @DateStart and @DateEnd;

Insert Into invoice.LocationMonthlyBillingStats
	(LocationId, InvoiceMonth, LastInvoiceId, NumProfiles, NumInvoices, NumManagedProfiles)
		select LA.LocationId, Pr.InvoiceMonth, Max(Pr.InvoiceId) LastInvoiceId, 
			coalesce(SUM(Pr.NumProfiles),0) NumProfiles, 
			SUM(CASE WHEN Pr.InvoiceId is not null THEN 1 ELSE 0 END) NumInvoices,
			 Coalesce(SUM(Pr.NumManagedProfiles),0) NumManagedProfiles
		from  company.LocationAttr LA
		inner join company.Location L on L.Id = LA.LocationId
		left join (
			select FI.LocationId, FI.InvoiceId, dbo.UfnFirstOfMonth(FI.Dategenerated) InvoiceMonth,
				 SUM(FI.Quantity) NumProfiles,
				SUM(Case WHEN FI.ProductId = 108 THEN FI.Quantity ELSE 0 END) NumManagedProfiles  
			from invoice.vwLineitem FI 
			inner join company.Location L on L.Id = FI.LocationId
			inner join enum.VwProduct P on P.[Prod Id] = FI.ProductId
			where FI.ChargeCategory = 'MRR' 
				and P.[Class Group] = 'Profiles' --and L.AccountId = 11624
				and FI.DateGenerated between @DateStart and @DateEnd
			group by FI.LocationId, FI.InvoiceId, dbo.UfnFirstOfMonth(FI.Dategenerated)
		) Pr on Pr.LocationId = LA.LocationId
		 group by LA.LocationId, Pr.InvoiceMonth
		 having SUM(CASE WHEN Pr.InvoiceId is not null THEN 1 ELSE 0 END) > 0 
		 
END
