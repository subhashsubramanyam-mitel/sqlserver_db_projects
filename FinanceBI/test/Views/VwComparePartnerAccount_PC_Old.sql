

Create view [test].[VwComparePartnerAccount_PC_Old] as
select * from test.VwPartnerAccount_PC_IT IT
full join test.VwPartnerAccount_PC_Fin Fin on IT.IT_LichenAccountId = Fin.Fin_LichenAccountid
