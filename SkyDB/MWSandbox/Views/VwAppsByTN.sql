CREATE View [MWSandbox].[VwAppsByTN] as
 -- MW 11292017 Apps By TN
 SELECT AccountId,
	TN, count(*) as Apps
  FROM 
		MWSandBox.VwSkyCustomerServiceMig 
		where --aa.AccountName = 'Roundtable Investment Partners LLC' and 
		 
		   Category  = 'Applications'
		   -- MW 03232018 Communicator not applicable
		   and ProductId != 294
		group by AccountId, TN