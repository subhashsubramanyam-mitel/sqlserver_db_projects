CREATE TABLE [dbo].[AX_CUST_ADDRESS] (
    [CREATEDDATETIME] DATETIME       NOT NULL,
    [CustomerId]      NVARCHAR (40)  NOT NULL,
    [STREET]          NVARCHAR (250) NOT NULL,
    [CITY]            NVARCHAR (100) NOT NULL,
    [STATE]           NVARCHAR (30)  NOT NULL,
    [ZIPCODE]         NVARCHAR (10)  NOT NULL,
    [CountryRegionId] NVARCHAR (30)  NOT NULL,
    [AxCode]          NVARCHAR (30)  NOT NULL,
    [Phone]           NVARCHAR (20)  NOT NULL,
    [Theatre]         NVARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [rn]              BIGINT         NULL
);

