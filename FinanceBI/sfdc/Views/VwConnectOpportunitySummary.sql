





CREATE view [sfdc].[VwConnectOpportunitySummary] as
select O.Stage, LEFT(O.OpportunityId,15) SfdcOpportunityId, O.Name OpportunityName, 
O.CloseDate, O.Created CreatedDate, A.Address, A.City, A.State, A.Zipcode,
SUM(convert(money, OP.MRRTotalPrice)) MRRTotalPrice, SUM(convert(money,NRRExtended)) NRRExtended from 
sfdc.Opportunity2 O
inner join sfdc.OpportunityProduct OP on OP.OpportunityID = O.OpportunityID
inner join sfdc.Product P on P.SfdcId = OP.ProductId
 left join sfdc.Account2  LP on LP.SfdcId = O.LeadPartner
 left join sfdc.Account2 A on A.SfdcId = O.AccountId
where 
O.Stage COLLATE SQL_Latin1_General_CP1_CI_AS not in ('Suspended','Closed Lost','Disqualified') and
(O.LeadPartner is null or LP.Name is null or LP.NAME COLLATE SQL_Latin1_General_CP1_CI_AS  not like '%CPQ%') and
(O.Name is null or (O.Name COLLATE SQL_Latin1_General_CP1_CI_AS not like '%test company%' and 
O.Name COLLATE SQL_Latin1_General_CP1_CI_AS not like '%demo%' and 
O.Name COLLATE SQL_Latin1_General_CP1_CI_AS not like '%webcom%')) and 
 P.SKU in 
('70075','70077','70079','70081','70083','72046','72047','72048','75221',
'75223','75224','74135','74137','74139','74140','74141','74142','74143',
'74144','74145','74150','74158','74160')
--and O.RecordType <> 'Secondary'
group by O.Stage, LEFT(O.OpportunityId,15), O.Name, 
O.CloseDate, O.Created, A.Address, A.City, A.State, A.Zipcode






