﻿


Create View [PCBI].[VwPartnerCommissionReview_Temp] as

select 
	'Cloud Commissions' CommissionType -- Normal
	,RTRIM(PC.Region) Region  -->
	,PC.PCMonth
	,[dbo].UfnGlobalID(RTRIM(PC.Region), PC.AccountID) AccountGUID
	,AccountID
	,coalesce(dbo.UfnRemoveUnprintableChar(PC.ClientName),'') ClientName
	,coalesce(PC.PaymentPlan,'') PaymentPlan
	,[dbo].UfnGlobalID(RTRIM(PC.Region), PC.LocationId) LocationGUID   --
	,LocationID
	,Case when coalesce(SubAgentId,'')='' and coalesce(SubAgent,'')='' then null else CONCAT(RTRIM(Region), '-', SubAgentId,':',SubAgent) end SubAgentGUID 
	,coalesce(SubAgentId,'') SubAgentId
	,coalesce(dbo.UfnRemoveUnprintableChar(SubAgent),'')SubAgent
	,coalesce(dbo.UfnRemoveUnprintableChar(PC.RepName),'') RepName
	,CreditingPartnerId 
	,coalesce(dbo.UfnRemoveUnprintableChar(CreditingPartner),'') CreditingPartner
	,[dbo].UfnGlobalID(RTRIM(PC.Region), ProductId ) ProductGUID
	,ProductId
	,coalesce(dbo.UfnRemoveUnprintableChar(ProductName),'')ProductName
	,[Description] 
	,CurrencyCode
	,coalesce(ChargeType,'') ChargeType
	,[Charge LC]
	,Charge
	,[CommissionableBillingsAmount LC]
	,CommissionableBillingsAmount
	,[PartnerCommissionAmount LC] [SalesComm LC]
	,[PartnerCommissionAmount] SalesComm
from  commission.History_PartnerCommission PC
where PCMonth = '2019-04-01'

union all
select 
	'Adjustments' CommissionType -- Ajustment
	,RTRIM(HA.Region) Region -->
     , [PCMonth]
	,[dbo].UfnGlobalID(RTRIM(HA.Region), HA.AccountID) AccountGUID
	,AccountID
	,coalesce(dbo.UfnRemoveUnprintableChar(HA.ClientName),'') ClientName
	,coalesce(HA.PaymentPlan,'') PaymentPlan
	 ,null LocationGUID  -->
	 ,null LocationID
	,Case when coalesce(SubAgentId,'')='' and coalesce(SubAgent,'')='' then null else CONCAT(Region, '-', SubAgentId,':',SubAgent) end SubAgentGUID  -->
	,coalesce(SubAgentId,'') SubAgentId
	,coalesce(dbo.UfnRemoveUnprintableChar(SubAgent),'')SubAgent
	 ,coalesce(dbo.UfnRemoveUnprintableChar(HA.RepName),'') RepName
	 ,[CreditingPartnerID] 
	,coalesce(dbo.UfnRemoveUnprintableChar(CreditingPartner),'') CreditingPartner
	 ,concat(format(PCMonth,'yyyyMM'),'-',Id) AdjProductGUID
	 ,Id AdjId
	 ,coalesce(dbo.UfnRemoveUnprintableChar(HA.Type), '') [AdjProductName]
	 ,HA.Notes [Description]
	,CurrencyCode
	,'Adj' ChargeType
	,NetBilled_LC
	,NetBilled
	,CommissionableBillingsAmount_LC
	,CommissionableBillingsAmount
	,SalesComm_LC
	,SalesComm
 FROM commission.History_Adjustment HA
where PCMonth = '2019-04-01' 






