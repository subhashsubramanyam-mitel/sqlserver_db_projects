
--select * from [V_SKY_SERVICESYNC] where m5db__Account__c = '14084'

CREATE VIEW [dbo].[V_SKY_ASSETRPT]
AS
SELECT  -- top 10 

cus.SfdcId,
sa.Accountid as M5DBAccountId,
sa.Class,
sa.MRR,
sa.NRC	as NRR,
sa.Name as ServiceName,
sa.M5DBServiceId,
sa.Status

FROM         
SKY_ASSETS sa LEFT OUTER JOIN
CUSTOMERS cus on sa.M5DBAccountId=cus.M5DBAccountID

--where Accountid = '14084'
--where (DateOrdered != '10/03/0207') --or DateOrdered is NULL Or DateOrdered != '08/21/0085')

--where  ( DateLiveActual not like '%0001' OR DateOrdered not like '%0085'  
   --OR DateOrdered not like '%0207'  )
   
   
-- delete from 
 -- select   from  SKY_SFDC_SERVICES where CiId 
--where DateOrdered in ( '08/21/0085', '10/03/0207')



GO
GRANT SELECT
    ON OBJECT::[dbo].[V_SKY_ASSETRPT] TO [TacEngRole]
    AS [dbo];

