CREATE TABLE [Santana].[additionalUserData_cleaned] (
    [cluster]                   VARCHAR (MAX) NULL,
    [subscriber_id]             VARCHAR (MAX) NULL,
    [tn]                        BIGINT        NOT NULL,
    [cos_name]                  VARCHAR (MAX) NULL,
    [speed_line_config]         VARCHAR (MAX) NULL,
    [zero_out_component]        VARCHAR (MAX) NULL,
    [feature_screen]            VARCHAR (MAX) NULL,
    [feature_screen_script]     VARCHAR (MAX) NULL,
    [feature_cf_uncond]         VARCHAR (MAX) NULL,
    [feature_cf_noans]          VARCHAR (MAX) NULL,
    [feature_cf_noans_numrings] VARCHAR (MAX) NULL,
    [email_notification]        VARCHAR (MAX) NULL,
    [email_wav]                 VARCHAR (MAX) NULL,
    [dont_keep_vm]              VARCHAR (MAX) NULL,
    [vm_subscriber_ids]         VARCHAR (MAX) NULL,
    [att_id]                    VARCHAR (MAX) NULL,
    CONSTRAINT [PK_additionalUserData_cleaned] PRIMARY KEY CLUSTERED ([tn] ASC)
);

