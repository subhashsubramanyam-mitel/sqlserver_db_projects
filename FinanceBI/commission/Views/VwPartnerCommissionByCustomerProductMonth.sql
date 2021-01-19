





CREATE view [commission].[VwPartnerCommissionByCustomerProductMonth] as

select 
	'Cloud Commissions' CommissionType, -- Normal
	invoiceMonth,
	max(CreditingPartnerId) PartnerID, -- ASSUME maximum partner id is the correct one
	CreditingPartner		[Partner],
	clientname		Customer,
	[Description]   Product,
	SUM(CommissionableBillingsAmount)	NetBilled,
	SUM(PartnerCommissionAmount	)		SalesComp
	,null Notes
from Commission.History_PartnerCommission PC
left join Company.Location L on L.lichenlocationId = PC.lichenlocationid
left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
where PC.CreditingPartner is not null 
and PC.PartnerCommissionAmount <> 0.0
and PC.CommissionMonth > Intvl.TransitionMonth AND PC.CommissionMonth >= Intvl.Begin25Month
group by InvoiceMonth, CreditingPartner, clientname, [Description] 

union all

select 
	'Cloud Commissions' CommissionType, -- Normal
	invoiceMonth,
	max(CreditingPartnerId) PartnerID, -- ASSUME maximum partner id is the correct one
	CreditingPartner		[Partner],
	clientname		Customer,
	[Description]   Product,
	SUM(CommissionableBillingsAmount)	NetBilled,
	SUM(PartnerCommissionAmount	)		SalesComp
	,null Notes

from Commission.History_PartnerCommission_RPM PC
left join Company.Location L on L.lichenlocationId = PC.lichenlocationid
left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
where PC.CreditingPartner is not null 
and PC.PartnerCommissionAmount <> 0.0
and PC.CommissionMonth <= TransitionMonth and PC.CommissionMonth >= Begin25Month
group by InvoiceMonth, CreditingPartner, clientname, [Description] 

union all

select 
	'Adjustments' CommissionType, -- Ajustment
      DateAdd(month, -1, [PCMonth]) InvoiceMonth
	  ,max([CreditingPartnerID]) PartnerID
      ,[CreditingPartner] Partner
	  ,null Customer
	  ,HA.Type Product
      ,SUM([NetBilled]) NetBilled
      --,[Gross Comm] SalesComp
      ,SUM([SalesComm]) SalesComp
	  , HA.Notes

  FROM [commission].[History_Adjustment] HA
 left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
 where HA.[PCMonth] > TransitionMonth and HA.[PCMonth] >= Begin25Month
 group by  DateAdd(month, -1, [PCMonth]), [CreditingPartner], HA.Type, HA.Notes 

union all

select 
	'Adjustments' CommissionType, -- Ajustment
      DateAdd(month, -1, [PC Month]) InvoiceMonth
	  ,max([Crediting Partner ID]) PartnerID
      ,[Crediting Partner] Partner
	  ,null Customer
	  ,HA.Type Product
      ,SUM([Net Billed]) NetBilled
      --,[Gross Comm] SalesComp
      ,SUM([Sales Comm]) SalesComp
	  , HA.Notes
  FROM [commission].[History_Adjustment_RPM] HA
 left join ( select 
					DateAdd(month, -125, dbo.UfnFirstOfMonth(getdate())) Begin25Month,
					'2016-04-01' TransitionMonth 
			)  Intvl on 1=1
  where HA.[PC Month] <= TransitionMonth and HA.[PC Month] >= Begin25Month
   group by  DateAdd(month, -1, [PC Month]), [Crediting Partner], HA.Type, HA.Notes






