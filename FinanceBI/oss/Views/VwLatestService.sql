create VIEW oss.VwLatestService
AS
SELECT  * from 
(
	select 
	 ServiceId, ProductId, ServiceClassId, ServiceStatusId, LocationId, InvoiceServiceGroupId, AccountId, Name, IsAttachedToTN, 
	 CASE WHEN SP.TN is null THEN 'TnNotLinked' 
		  WHEN TP.TN is null THEN 'TnNotFound'
		  ELSE SP.TN END TN, 
	 InvoiceLabel, OrderTypeId, 
      WasInInitialOrder, OrderProjectManagerId, OrderCreatedByPersonId, MonthlyCharge, OneTimeCharge, DateBillingValidFrom, DateSvcClosed, DateSvcLiveActual, 
      DateSvcLiveScheduled, DateSvcModified, DateSvcCreated, DateBillingValidTo, IsBilledFirstTime, MonthSetupInvoiced, MonthLastInvoiced, MonthMRRFirstInvoiced, 
      MonthMRRLastInvoiced, DateMRRInvoicedTo, MonthCreditIssued, DateCreditedFrom, DateCreditedTo, CreatedByPersonId, ModifiedByPersonId, BillingStage, 
      DataIssueId,
	ROW_NUMBER() over (PARTITION by Serviceid Order by DateBillingValidFrom Desc) RankNum
	from oss.VwServiceProduct SP
	left join audit.mVwTnProfile TP on TP.TN = SP.TN
) foo
where RankNum = 1
