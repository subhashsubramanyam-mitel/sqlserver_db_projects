CREATE TABLE [crimsonEnum].[country_code] (
    [country_code_value] NVARCHAR (255) NOT NULL,
    [name]               NVARCHAR (255) NULL,
    [description]        NVARCHAR (255) NOT NULL,
    [calling_code]       NVARCHAR (255) NOT NULL,
    [display_sequence]   INT            NULL,
    [is_default]         VARCHAR (5)    NOT NULL,
    [hidden]             VARCHAR (5)    NOT NULL,
    [ndd_code]           NVARCHAR (255) NULL,
    [idd_code]           NVARCHAR (255) NULL
);

