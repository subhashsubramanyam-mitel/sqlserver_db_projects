




/****** Script for SelectTopNRows command from SSMS  ******/

--select count(*) from commission.VwSfdcExport
--94370
--select * from commission.VwSfdcExport

CREATE view [commission].[VwSfdcExport] as 
-- MW 10272020 For export to SFDC
 

 
select

		 convert(varchar(15),isnull(a.PartnerId,1)) + '-'+
							isnull(convert(varchar(15),a.PortalAccountId),'')+
							convert(char(10),a.CommissionMonth,110)+
							convert(char(10),a.InvoiceMonth,110)+
							isnull(a.CommissionType,'')+isnull(a.Product,'') +'-'+
							cast(
							ROW_NUMBER() over (partition by
							convert(varchar(15),a.PartnerId) + '-'+
							isnull(convert(varchar(15),a.PortalAccountId),'')+
							convert(char(10),a.CommissionMonth,110)+
							convert(char(10),a.InvoiceMonth,110)+
							isnull(a.CommissionType,'')+isnull(a.Product,'') order by a.Notes) as Varchar(5) )
			as SourceId__c,
		a.CommissionMonth as Commission_Month__c, 
		a.InvoiceMonth as Invoice_Month__c, 
		a.Customer as Customer_Name__c, 
		convert(varchar(15),isnull(a.PartnerId,1))+'Partner'  as [Partner__r.LMSExternalID__c], 
		--SubAgentId, 
		a.SubAgent as Sub_Agent_Name__c, 
		a.RepName as Rep_Name__c, 
		a.Product as Product_Name__c, 
		a.SalesCompRate as Sales_Comp_Rate__c, 
		a.CommissionType as  Commission_Type__c, 
		a.Notes as Notes__c, 
		--PortalAccountId,
		a.PaymentPlan as Payment_Plan__c,
		sum(a.Quantity) As Quantity__c, 
		sum(a.NetBilled) as Net_Billed__c, 
		sum(a.SalesComp) as Sales_Comp__c 
/*
		 convert(varchar(15),isnull(PartnerId,1)) + '-'+
							isnull(convert(varchar(15),PortalAccountId),'')+
							convert(char(10),CommissionMonth,110)+
							convert(char(10),InvoiceMonth,110)+
							isnull(CommissionType,'')+isnull(Product,'') +'-'+
							cast(
							ROW_NUMBER() over (partition by
							convert(varchar(15),PartnerId) + '-'+
							isnull(convert(varchar(15),PortalAccountId),'')+
							convert(char(10),CommissionMonth,110)+
							convert(char(10),InvoiceMonth,110)+
							isnull(CommissionType,'')+isnull(Product,'') order by Notes) as Varchar(5) )
			as RecordId,
		CommissionMonth, 
		InvoiceMonth, 
		Customer, 
		convert(varchar(15),isnull(PartnerId,1))+'Partner'  as PartnerId, 
		SubAgentId, 
		SubAgent, 
		RepName, 
		Product, 
		SalesCompRate, 
		CommissionType, 
		Notes, 
		PortalAccountId,
		PaymentPlan,
		sum(Quantity) As Quantity, 
		sum(NetBilled) as NetBilled, 
		sum(SalesComp) as SalesComp 
*/
FROM            commission.mVwPartnerCommissionCompact AS a inner join
				-- Make sure account is in SFDC
		(select distinct SAPNumber from sfdc.Account2 where isnumeric(SAPNumber) = 1) b on a.PartnerId = b.SAPNumber
 WHERE        (CommissionMonth >= '2020-01-01')
group by 
					convert(varchar(15),isnull(a.PartnerId,1)) + '-'+
							isnull(convert(varchar(15),a.PortalAccountId),'')+
							convert(char(10),a.CommissionMonth,110)+
							convert(char(10),a.InvoiceMonth,110)+
							isnull(a.CommissionType,'')+isnull(a.Product,'')  ,
					a.CommissionMonth, 
					a.InvoiceMonth, 
					a.Customer, 
					a.PartnerId   , 
					a.SubAgentId, 
					a.SubAgent, 
					a.RepName, 
					a.Product, 
					a.SalesCompRate, 
					a.CommissionType, 
					a.Notes, 
					a.PortalAccountId,
					a.PaymentPlan


/*  
SELECT        
		CommissionMonth, 
		InvoiceMonth, 
		Customer, 
		PartnerId, 
		SubAgentId, 
		SubAgent, 
		RepName, 
		Product, 
		Quantity, 
		NetBilled, 
		SalesComp, 
		SalesCompRate, 
		CommissionType, 
		Notes, 
		PortalAccountId

FROM            commission.mVwPartnerCommissionCompact AS a
WHERE        (CommissionMonth = '2020-09-01')
*/

