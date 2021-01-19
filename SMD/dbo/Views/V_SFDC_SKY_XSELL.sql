


CREATE view [dbo].[V_SFDC_SKY_XSELL] as 
select   convert(varchar(50),oa.UniqueId) as CrossSellId,
 oa.DateCreated  as OrderDate
,oa.OrderId , oa.AccountId,
isnull(c.PartnerOfRecordCloud, '001C000000rPTKWIA4' ) as PartnerOfRecordCloud -- default is Shoretel
,sum(oa.MRR) as 'CrossSellBookings' --  INTO SFDC_SKY_XSELL_TRK
from 
SVLBIDB.FinanceBI.oss.VwAddOrderService  oa inner join 
SVLBIDB.FinanceBI.[enum].[VwProduct] p on p.[Prod Id]= oa.ProductId and p.IsCrossSellProduct = 1 inner join 
SVLBIDB.FinanceBI.[company].[VwAccount2] va on va.[Ac Id] = oa.AccountId and va.IsBillable = 1 left outer join
SFDC_CUSTOMERS c on oa.AccountId =  c.M5DBAccountID and isnumeric(c.M5DBAccountID) = 1
--where oa.DateCreated <=  getdate()
where oa.DateCreated >= '07/01/2016' --and oa.DateCreated  <='10/31/2014'
group by convert(varchar(50),oa.UniqueId) ,  oa.DateCreated , oa.OrderId , oa.AccountId, c.PartnerOfRecordCloud
having sum(oa.MRR) <> 0


