CREATE TABLE [company].[InvoiceServiceGroup] (
    [Id]             INT            NOT NULL,
    [Name]           NVARCHAR (128) NULL,
    [InvoiceGroupId] INT            NULL,
    [IsDeleted]      BIT            DEFAULT ((0)) NULL,
    CONSTRAINT [PK_InvoiceServiceGroup] PRIMARY KEY CLUSTERED ([Id] ASC)
);

