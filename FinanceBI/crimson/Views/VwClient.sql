

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE View [crimson].[VwClient] as 
SELECT  C.[business_entity_id]
		,BE.legal_entity_name Client
      ,[is_reseller]
      ,[is_tax_exempt]
      ,[account_type_value]
      ,coalesce([disable_over_limit],0)[disable_over_limit]
      ,coalesce([credit_limit],0)[credit_limit]
      ,coalesce([warning_credit_limit],0)[warning_credit_limit]
      ,coalesce([last_bill_amount],0)[last_bill_amount]
      ,coalesce([account_balance],0)[account_balance]
      ,coalesce([auto_recharge_amount],0)[auto_recharge_amount]
      --[create_user_id]
      --,[create_timestamp]
      --,[last_mod_user_id]
      --,[last_mod_timestamp]
      ,[account_number]
      ,coalesce([unbilled_charges],0) [unbilled_charges]
      ,[notified_near_limit_timestamp]
      ,[notified_over_limit_timestamp]
      ,[customer_profile_id]
      ,[account_status_value]
      --,[auto_load_enabled]
      --,[auto_load_start_timestamp]
      --,[auto_load_end_timestamp]
      --,[auto_load_threshold_amount]
      --,[auto_load_target_balance]
      ,[is_taxable]
      ,[tax_exemption_code]
      ,[generate_invoice_detail]
      ,[summary_invoice_template_id]
      ,[detail_invoice_template_id]
      ,[credit_limit_increase]
      ,[credit_limit_increase_expire_timestamp]
      ,[account_status_reason_value]
      ,[account_status_timestamp]
      ,[is_test_account]
      ,[currency_value]
	  ,coalesce(PA.city, MA.city, BA.city) City
	  ,coalesce(PA.state_abbrev, MA.state_abbrev, BA.state_abbrev) StateAbbrev
	  ,coalesce(PA.zip, MA.zip, BA.zip) Zipcode
	  ,coalesce(PA.country_code_value, MA.country_code_value, BA.country_code_value) CountryCode
	  ,AA.[ST AX Code]
	  ,AA.[ST Territory]
	  ,AA.RVP
	  ,AA.PartnerID
	  ,AA.PartnerName
  FROM [crimson].[Client] C
  inner join FinanceBI.crimson.BusinessEntity BE on BE.business_entity_id = C.business_entity_id
  left join FinanceBI.crimson.AccountAttr AA on AA.[Account Number] = C.account_number
  left join FinanceBI.crimson.Location L on L.location_id = BE.primary_location_id
  left join FinanceBI.crimson.Address PA on PA.address_id = L.physical_address_id 
  left join FinanceBI.crimson.Address MA on MA.address_id = L.mail_address_id 
  left join FinanceBI.crimson.Address BA on BA.address_id = L.bill_address_id 

