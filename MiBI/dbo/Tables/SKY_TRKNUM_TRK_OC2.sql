CREATE TABLE [dbo].[SKY_TRKNUM_TRK_OC2] (
    [CreatedDate]         DATETIME     CONSTRAINT [DF_SKY_TRKNUM_TRK_OC2_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [SfdcId]              VARCHAR (50) NOT NULL,
    [PurchOrderFormNum]   VARCHAR (50) NULL,
    [SemPostingOrderType] VARCHAR (50) NULL,
    [TrackingNumber]      VARCHAR (50) NULL,
    [Status]              VARCHAR (50) NULL,
    [Error]               TEXT         NULL,
    CONSTRAINT [PK_SKY_TRKNUM_TRK_OC2] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);

