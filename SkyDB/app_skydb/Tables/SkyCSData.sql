CREATE TABLE [app_skydb].[SkyCSData] (
    [tn]           VARCHAR (32) NOT NULL,
    [partition_id] VARCHAR (32) NOT NULL,
    [current_loc]  VARCHAR (32) NOT NULL,
    [device]       VARCHAR (32) NOT NULL,
    [customer]     VARCHAR (32) NOT NULL,
    PRIMARY KEY CLUSTERED ([tn] ASC)
);

