create view support.vw_Cases as 
select CaseNumber,ID,CreatedDate,CaseOwnerRole,CaseOwner,Theater,AccountName,AccountTeam
from Cases (nolock) where (CreatedDate>='2019-01-01' and CreatedDate<= getdate())
and CaseOwnerRole in ('CC Services Manila','CC Services USA','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada') and CustomerType = 'CLOUD'
