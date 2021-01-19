-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-05-29
-- Description:	Updates the num pending profiles attributes on Locations 
-- Precondition: Run this every night. 
-- ChangeLog: Nov 20, 2015. Added filter to allow only managed profiles per helpdesk WO #214573
-- =============================================
CREATE PROCEDURE [company].[UspUpdateLocationNumPendingProfiles]
AS
BEGIN

update company.LocationAttr 
	set NumPendingProfiles = coalesce(AP.NumProfiles,0)
from company.LocationAttr AA 
left join (
	select S.LocationId, count(1) NumProfiles 
	from oss.ServiceProduct S
	inner join company.Location L on L.Id = S.LocationId
	inner join enum.VwProduct P on P.[Prod Id] = S.ProductId
	left join (
		select distinct serviceid 
		from invoice.VwSPItem 
		inner join (select dbo.UfnLastBilledMonth() LastBilledMonth) Const on 1=1
		where
				dbo.UfnFirstOfMonth(Dategenerated) = Const.LastBilledMonth
				) SPI  
			on SPI.ServiceId = S.ServiceId  
	where
	 P.[Class Group] = 'Profiles'
	 and P.[Prod Id] in (1, 108, 351, 352, 353, 355) -- per Kelly's email
	and S.ServiceStatusId in(1,16,27) -- Active or Pending or Provisioning
	and SPI.ServiceId is  null
	group by S.LocationId
	having COUNT(1) >= 1
) AP on AP.LocationId = AA.LocationId
END
