CREATE proc [analytics].[sp_upd_ucaas_opps_all_closed] 

AS

/* insert joined data from historical and cq table				*/

INSERT INTO analytics.ucaas_opps_all_closed (

		solution_of_interest,
		total_contract_value_converted,
		product_of_interest,
		--product_name,
		opportunity_name,
		stage,
		partner_type,
		partner_account_name,
		sub_agent_account,
		type,
		sub_type,
		opportunity_owner,
		owner_role,
		estimated_mrr,
		term,
		forecast_theatre,
		region,
		sub_region,
		territory,
		isr_region,
		forecast_category,
		opportunity_id,
		--blue_name,
		primary_opp_id_orange,
		secondary_opp_id_orange,
		--opp_id_blue,
		num_of_cloud_profiles,
		account_name,
		products,
		close_date,
		close_month,
		create_date,
		created_by,
		last_modified_date,
		last_modified_by,
		extract_date
		)

/* Select statement joining historical and CQ data				*/
SELECT 

		solution_of_interest,
		total_contract_value_converted,
		product_of_interest,
		--product_name,
		opportunity_name,
		stage,
		partner_type,
		partner_account_name,
		sub_agent_account,
		type,
		sub_type,
		opportunity_owner,
		owner_role,
		estimated_mrr,
		term,
		forecast_theatre,
		region,
		sub_region,
		territory,
		isr_region,
		forecast_category,
		opportunity_id,
		--blue_name,
		primary_opp_id_orange,
		secondary_opp_id_orange,
		--opp_id_blue,
		num_of_cloud_profiles,
		account_name,
		products,
		close_date,
		close_month,
		create_date,
		created_by,
		last_modified_date,
		last_modified_by,
		getdate() as extract_date

from analytics.ucaas_opps_hist_closed

UNION ALL

SELECT

		solution_of_interest,
		total_contract_value_converted,
		product_of_interest,
		--product_name,
		opportunity_name,
		stage,
		partner_type,
		partner_account_name,
		sub_agent_account,
		type,
		sub_type,
		opportunity_owner,
		owner_role,
		estimated_mrr,
		term,
		forecast_theatre,
		region,
		sub_region,
		territory,
		isr_region,
		forecast_category,
		opportunity_id,
		--blue_name,
		primary_opp_id_orange,
		secondary_opp_id_orange,
		--opp_id_blue,
		num_of_cloud_profiles,
		account_name,
		products,
		close_date,
		close_month,
		create_date,
		created_by,
		last_modified_date,
		last_modified_by,
		getdate() as extract_date

from analytics.vw_ucaas_opps_cy_closed;

