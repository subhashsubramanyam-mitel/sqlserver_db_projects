create view invoice.VwMissingAccountMonthlyBillingStats as 
select F.AccountId, F.InvoiceMonth, 0 LastInvoiceId,0 NumProfiles,0 NumInvoices,0 NumManagedProfiles, G.ClusterId, G.PlatformTypeId
from (
select distinct M.AccountId, M.InvoiceMonth from invoice.MatVwIncrMRRNRR_EX_2_2018 M 
left join invoice.AccountMonthlyBillingStats AB on AB.AccountId = M.AccountId and AB.InvoiceMonth = M.InvoiceMonth
where   AB.AccountId is null 
) F 
left join (
	select AccountId, ClusterId, PlatformTypeId, ROW_NUMBER() over( partition by AccountId order by InvoiceMonth desc) RankNum
	from Invoice.AccountMonthlyBillingStats AB 
	) G on G.AccountId = F.AccountId and G.RankNum =1 

