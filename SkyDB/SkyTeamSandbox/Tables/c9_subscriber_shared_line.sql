CREATE TABLE [SkyTeamSandbox].[c9_subscriber_shared_line] (
    [partition_id]      INT          DEFAULT ((0)) NOT NULL,
    [pri_subscriber_id] INT          DEFAULT ((0)) NOT NULL,
    [pri_line_id]       INT          DEFAULT ((0)) NOT NULL,
    [pri_label]         VARCHAR (16) DEFAULT ('') NOT NULL,
    [sec_subscriber_id] INT          DEFAULT ((0)) NOT NULL,
    [sec_line_id]       INT          DEFAULT ((0)) NOT NULL,
    [sec_label]         VARCHAR (16) DEFAULT ('') NOT NULL,
    [sec_ring]          INT          DEFAULT ((0)) NOT NULL,
    [sec_alert]         INT          DEFAULT ((0)) NOT NULL,
    [sec_dial]          INT          DEFAULT ((1)) NOT NULL,
    [feature_ring]      TINYINT      DEFAULT ((0)) NOT NULL
);

