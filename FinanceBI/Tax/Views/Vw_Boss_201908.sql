create view Tax.Vw_Boss_201908 as
select 'Prod' Env, P.* 
from Tax.Import_Prod_Boss_201908 P
union all
select 'Audit' Env, A.*
from Tax.Import_Audit_Boss_201908 A