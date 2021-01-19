
CREATE view [commission].[VwPrevMonthCommissionByPartner] as
Select D.CommMonth LastCommissionMonth, PC.CreditingPartner, PC.CreditingPartnerId, SUM(CommissionableBillingsAmount) NetBilled, SUM(PartnerCommissionAmount) NetPC 
from commission.History_PartnerCommission PC
inner join (select DateAdd(month,-1, Max(CommissionMonth)) CommMonth from commission.History_PartnerCommission ) D on D.CommMonth = PC.CommissionMonth
where coalesce(PC.CreditingPartnerId,0) <> 0
group by D.CommMonth, PC.CreditingPartner, PC.CreditingPartnerId
