
CREATE View [Gainsight].[VwMRRDelta] as
-- MW 10192018 View for Gainsight MRRD extraction
SELECT 
       [AccountId]
      ,[LocationId]
      ,[OrderProjectManagerId]
      ,[OrderCreatedByPersonId]
      ,[orderedById]
      ,[OrderSalesPersonId]
      ,[Ac Team]
      ,[AccountManagerId]
      ,[MRR Category]
      ,[MRR Prev]
      ,[MRR Expected]
      ,[MRR Delta]
      ,[NRR]
      ,[CurrencyCode]
      ,[MRR Prev LC]
      ,[MRR Expected LC]
      ,[MRR Delta LC]
      ,[NRR LC]
      ,[InvoiceDay]
      ,[InvoiceMonth]
      ,[ServiceId]
      ,[ProductId]
      ,[OrderId]
      ,[OrderTypeId]
      ,[Order Date Created]
      ,[ServiceClassId]
      ,[DateSvcLiveActual]
      ,[ServiceStatusId]
      ,[BillingStage]
      ,[BookToBillDays]
      ,[Quantity]
      ,[DeltaQuantity]
      ,[QMRR]
	  , ROW_NUMBER() over (order by ServiceId) as RowN
 -- FROM [invoice].[MatVwIncrMRRNRR_EX_Current]
	FROM [invoice].[MatVwIncrMRRNRR_EX_2_2018]
	where InvoiceMonth =    dbo.UfnFirstOfMonth(getdate())
 

 
