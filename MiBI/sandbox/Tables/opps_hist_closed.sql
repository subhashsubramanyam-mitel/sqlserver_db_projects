CREATE TABLE [sandbox].[opps_hist_closed] (
    [total_contract_value_converted] NUMERIC (38, 2) NULL,
    [product_name]                   VARCHAR (255)   NULL,
    [opportunity_name]               VARCHAR (255)   NULL,
    [stage]                          VARCHAR (255)   NULL,
    [partner_account_name]           VARCHAR (255)   NULL,
    [type]                           VARCHAR (255)   NULL,
    [opportunity_owner]              VARCHAR (255)   NULL,
    [estimated_mrr]                  NUMERIC (38, 2) NULL,
    [term]                           INT             NULL,
    [close_date]                     DATETIME        NULL,
    [forecast_theatre]               VARCHAR (255)   NULL,
    [region]                         VARCHAR (255)   NULL,
    [territory_region]               VARCHAR (255)   NULL,
    [territory]                      VARCHAR (255)   NULL,
    [forecast_category]              VARCHAR (255)   NULL,
    [account_name]                   VARCHAR (255)   NULL,
    [products]                       VARCHAR (255)   NULL
);

