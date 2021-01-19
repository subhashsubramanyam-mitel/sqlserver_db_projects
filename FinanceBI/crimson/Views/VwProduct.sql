

CREATE view [crimson].[VwProduct]  
as SELECT 
P.product_id,
P.product_name,
P.billing_type_value,
P.charging_model_value,
coalesce(P.default_price,0) default_price,
P.product_category_id,
P.unit_of_measure_value
      ,P.[contract_required]
      ,P.[is_billable]
      ,P.[can_discount]
      ,coalesce(P.[billing_minimum], 0) [billing_minimum]
      ,coalesce(P.[billing_increment], 0) [billing_increment]
      ,P.[bill_minimum_unit_of_measure_value]
      ,P.[bill_increment_unit_of_measure_value]
      ,P.[available_for_sale]
      ,P.[uses_rate_deck_pricing]
       ,P.[product_uuid]
      ,P.[bill_timing_value]
      ,P.[sf_record_id]
      ,P.[default_product_rate_deck_id]
      ,P.[is_lease]
      ,P.[cost]
      ,P.[bill_quantity_as_minimum]
      ,coalesce(P.[includes_usage],0) [includes_usage]
      ,coalesce(P.[included_usage_per_unit], 0) [included_usage_per_unit]
      ,coalesce(P.[includes_unlimited_usage], 0) [includes_unlimited_usage]
      ,P.[is_vendor_product]
      ,P.[is_wholesale]
,PC.description [prod_category]
,PC.uses_components [prod_category_uses_components]
,PSC.ax_account
,PSC.ax_account_description
,PSC.ax_profit_center
,PSC.ax_profit_center_description
,PSC.charge_category
,PSC.product_shoretel_category_id
FROM crimson.Product P
left join crimson.ProductCategory PC on PC.product_category_id = P.product_category_id
left join crimson.ProductShoretelCategory PSC on PSC.product_id = P.product_id



