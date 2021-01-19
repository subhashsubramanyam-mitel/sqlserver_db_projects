/*


CREATE VIEW [dbo].[V_COM_SFDC_BKLOG]
AS

--used in SFDC billings upload

select SalesOrder,b.SfdcId AS PartnerSfdcId, OrderDate, SUM(BklgUSD) as USD
  from   Local_MASTERbacklog a LEFT OUTER JOIN
             CORPDB.STDW.dbo.SFDC_PARTNERS AS b ON a.ImpactNumber = b.ImpactNumber collate database_Default
  group by SalesOrder ,b.SfdcId, OrderDate
  having SUM(BklgUSD) >0
  
 */


