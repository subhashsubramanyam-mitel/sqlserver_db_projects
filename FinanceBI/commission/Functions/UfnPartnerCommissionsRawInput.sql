
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2015-03-06
-- Description:	Return RAW input to Partner Commissions
-- Change Log: 
-- =============================================
CREATE FUNCTION commission.[UfnPartnerCommissionsRawInput] 
(	
	-- Add the parameters for the function here
	@FirstOfBillingMonth  Date
)
RETURNS TABLE 
AS
RETURN 
(
SELECT  12*(YEAR(@FirstOfBillingMonth)-2000) + Month(@FirstOfBillingMonth) CenturyMonth, 
		p.lichenpartnerid,c.Name as Partnername,a.LichenAccountId, a.IsBillable [Ac isBillable],
		12*(YEAR(@FirstOfBillingMonth)-2000) + Month(@FirstOfBillingMonth) - AB.MonthFirstBilled +1 as InvoiceCount,
		ca.name as clientname, l.lichenlocationid, li.LocationId, l.isCommissionable, 
      addr.Address,addr.City,stp.CodeAlpha,addr.ZipCode,
      ls.ServiceId,sc.LichenClassName,lit.name as chargetype,li.charge, li.Description,
      li.DatePeriodStart, li.DatePeriodEnd
from M5DB.m5db.dbo.billing_Invoice i
inner join M5DB.m5db.dbo.billing_InvoiceLineItem li on li.InvoiceId = i.Id
left join M5DB.m5db.dbo.billing_InvoiceService ls on ls.InvoiceLineItemId = li.Id
left join  M5DB.m5db.dbo.billing_InvoiceLineItemType lit on lit.Id = li.LineItemTypeId
left join M5DB.m5db.dbo.service_Service ss on ss.Id = ls.ServiceId
left join M5DB.m5db.dbo.Location l on l.Id = li.LocationId
left join M5DB.m5db.dbo.Address addr on addr.Id = l.AddressId
left join M5DB.m5db.dbo.StateProvince stp on stp.Id = addr.StateId
left join M5DB.m5db.dbo.service_ServiceClass sc on sc.Id = ss.ServiceClassId
left join M5DB.m5db.dbo.Account a on a.Id = i.AccountId
left join M5DB.m5db.dbo.Company ca on ca.Id = a.CompanyId
left join M5DB.m5db.dbo.[Partner] p on p.id = a.partnerId
left join M5DB.m5db.dbo.Account pa on pa.Id = p.accountid
left join M5DB.m5db.dbo.Company c on c.Id = pa.CompanyId
left join (
	select IG.AccountId, 
	12*(YEAR(dbo.UfnFirstOfMonth(MIN(I.DateGenerated))) - 2000)
		+ Month(dbo.UfnFirstOfMonth(MIN(I.DateGenerated))) MonthFirstBilled
	  
	from M5DB.m5db.dbo.billing_Invoice I
	inner join M5DB.m5db.dbo.billing_InvoiceGroup IG on IG.Id = I.InvoiceGroupId
	group by IG.AccountId
	) AB on AB.AccountId = i.AccountId 
where i.DateGenerated >=dbo.UfnLocalTimeToUTC(@FirstOfBillingMonth)
	 and i.DateGenerated < dbo.UfnLocalTimeToUTC(DateAdd(month,1,@FirstOfBillingMonth))
      and LichenPartnerId is not null
)

