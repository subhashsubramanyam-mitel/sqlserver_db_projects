CREATE TABLE [vendor].[DLabs_GPMLineDetails] (
    [primary_id]        INT           NOT NULL,
    [ban]               VARCHAR (255) NULL,
    [bill_date]         VARCHAR (255) NULL,
    [profile]           VARCHAR (255) NULL,
    [wtn]               VARCHAR (255) NULL,
    [vendor_id]         INT           NULL,
    [client_id]         INT           NULL,
    [location_id]       INT           NULL,
    [product_id]        INT           NULL,
    [customer_names]    VARCHAR (255) NULL,
    [revenue]           VARCHAR (255) NULL,
    [revenue_usage]     VARCHAR (255) NULL,
    [revenue_total]     VARCHAR (255) NULL,
    [cost]              VARCHAR (255) NULL,
    [cost_corporate]    VARCHAR (255) NULL,
    [cost_usage]        VARCHAR (255) NULL,
    [cost_total]        VARCHAR (255) NULL,
    [gpm]               VARCHAR (255) NULL,
    [gpm_percent]       VARCHAR (255) NULL,
    [gpm_total]         VARCHAR (255) NULL,
    [gpm_total_percent] VARCHAR (255) NULL,
    [wtn_found]         VARCHAR (255) NULL,
    [is_corporate]      VARCHAR (255) NULL,
    [ignore_tn]         VARCHAR (255) NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160925-223123]
    ON [vendor].[DLabs_GPMLineDetails]([bill_date] ASC);

