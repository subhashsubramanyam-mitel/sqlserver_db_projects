


CREATE view [PCSandbox].[VwComparePartnerAccount_PC] as
select * from 
( select *, ROW_NUMBER() over ( partition by IT_LichenAccountId order by IT_CreditingPartner ) IT_rank_num
	from PCSandbox.VwPartnerAccount_PC_IT 
	) IT
full join (
	select *, ROW_NUMBER() over ( partition by Fin_LichenAccountId order by Fin_CreditingPartner ) FIN_rank_num
	from
	PCSandbox.VwPartnerAccount_PC_Fin  where coalesce(Fin_Amt,0) <> 0
	) fin on IT.IT_LichenAccountId = Fin.Fin_LichenAccountid and IT.IT_rank_num = Fin.FIN_rank_num



