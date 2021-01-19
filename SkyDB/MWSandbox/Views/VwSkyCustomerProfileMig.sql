CREATE View MWSandBox.VwSkyCustomerProfileMig as
	-- MW 11292017 Customer Profiles
	-- Not Used
SELECT AccountId,
	  AccountName,  ProductName,
	  ProductId as ProductId,
	  ConnectProductNoApps,
	  ConnectProductApps,
	 TN
  FROM 
MWSandBox.VwSkyCustomerServiceMig 
		where  Category = 'Profiles'