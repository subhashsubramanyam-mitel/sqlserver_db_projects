
CREATE VIEW [dbo].[V_GetSupport]
AS

select   
	b.ImpactNumber,
	CASE WHEN b.SupportType LIKE 'Time%' then b.SupportType
	ELSE isnull(a.ProductName, '-No Contract')  END AS existingContractType,
		CONVERT(CHAR(10),getdate(), 120) as AgreeStart,
		CONVERT(CHAR(10),EndDate, 120) as AgreeExpireDate  ,
		c.NAME as ParentName
				from 
				CUSTOMER_AGREEMENTS a inner join
				CUSTOMERS b on a.CustomerSTID = b.ImpactNumber inner join
				RESELLER c on b.PartnerId = c.ImpactNumber
				
				 
where 
Valid = 'Y' AND EndDate>=convert(char(10),getdate(),101)

