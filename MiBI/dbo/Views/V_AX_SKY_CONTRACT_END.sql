  Create View V_AX_SKY_CONTRACT_END as
  -- MW 08172015  For SKY contract and date to AX integration
  select a.Created from 
  CONTRACT a inner join
  CUSTOMERS b on a.AccountId = b.SfdcId
  where b.CustomerType in ('CLOUD', 'Legacy Cloud')
  AND b.Type = 'Customer (Installed)'
  AND a.IsCurrent = 'Yes'
