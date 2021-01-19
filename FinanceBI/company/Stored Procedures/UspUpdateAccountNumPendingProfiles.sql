-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2013-11-07
-- Description:	Updates the num pending profiles attributes on accounts 
-- Precondition: Run this every night. 
-- ChangeLog: Nov 20, 2015. Added filter to allow only managed profiles per helpdesk WO #214573
--            Apr 27, 2018  Removed the restriction of ProdId ... all Profile products. 
-- =============================================
CREATE PROCEDURE [company].[UspUpdateAccountNumPendingProfiles]
AS
BEGIN

update company.AccountAttr 
	set NumPendingProfiles = coalesce(AP.NumProfiles,0)
from company.AccountAttr AA 
left join (
	select S.AccountId, count(1) NumProfiles 
	from oss.ServiceProduct S
	inner join enum.VwProduct P on P.[Prod Id] = S.ProductId
	left join (
		select distinct serviceid from invoice.VwSPItem
		inner join (select dbo.UfnLastBilledMonth() LastBilledMonth) Const on 1=1
		 where
				dbo.UfnFirstOfMonth(Dategenerated) = Const.LastBilledMonth 
				) SPI  
			on SPI.ServiceId = S.ServiceId  
	where
	 P.[Class Group] = 'Profiles' --and L.AccountId = 11624
	 --and P.[Prod Id] in (1, 108, 351, 352, 353, 355) -- per Kelly's email
	and S.ServiceStatusId in(1,16,27) -- Active or Pending or Provisioning
	and SPI.ServiceId is  null
	group by S.AccountId
	having COUNT(1) >= 1
) AP on AP.AccountId = AA.AccountId
END


