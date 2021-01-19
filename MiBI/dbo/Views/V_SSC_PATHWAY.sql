Create View V_SSC_PATHWAY as
-- MW 20180801 customers in pathway program for ssc customer list.
select Distinct CustomerId, 'Yes' as Pathway from CUSTOMER_ASSETS (nolock)
where SKU in
(
'10134',
'10142',
'10144',
'10168',
'10242',
'50060',
'50061',
'60002',
'60007',
'60008',
'60009'
)