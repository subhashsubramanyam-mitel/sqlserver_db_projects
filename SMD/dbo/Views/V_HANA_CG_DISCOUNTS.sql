
  Create View V_HANA_CG_DISCOUNTS as 
  --MW for costguard discounts
  select * 
  from
  OPENQUERY (BWP,  'SELECT * FROM   SAPBWP."/BIC/AYCGDCNF2"' )