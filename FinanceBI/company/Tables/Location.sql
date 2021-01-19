CREATE TABLE [company].[Location] (
    [Id]               INT            NOT NULL,
    [AccountId]        INT            NOT NULL,
    [StateProvinceId]  INT            NOT NULL,
    [TimeZoneId]       INT            NULL,
    [Name]             NVARCHAR (200) NULL,
    [City]             NVARCHAR (100) NOT NULL,
    [Address]          NVARCHAR (100) NOT NULL,
    [Address2]         NVARCHAR (100) NULL,
    [ZipCode]          NVARCHAR (50)  NOT NULL,
    [CountryId]        INT            NOT NULL,
    [InvoiceGroupId]   INT            NULL,
    [DateLiveForecast] DATE           NULL,
    [LichenLocationId] INT            CONSTRAINT [DF_Location_LichenLocationId] DEFAULT ((-1)) NULL,
    [IsCommissionable] BIT            CONSTRAINT [DF_Location_IsCommissionable] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_CompanyLocation] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Location_Country] FOREIGN KEY ([CountryId]) REFERENCES [enum].[Country] ([Id]),
    CONSTRAINT [FK_Location_InvoiceGroup] FOREIGN KEY ([InvoiceGroupId]) REFERENCES [company].[InvoiceGroup] ([Id]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Location_LocationAttr] FOREIGN KEY ([Id]) REFERENCES [company].[LocationAttr] ([LocationId]),
    CONSTRAINT [FK_Location_StateProvince] FOREIGN KEY ([StateProvinceId]) REFERENCES [enum].[StateProvince] ([Id]),
    CONSTRAINT [FK_Location_TimeZone] FOREIGN KEY ([TimeZoneId]) REFERENCES [enum].[TimeZone] ([Id]),
    CONSTRAINT [FK_LocationAccount] FOREIGN KEY ([AccountId]) REFERENCES [company].[Account] ([Id])
);


GO
ALTER TABLE [company].[Location] NOCHECK CONSTRAINT [FK_Location_InvoiceGroup];


GO
ALTER TABLE [company].[Location] NOCHECK CONSTRAINT [FK_Location_LocationAttr];


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170521-044801]
    ON [company].[Location]([LichenLocationId] ASC);

