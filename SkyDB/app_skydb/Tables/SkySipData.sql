CREATE TABLE [app_skydb].[SkySipData] (
    [tn]           VARCHAR (32) NOT NULL,
    [partition_id] VARCHAR (32) NOT NULL,
    [ip_addr]      VARCHAR (32) NOT NULL,
    [device]       VARCHAR (32) NOT NULL,
    [customer]     VARCHAR (32) NOT NULL,
    PRIMARY KEY CLUSTERED ([tn] ASC)
);

