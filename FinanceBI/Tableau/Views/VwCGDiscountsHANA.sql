
create view tableau.VwCGDiscountsHANA as
-- MW 04282020 for xfr discounts back to costguard db

select * from SMD.SMD.dbo.V_HANA_CG_DISCOUNTS
