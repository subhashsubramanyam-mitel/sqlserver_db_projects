

-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2013-10-01
-- Description:	Separating the data cleanups
-- =============================================
CREATE PROCEDURE [dbo].[UspScrubDataForCube]
AS
BEGIN
	SET NOCOUNT ON;

	-- Fix up bad data situations which break the cube
	UPDATE people.Person
	SET email = NULL
	WHERE email = '';

	UPDATE oss.ServiceProduct
	SET DateSvcLiveActual = DateSvcModified
	WHERE DateSvcLiveActual < '1999-01-01';

	UPDATE company.LocationAttr
	SET subtenant = 'Main Office'
	WHERE subtenant LIKE 'Main Office%'
		AND Subtenant <> 'Main Office'
		AND len(Subtenant) < LEN('Main Office') + 2;

	UPDATE company.LocationAttr
	SET Subtenant = 'Beacon Funding'
	WHERE Subtenant LIKE 'Beacon Funding%'
		AND Subtenant <> 'Beacon Funding'
		AND len(Subtenant) < LEN('Beacon Funding') + 2;

	UPDATE company.LocationAttr
	SET Subtenant = 'Embroiderydesigns.com'
	WHERE Subtenant LIKE 'Embroiderydesigns.com%'
		AND Subtenant <> 'Embroiderydesigns.com'
		AND len(Subtenant) < LEN('Embroiderydesigns.com') + 2;

	UPDATE company.LocationAttr
	SET Subtenant = 'ECS Financial'
	WHERE Subtenant LIKE 'ECS Financial%'
		AND Rtrim(Subtenant) <> 'ECS Financial'
		AND len(Subtenant) < LEN('ECS Financial') + 2;

	/*		
	-- The following hack until DimDate is updated to go beyond April 2015
	update oss.ServiceProduct 
	set DateSvcLiveScheduled = '2016-01-01'
	from oss.ServiceProduct where DateSvcLiveScheduled >= '2018-01-01'
	
	UPDATE company.Location
		set DateLiveForecast = '2016-01-01'
	 where DateLiveForecast >= '2018-01-01'
	 */
	-- The following added on Nov 24, 2013 since one email had non-printable characters
	UPDATE people.Person
	SET Email = 'kmiles@trinity-pm.com'
	--select * from people.Person
	WHERE Email LIKE '%kmiles@trinity-pm.com%'
		AND Email <> 'kmiles@trinity-pm.com'
		AND len(Email) < LEN('kmiles@trinity-pm.com') + 2;

	-- added Dec 11, since one firstname had non-printable characters
	UPDATE people.Person
	SET FirstName = 'Lennert'
	WHERE FirstName LIKE '%Lennert%'
		AND FirstName <> 'Lennert'
		AND len(FirstName) < LEN('Lennert') + 2;

	-- Jan 10, 2014
	UPDATE oss.ServiceProduct
	SET Name = 'Profile'
	WHERE Name LIKE 'Profile%'
		AND Name <> 'Profile'
		AND Name NOT LIKE 'Profile %'

	UPDATE oss.ServiceProduct
	SET Name = TN
	WHERE TN IS NOT NULL
		AND TN <> Name
		AND Name LIKE TN + '%'
		AND (
			ASCII(SUBSTRING(Name, 11, 1)) < 32
			OR ASCII(SUBSTRING(Name, 11, 1)) > 127
			)

	--and TN = '6465999211'
	-- March 1, 2014
	UPDATE people.Person
	SET LastName = 'Rosenthal'
	WHERE LastName LIKE '%Rosenthal%'
		AND LastName <> 'Rosenthal'
		AND LEN(lastname) < LEN('Rosenthal') + 2;

	-- March 27, 2014
	UPDATE people.Person
	SET LastName = 'Bottari'
	WHERE LastName LIKE '%Bottari%'
		AND LastName <> 'Bottari'
		AND LEN(lastname) < LEN('Bottari') + 2;

	UPDATE company.InvoiceGroup
	SET Balance = 0.0
	WHERE Balance IS NULL;

	-- April 16, 2014
	UPDATE people.Person
	SET LastName = 'Trawick'
	WHERE LastName LIKE '%Trawick%'
		AND LastName <> 'Trawick'
		AND LEN(lastname) < LEN('Trawick') + 2;

	-- May 9
	UPDATE oss.ServiceProduct
	SET Name = TN
	WHERE isnumeric(Name) = 0
		AND isnumeric(substring(Name, 1, 10)) = 1
		AND len(Name) = 11
		AND LEN(TN) = 10

	UPDATE company.Account
	SET Name = 'Nexstara'
	WHERE Name LIKE 'Nexstara%'
		AND Name <> 'Nexstara'
		AND LEN(Name) <= LEN('Nexstara') + 2

	-- May 30, 2014
	UPDATE people.person
	SET FirstName = 'Demetrios'
	WHERE firstname LIKE '%Demetrios%'
		AND FirstName <> 'Demetrios'

	UPDATE people.Person
	SET FirstName = 'Sharad'
	WHERE FirstName LIKE 'Sharad%'
		AND FirstName <> 'Sharad'
		AND len(FirstName) < LEN('Sharad') + 2;

	-- Nov 12, 2014
	UPDATE people.Person
	SET LastName = 'Preite'
	WHERE LastName LIKE '%Preite%'
		AND LastName <> 'Bottari'
		AND LEN(lastname) < LEN('Preite') + 2;

	UPDATE people.Person
	SET LastName = 'Tracy'
	WHERE LastName LIKE '%Tracy%'
		AND LastName <> 'Tracy'
		AND LEN(lastname) < LEN('Tracy') + 2;

	UPDATE people.Person
	SET LastName = 'Hwang'
	WHERE LastName LIKE '%Hwang%'
		AND LastName <> 'Hwang'
		AND LEN(lastname) < LEN('Hwang') + 2;

	UPDATE people.Person
	SET LastName = 'Freelove'
	WHERE LastName LIKE '%Freelove%'
		AND LastName <> 'Freelove'
		AND LEN(lastname) < LEN('Freelove') + 2;

	UPDATE provision.Tn
	SET Label = 'James  Eglinton'
	WHERE Label LIKE '%James  Eglinton%'
		AND Label <> 'James  Eglinton'
		AND LEN(Label) < LEN('James  Eglinton') + 2;

	UPDATE provision.PROFILE
	SET Name = 'James  Eglinton'
	WHERE Name LIKE '%James  Eglinton%'
		AND Name <> 'James  Eglinton'
		AND LEN(Name) < LEN('James  Eglinton') + 2;

	-- Nov 16, 2014
	UPDATE people.Person
	SET FirstName = 'Fax'
	WHERE FirstName LIKE '%Fax%'
		AND FirstName <> 'Fax'
		AND LEN(FirstName) < LEN('Fax') + 2;

	UPDATE people.Person
	SET LastName = 'Eglinton'
	WHERE LastName LIKE '%Eglinton%'
		AND LastName <> 'Eglinton'
		AND LEN(LastName) < LEN('Eglinton') + 3;

	-- Dec 24, 2014
	UPDATE people.Person
	SET LastName = 'Disla'
	WHERE LastName LIKE '%Disla%'
		AND LastName <> 'Disla'
		AND LEN(LastName) < LEN('Disla') + 3;

	-- Jan 18 2015
	UPDATE people.Person
	SET FirstName = 'Joshua'
	WHERE FirstName LIKE '%Joshua%'
		AND FirstName <> 'Joshua'
		AND LEN(FirstName) < LEN('Joshua') + 3;

	UPDATE people.Person
	SET FirstName = 'Accounting'
	WHERE FirstName LIKE 'Accounting%'
		AND FirstName <> 'Accounting'
		AND LEN(FirstName) < LEN('Accounting') + 3;

	UPDATE people.Person
	SET FirstName = 'Accounts Payable'
	WHERE FirstName LIKE 'Accounts Payable%'
		AND FirstName <> 'Accounts Payable'
		AND LastName = 'Fax'
		AND LEN(FirstName) < LEN('Accounts Payable') + 3;

	-- Jan 26, 2015
	UPDATE P
	SET Email = 'joviedo@getteltoyota.motosnap.com'
	-- select * 
	FROM people.person P
	WHERE P.Email LIKE 'joviedo@getteltoyota.motosnap.com%'
		AND Email <> 'joviedo@getteltoyota.motosnap.com'
		AND LEN(Email) < LEN('joviedo@getteltoyota.motosnap.com') + 3;

	-- Feb 16, 2015
	UPDATE people.Person
	SET FirstName = 'Michelle'
	WHERE FirstName LIKE 'Michelle%'
		AND FirstName <> 'Michelle'
		AND LEN(FirstName) < LEN('Michelle') + 3;

	-- April 24, 2015
	--SELECT * FROM PEOPLE.PERSON where FirstName like 'Jean%' and FirstName <> 'Jean'
	--	 and LEN(FirstName) in (4,5,6) and FirstName not in ('Jeani', 'Jeana', 'Jeane', 'Jeanne', 'Jeanie', 'Jeanny', 'Jeanni', 'Jeanha', 'Jeanee', 'Jean C')
	UPDATE people.Person
	SET FirstName = 'Jean'
	WHERE id = 730583 -- correcting specific record

	-- May 15, 2015
	/*SELECT LEN(FirstName), LEN(RTRIM(FirstName)), * FROM PEOPLE.PERSON where FirstName like 'John%' and FirstName <> 'John'
	 and LEN(FirstName) in (4,5,6)
	  and FirstName not in ('Johnny',  'Johny',  'JohnL','Johnna','Johna','Johnta') 
	  and Firstname not Like 'John %' and Firstname not like 'John%s'*/
	UPDATE people.Person
	SET FirstName = 'John'
	WHERE id = 735659 -- correcting specific record 

	--08/10/2015
	UPDATE provision.Tn
	SET Label = 'Jaclyn Lewandowski'
	WHERE Label LIKE '%Jaclyn Lewandowski%'
		AND Label <> 'Jaclyn Lewandowski'
		AND LEN(Label) < LEN('Jaclyn Lewandowski') + 2

	UPDATE provision.PROFILE
	SET Name = 'Jaclyn Lewandowski'
	--select name from provision.Profile
	WHERE Name LIKE '%Jaclyn Lewandowski%'
		AND Name <> 'Jaclyn Lewandowski'
		AND LEN(Name) < LEN('Jaclyn Lewandowski') + 2;

	-- 23 Dec 2015
	DELETE
	FROM provision.Tn
	WHERE id = '9294772262'
		AND accountid IS NULL

	-- Delete duplicate TNs that were temporarily in US before correcting to International
	DELETE
	FROM provision.Tn
	WHERE id IN (
			SELECT Id
			FROM provision.Tn
			GROUP BY Id
			HAVING count(1) > 1
			)
		--and CountryId = 840 and ProfileId is null 
		AND ProfileId IS NULL -- duplicates with null profileid should be deleted in any country

	-- 16 May 2018
	-- Replace bad-dates
	UPDATE O
	SET DateLiveScheduled = CASE 
			WHEN DateLiveScheduled < '1999-01-01'
				THEN '2018-01-01'
			ELSE DateLiveScheduled
			END
		,DateLiveScheduledOriginal = CASE 
			WHEN DateLiveScheduledOriginal < '1999-01-01'
				THEN '2018-01-01'
			ELSE DateLiveScheduledOriginal
			END
		,DateBillingStart = CASE 
			WHEN DateBillingStart < '1999-01-01'
				THEN '2018-01-01'
			ELSE DateBillingStart
			END
	FROM oss.[Order] O
	WHERE O.DateLiveScheduled < '1999-01-01'
		OR O.DateLiveScheduledOriginal < '1999-01-01'
		OR O.DateBillingStart < '1999-01-01'
END
