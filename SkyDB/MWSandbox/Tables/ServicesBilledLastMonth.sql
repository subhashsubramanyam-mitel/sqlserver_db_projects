CREATE TABLE [MWSandbox].[ServicesBilledLastMonth] (
    [ServiceId] INT NOT NULL,
    [ProductId] INT NULL,
    CONSTRAINT [PK_ServicesBilledLastMonth] PRIMARY KEY CLUSTERED ([ServiceId] ASC)
);

