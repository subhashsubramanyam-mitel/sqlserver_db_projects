
CREATE VIEW [dbo].[V_LKMUsers]
AS
select * from Users
Where (Active='1' or Active='true')
AND lower(ltrim(rtrim(Email))) like '%@shoretel.com'
AND lower(ltrim(rtrim(Username))) like '%@shoretel.com'
AND Email not like '%termed%'
AND Username not like '%test%'
AND Username not like 'itapps%'
AND Email !='invalid@shoretel.com'
and FirstName!='AA'