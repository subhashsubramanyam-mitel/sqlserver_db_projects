CREATE TABLE [ALSandbox].[KPI_SvcAvail] (
    [ServiceMonth]  DATE           NOT NULL,
    [Direction]     VARCHAR (20)   NOT NULL,
    [NumComponents] INT            NULL,
    [ComponentType] VARCHAR (20)   NULL,
    [MinDown]       INT            NULL,
    [Method]        VARCHAR (50)   NULL,
    [Uptime]        DECIMAL (6, 4) NULL,
    CONSTRAINT [PK_SvcAvail] PRIMARY KEY CLUSTERED ([ServiceMonth] ASC, [Direction] ASC)
);

