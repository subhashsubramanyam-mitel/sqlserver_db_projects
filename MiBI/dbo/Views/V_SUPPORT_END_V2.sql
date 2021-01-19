
CREATE VIEW [dbo].[V_SUPPORT_END_V2]
AS
--JO 03282016 altered to pull directly from CUSTOMERS table

SELECT     CustomerSTID as ST_ID,  QMSSupport, MAX(EndDate) AS Support
FROM         dbo.CUSTOMER_AGREEMENTS a left outer join
			QMS_SUPPORT_MAP b on a.ProductName =  b.SFDCProduct
WHERE    --(Status = 'Active') AND 
		Valid = 'Y' AND isNULL(Type,'0')<>'Time and Materials' AND EndDate>=convert(char(10),getdate(),101)
/*(Type LIKE '%Enterprise%' OR
                      Type LIKE 'Partner Support%' OR
                      Type LIKE 'Shared Support%')
*/
--and  CustomerSTID= '500006'
GROUP BY  CustomerSTID,QMSSupport

