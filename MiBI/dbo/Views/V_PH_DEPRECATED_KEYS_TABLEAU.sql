

		CREATE view [dbo].[V_PH_DEPRECATED_KEYS_TABLEAU] as
		-- view for dep key report on tabby MW 10212014
		-- MW 12032014 Added fields for Kristen
		-- MW 12112014 add support end


SELECT top 100 percent 
	y.*, 
	p.NAME as SFDC_PartnerName,
	p.OwnerName as SFDC_Owner,
	p.PriContactFirstName as SFDC_PrimaryContactFirstName,
	p.PriContactLastName  as SFDC_PrimaryContactLastName,
	p.PriContactEmail as    SFDC_PrimaryContactEmail,
	p.PriContactPhone as    SFDC_PrimaryContactPhone,
	c.SupportType as		SFDC_SupportType ,
	s.Support as			SFDC_SupportEnd
FROM LKM_DEP_KEYS y
INNER JOIN (
    SELECT [Key], MAX(PH_Date) AS latestDate
    FROM LKM_DEP_KEYS
    GROUP BY [Key]
) tmp ON y.[Key] = tmp.[Key] AND y.PH_Date = tmp.latestDate left outer join
	CUSTOMERS c on y.CustomerID = c.ImpactNumber collate database_default  left outer join
	CUSTOMERS p on c.PartnerSfdcId = p.SfdcId  collate database_default left outer join
	V_SUPPORT_END s on y.CustomerID = s.ST_ID   collate database_default 
Where y.PH_Date> y.DateDeprecated_LKM
ORDER BY y.[Key]
 

/*
SELECT top 100 percent y.* FROM LKM_DEP_KEYS y
INNER JOIN (
    SELECT [Key], MAX(PH_Date) AS latestDate
    FROM LKM_DEP_KEYS
    GROUP BY [Key]
) tmp ON y.[Key] = tmp.[Key] AND y.PH_Date = tmp.latestDate
Where y.PH_Date> y.DateDeprecated_LKM
ORDER BY y.[Key]
*/

