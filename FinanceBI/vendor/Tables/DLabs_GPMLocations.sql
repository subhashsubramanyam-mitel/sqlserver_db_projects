CREATE TABLE [vendor].[DLabs_GPMLocations] (
    [primary_id]        INT           NOT NULL,
    [bill_month]        VARCHAR (255) NULL,
    [location_id]       INT           NULL,
    [location_name]     VARCHAR (255) NULL,
    [cost]              VARCHAR (255) NULL,
    [cost_corporate]    VARCHAR (255) NULL,
    [cost_total]        VARCHAR (255) NULL,
    [revenue]           VARCHAR (255) NULL,
    [gpm]               VARCHAR (255) NULL,
    [gpm_percent]       VARCHAR (255) NULL,
    [gpm_total]         VARCHAR (255) NULL,
    [gpm_total_percent] VARCHAR (255) NULL,
    [status]            VARCHAR (255) NULL,
    [lat]               VARCHAR (255) NULL,
    [lng]               VARCHAR (255) NULL,
    [blec]              VARCHAR (255) NULL
);

