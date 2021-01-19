CREATE TABLE [dbo].[SKY_TRKNUM_TRK] (
    [CreatedDate]         DATETIME     CONSTRAINT [DF_SKY_TRKNUM_TRK_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [SfdcId]              VARCHAR (50) NOT NULL,
    [PurchOrderFormNum]   VARCHAR (50) NULL,
    [SemPostingOrderType] VARCHAR (50) NULL,
    [TrackingNumber]      VARCHAR (50) NULL,
    [Status]              VARCHAR (50) CONSTRAINT [DF_SKY_TRKNUM_TRK_Status] DEFAULT ('N') NULL,
    [Error]               TEXT         NULL,
    CONSTRAINT [PK_SKY_TRKNUM_TRK] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);

