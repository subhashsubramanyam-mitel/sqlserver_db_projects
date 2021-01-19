
CREATE view [Tableau].[VwSfdcPartnerLookup] as
-- MW 07282020 Partner Listing by Account - US
SELECT  cast ( [AccountId] as int) as AccountId
      ,[PartnerName] as [Partner Name (Cloud)]
      ,[PartnerName_Onsite] as [PartnerName (Onsite)]
  FROM [Tableau].[mVwSFDCCustInfo]
  where ISNUMERIC(AccountId) = 1 and rn =1
