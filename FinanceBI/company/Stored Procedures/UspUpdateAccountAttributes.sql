-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-09-11
-- Description:	Computes the primary handset and other account attributes
-- Precondition: Run this every night. 
-- ChangeLog: 
-- =============================================
create PROCEDURE company.UspUpdateAccountAttributes
AS
BEGIN

update AA 
	set NumCisco = AP.NumCisco,
		NumIP4nn = AP.NumIP4nn,
		PrimaryHandset = CASE 
							WHEN AP.NumCisco > 2*AP.NumIP4nn  THEN 'Cisco' 
							WHEN AP.NumIP4nn > 0 THEN 'IP4nn'
							WHEN AP.NumCisco > 0 THEN 'Cisco'
							ELSE null
							END
	
from company.AccountAttr AA 
inner join (
	select S.AccountId, 
	SUM (CASE WHEN P.PrimaryHandset = 'Cisco' THEN 1 ELSE 0 END) NumCisco,
	SUM (CASE WHEN P.PrimaryHandset = 'IP4nn' THEN 1 ELSE 0 END) NumIP4nn
	from oss.ServiceProduct S
	inner join enum.VwProduct P on P.[Prod Id] = S.ProductId
	where
	 S.ServiceStatusId not in (25,26) -- VOID or Pending VOID
	 and P.PrimaryHandset is not null

	group by S.AccountId
	-- having COUNT(1) > 1
) AP on AP.AccountId = AA.AccountId
END

--exec company.[UspUpdateAccountAttributes]
