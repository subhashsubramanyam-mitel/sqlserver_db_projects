-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2013-11-07
-- Description:	Updates the num profiles attributes on locations 
-- Precondition: Run this once after the monthly billing has been run and approved. 
-- ChangeLog: 
-- =============================================
create PROCEDURE company.UspUpdateLocationNumProfiles
AS
BEGIN
Declare @FirstOfMonth date = dbo.UfnFirstOfMonth(getdate());
Declare  @DateStart date = @FirstOfMonth;
Declare  @DateEnd  date = DateAdd(day, -1, DateAdd(month, 1, @FirstofMonth));

update company.LocationAttr 
	set NumProfiles = coalesce(LP.NumProfiles,0)
from company.LocationAttr LA 
left join (
		select LA.LocationId, Max(Pr.InvoiceId) LastInvoiceId, 
			coalesce(SUM(Pr.NumProfiles),0) NumProfiles, 
			SUM(CASE WHEN Pr.InvoiceId is not null THEN 1 ELSE 0 END) NumInvoices
		from  company.LocationAttr LA
		inner join company.Location L on L.Id = LA.LocationId
		left join (
			select FI.LocationId, FI.InvoiceId, SUM(FI.Quantity) NumProfiles 
			from invoice.vwLineitem FI 
			inner join company.Location L on L.Id = FI.LocationId
			inner join enum.VwProduct P on P.[Prod Id] = FI.ProductId
			where FI.ChargeCategory = 'MRR' 
				and P.[Class Group] = 'Profiles' --and L.AccountId = 11624
				and FI.DateGenerated between @DateStart and @DateEnd
			group by FI.LocationId, FI.InvoiceId
		) Pr on Pr.LocationId = LA.LocationId
		 group by LA.LocationId
		 having SUM(CASE WHEN Pr.InvoiceId is not null THEN 1 ELSE 0 END) > 0 
	) LP on LP.LocationId = LA.LocationId
	
	-- update pending profiles as well 
	EXEC [company].[UspUpdateLocationNumPendingProfiles]

END
