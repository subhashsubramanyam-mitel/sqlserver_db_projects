CREATE TABLE [vendor].[DLabs_GPMClients] (
    [primary_id]        INT           NOT NULL,
    [bill_month]        VARCHAR (255) NULL,
    [client_id]         INT           NULL,
    [client_name]       VARCHAR (255) NULL,
    [cost]              VARCHAR (255) NULL,
    [cost_corporate]    VARCHAR (255) NULL,
    [cost_total]        VARCHAR (255) NULL,
    [revenue]           VARCHAR (255) NULL,
    [gpm]               VARCHAR (255) NULL,
    [gpm_percent]       VARCHAR (255) NULL,
    [gpm_total]         VARCHAR (255) NULL,
    [gpm_total_percent] VARCHAR (255) NULL
);

