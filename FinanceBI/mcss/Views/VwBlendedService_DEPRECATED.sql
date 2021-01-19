
CREATE view [mcss].[VwBlendedService_DEPRECATED] as 

SELECT  'Forecasted' Stage, 'PendingInContract' Status, t1.AccountId, t1.LocationId, t1.ProductId, t1.MRR, t1.NRR,  
	 convert(varchar(20), t1.ContractId) +'-' +convert(varchar(20), T1.ProductId) + '-' + convert(varchar(20),  t2.number + 1) ServiceId
FROM    M5DB_Prod.Billing.mcss.AccountProductProfileSummary t1 
JOIN    master.dbo.spt_values t2 ON t2.type = 'P' AND t2.number < t1.AllocatedPendingQty

union all

SELECT S.BillingStage, SS.Name Status,  S.AccountId, S.LocationId, S.ProductId, S.MonthlyCharge MRR, S.OneTimeCharge NRR, convert(varchar(20), ServiceId) ServiceId
from oss.VwServiceProduct_EX_2 S
inner join company.AccountAttr A on A.AccountId = S.AccountId 
inner join enum.ServiceStatus SS on SS.Id = S.ServiceStatusId
where A.IsMCSSEnabled = 1
and SS.Name not like '%Void%'
