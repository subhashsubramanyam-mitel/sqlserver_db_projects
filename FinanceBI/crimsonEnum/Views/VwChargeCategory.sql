create view crimsonEnum.VwChargeCategory as
select 'MRR' as ChargeCategory
union
select 'PRORATES'
union
select distinct charge_category from crimson.ProductShoretelCategory