CREATE TABLE [crimsonEnum].[unit_of_measure] (
    [unit_of_measure_value] NVARCHAR (255) NOT NULL,
    [description]           NVARCHAR (255) NOT NULL,
    [time_measurement]      NVARCHAR (255) NOT NULL,
    [display_sequence]      INT            NULL,
    [is_default]            VARCHAR (5)    NOT NULL,
    [name]                  NVARCHAR (255) NULL
);

