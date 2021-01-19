

CREATE view [commission].[VwAcRate] as
Select 
	AR.PCMonth PCMonth,
	A.Id AccountId,
	A.Name Client,
	AR.[Account CommRate] CommissionRate
from company.Account A
inner join company.Partner P on P.Id = A.PartnerId
left join commission.History_AccountRate AR on AR.LichenAccountID = A.LichenAccountId
where A.PartnerId is not null

