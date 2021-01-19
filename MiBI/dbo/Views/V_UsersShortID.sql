
CREATE VIEW [dbo].[V_UsersShortID]
AS

SELECT     LEFT(ID,15) as ID, Active, ContactId, CreatedDate, Department, Email, FirstName, LastName, LastModifiedDate, Name, Title, Username, RoleName, BmAccessType, BmAsscToOrg, 
                      BmDelAppr, BmLogin, AccountId, AccountName, AccountPartnerCoLogin, ProfileId, ProfileName, UserLicenseId, Phone
FROM         Users



