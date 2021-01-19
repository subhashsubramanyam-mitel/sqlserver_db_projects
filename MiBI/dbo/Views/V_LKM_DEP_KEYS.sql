
CREATE VIEW [dbo].[V_LKM_DEP_KEYS]
AS
-- MW 12032014 Added fields for Kristen
SELECT 
tmp.*,
y.*, 
p.NAME as SFDC_PartnerName,
p.OwnerName as SFDC_Owner,
p.PriContactFirstName as SFDC_PrimaryContactFirstName,
p.PriContactLastName  as SFDC_PrimaryContactLastName,
p.PriContactEmail as    SFDC_PrimaryContactEmail,
p.PriContactPhone as    SFDC_PrimaryContactPhone,
c.SupportType as		SFDC_SupportType 
FROM LKM_DEP_KEYS y
INNER JOIN (
    SELECT [Key] as DepKeys, MAX(PH_Date) AS latestDate
    FROM LKM_DEP_KEYS
    GROUP BY [Key]
) tmp ON y.[Key] = tmp.DepKeys AND y.PH_Date = tmp.latestDate left outer join
CUSTOMERS c on y.CustomerID = c.ImpactNumber collate database_default  left outer join
CUSTOMERS p on c.PartnerSfdcId = p.SfdcId  collate database_default
Where y.PH_Date> y.DateDeprecated_LKM


/*
--JO 07112014 per Chris Fortuna
SELECT * FROM LKM_DEP_KEYS y
INNER JOIN (
    SELECT [Key] as DepKeys, MAX(PH_Date) AS latestDate
    FROM LKM_DEP_KEYS
    GROUP BY [Key]
) tmp ON y.[Key] = tmp.DepKeys AND y.PH_Date = tmp.latestDate
Where y.PH_Date> y.DateDeprecated_LKM
--ORDER BY y.[Key]
*/
