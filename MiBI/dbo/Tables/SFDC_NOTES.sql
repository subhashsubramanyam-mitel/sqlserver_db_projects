CREATE TABLE [dbo].[SFDC_NOTES] (
    [Created]      DATETIME      NULL,
    [Id]           VARCHAR (25)  NOT NULL,
    [Title]        VARCHAR (250) NULL,
    [ModifiedBy]   VARCHAR (150) NULL,
    [ModifiedDate] DATETIME      NULL,
    [ParentId]     VARCHAR (25)  NULL,
    CONSTRAINT [PK_SFDC_NOTES] PRIMARY KEY CLUSTERED ([Id] ASC)
);

