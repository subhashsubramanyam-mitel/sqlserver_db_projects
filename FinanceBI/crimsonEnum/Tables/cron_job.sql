CREATE TABLE [crimsonEnum].[cron_job] (
    [cron_job_value]   NVARCHAR (255) NOT NULL,
    [name]             NVARCHAR (255) NOT NULL,
    [description]      NVARCHAR (255) NULL,
    [is_default]       VARCHAR (5)    NOT NULL,
    [display_sequence] INT            NOT NULL
);

