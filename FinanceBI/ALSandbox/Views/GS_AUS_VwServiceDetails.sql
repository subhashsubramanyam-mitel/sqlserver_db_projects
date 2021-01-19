
CREATE VIEW ALSandbox.[GS_AUS_VwServiceDetails] AS

SELECT    
	 'AU_' + ltrim(str(SP.AccountId)) [M5DB Account ID]
	,AM.SfdcId [SfdcAccountId]
	,'AU_' + ltrim(str(SP.ServiceId)) [Service ID]
	,SP.Name  [Name]
	,SP.DateSvcModified [Date Svc Modified]
	,SS.Name [Svc Status]
	,SP.MonthlyCharge [Monthly Charge]
	,SP.OneTimeCharge [One Time Charge]
	,SP.DateSvcCreated [Date Svc Created]
	,SP.DateSvcClosed [Date Svc Closed]
	,SP.DateSvcCloseOrdered [Date Svc Close Ordered]
	,SP.DateSvcLiveActual [Date Svc Live Actual]
	,SP.DateSvcLiveScheduled [Date Svc Live Scheduled]
	,SP.DateBillingValidFrom [Date Billing Valid From]
	,SP.DateBillingValidTo [Date Billing Valid To]
	,'AU_' + ltrim(str(SP.OrderId)) [OrderId]
	,OT.Name [Order Type]
	,P.ProdCategory [Product Category]
	,P.ProdSubCategory [Product Sub-Category]
	,P.Name [Product Name]
	,SP.BillingStage
FROM         AU_FinanceBI.FinanceBI.oss.VwServiceProduct_EX SP
left join sfdc.VwAccountMap AM on AM.M5dbAccountId = 'AU-' + ltrim(str(SP.AccountId))
inner join AU_FinanceBI.FinanceBI.enum.ServiceStatus SS on SS.Id = SP.ServiceStatusId
inner join AU_FinanceBI.FinanceBI.enum.Product P on P.Id = SP.ProductId
left join AU_FinanceBI.FinanceBI.enum.OrderType OT on OT.Id = SP.OrderTypeId
--inner join (select dbo.UfnTruncateDay(DateAdd(day, -1, DateAdd(hour, 3, getdate()))) yesterday, dbo.UfnTruncateDay( DateAdd(hour, 3, getdate())) today) DT on 1=1
--where SP.DateSvcModified >= DT.yesterday and SP.DateSvcModified < DT.Today









