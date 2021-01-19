CREATE TABLE [dbo].[AX_CPEaaS_LicenseBreakdown] (
    [SalesId]            NVARCHAR (255) NULL,
    [CustomerName]       NVARCHAR (255) NULL,
    [State]              NVARCHAR (255) NULL,
    [AXID]               FLOAT (53)     NULL,
    [FirstOfPartnerName] FLOAT (53)     NULL,
    [LicenseTYpe]        NVARCHAR (255) NULL,
    [sku]                FLOAT (53)     NULL,
    [SumOfUAL]           FLOAT (53)     NULL,
    [Revenues]           FLOAT (53)     NULL,
    [StartDate]          DATETIME       NULL,
    [EndDate]            DATETIME       NULL
);

