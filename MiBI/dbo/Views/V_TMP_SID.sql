Create view V_TMP_SID as -- one time for sfdc Update
select M5DBServiceId, Status from
SKY_ASSETS where M5DBServiceId IN 
(
select m5db#service#id
  from TmpSids
)