CREATE TABLE [crimsonEnum].[time_zone] (
    [time_zone_value]  NVARCHAR (255) NOT NULL,
    [description]      NVARCHAR (255) NOT NULL,
    [abbreviation]     NVARCHAR (255) NOT NULL,
    [utc_offset]       INT            NOT NULL,
    [is_default]       VARCHAR (5)    NULL,
    [display_sequence] INT            NULL
);

