CREATE TABLE [oss].[ServiceSettings] (
    [ServiceId]         INT           NOT NULL,
    [DateOrdered]       DATETIME2 (4) NULL,
    [VendorOrderNumber] NVARCHAR (50) NULL,
    [Total #s to LNP]   INT           NULL,
    [DateCreated]       DATETIME2 (4) DEFAULT (getdate()) NULL,
    [CreatedBy]         VARCHAR (30)  DEFAULT (suser_sname()) NULL,
    [DateModified]      DATETIME2 (4) DEFAULT (getdate()) NULL,
    [ModifiedBy]        VARCHAR (30)  DEFAULT (suser_sname()) NULL,
    [DateRequested]     DATETIME      NULL,
    [FOCDate]           DATETIME      NULL,
    CONSTRAINT [PK_ServiceSettings] PRIMARY KEY CLUSTERED ([ServiceId] ASC)
);

