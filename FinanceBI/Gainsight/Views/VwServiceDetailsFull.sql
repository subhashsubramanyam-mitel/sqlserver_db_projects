





--select top 100 * from Gainsight.VwServiceDetails



CREATE VIEW [Gainsight].[VwServiceDetailsFull]
AS
SELECT    
	 SP.AccountId [M5DB Account ID]
	,AM.SfdcId [SfdcAccountId]
	,SP.ServiceId [Service ID]
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
	,SP.OrderId [OrderId]
	,OT.Name [Order Type]
	,P.ProdCategory [Product Category]
	,P.ProdSubCategory [Product Sub-Category]
	,P.Name [Product Name]
	,SP.BillingStage
FROM         oss.VwServiceProduct_EX SP
left join sfdc.VwAccountMap AM on AM.M5dbAccountId = SP.AccountId
inner join enum.ServiceStatus SS on SS.Id = SP.ServiceStatusId
inner join enum.Product P on P.Id = SP.ProductId
left join enum.OrderType OT on OT.Id = SP.OrderTypeId









