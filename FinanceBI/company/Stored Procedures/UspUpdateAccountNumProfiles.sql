-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2013-11-07
-- Description:	Updates the num profiles attributes AND Active MRR on accounts 
-- Precondition: Run this once after the monthly billing has been run and approved. 
-- ChangeLog: 
-- =============================================
CREATE PROCEDURE [company].[UspUpdateAccountNumProfiles]
AS
BEGIN

update company.AccountAttr 
	set NumProfiles = coalesce(AP.NumProfiles,0)
from company.AccountAttr AA 
left join (
select A.AccountId, MAX(Inv.InvoiceId) LastInvoiceId, Coalesce(SUM(Pr.NumProfiles),0) NumProfiles, 
	SUM(CASE WHEN Inv.InvoiceId is not null THEN 1 ELSE 0 END) NumInvoices
from  company.AccountAttr A
left join (
	select 
		Ig.AccountId,
		I.ID InvoiceId,
		DateGenerated
	 from invoice.Invoice I
	 inner join company.InvoiceGroup IG on IG.Id = I.InvoiceGroupId
	 inner join (select dbo.UfnLastBilledMonth() LastBilledMonth) Const on 1=1
	 where 	 dbo.UfnFirstOfMonth(DateGenerated)  = const.LastBilledMonth
	 ) Inv on Inv.AccountId = A.AccountId 
 left join (
	select L.AccountId, FI.InvoiceId, SUM(FI.Quantity) NumProfiles 
	from invoice.vwLineitem FI 
	inner join company.Location L on L.Id = FI.LocationId
	inner join enum.VwProduct P on P.[Prod Id] = FI.ProductId
	where FI.ChargeCategory = 'MRR' 
	and P.[Class Group] = 'Profiles' --and L.AccountId = 11624
	group by L.AccountId, FI.InvoiceId
) Pr on Pr.InvoiceId = Inv.InvoiceId
 group by A.AccountId
 having SUM(CASE WHEN Inv.InvoiceId is not null THEN 1 ELSE 0 END) > 0 
 --  and SUM(Pr.NumProfiles) is not null
) AP on AP.AccountId = AA.AccountId

-- for correctness, also update pending profiles
EXEC [company].[UspUpdateAccountNumPendingProfiles]

-- set Active MRR 
update AA
	set AA.ActiveMRR = coalesce(SA.ActiveMRR,0.0)
	from company.AccountAttr AA

	left join  (
		select SP.AccountId,SUM(SP.Charge) ActiveMRR from invoice.VwSPItem SP 
		inner join (
			select MAX(DateGenerated) LastDate from invoice.Invoice
			) MB on 1=1
		where SP.DateGenerated = MB.LastDate  and SP.ChargeCategory = 'MRR'
		group by SP.AccountId

	) SA on SA.AccountId = AA.AccountId 

END

--exec [UspUpdateAccountNumProfiles]

--select * from DimAccountAttr where NumProfiles is null
