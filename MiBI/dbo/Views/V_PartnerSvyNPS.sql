
CREATE VIEW [dbo].[V_PartnerSvyNPS]
AS

SELECT s.ID as SvyID,r.ImpactNumber as SE_ID, cus.NAME as CompanyName,s.ResponseReceivedDate as SvyDate,s.PartnerScore as Score,
s.ContactName,s.ContactEmail  --JO 09282016 per Lisa added these two 

FROM Surveys s left outer join
CUSTOMERS cus on s.OrigAccountId=cus.SfdcId left outer join
RESELLER r on s.OrigPartnerId=r.SfdcId

Where s.ResponseReceivedDate >='2015-10-1'
AND s.PartnerScore is NOT NULL
AND s.DataCollectionName = 'NPS Survey'
AND s.StatusDesc='Response Received'


