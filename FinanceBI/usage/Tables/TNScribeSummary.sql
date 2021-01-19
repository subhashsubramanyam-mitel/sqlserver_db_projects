CREATE TABLE [usage].[TNScribeSummary] (
    [source]          VARCHAR (6)    NOT NULL,
    [ServiceMonth]    DATE           NULL,
    [InvoiceMonth]    DATE           NULL,
    [Client]          NVARCHAR (100) NOT NULL,
    [AccountId]       INT            NOT NULL,
    [LichenAccountId] INT            NULL,
    [LocationId]      INT            NULL,
    [InvGrpId]        INT            NOT NULL,
    [gl_account]      INT            NULL,
    [TN]              NVARCHAR (64)  NULL,
    [EmailTo]         NVARCHAR (256) NULL,
    [NumScribes]      INT            NULL,
    [DurationSeconds] FLOAT (53)     NULL,
    [ScribePlan]      NVARCHAR (128) NULL,
    [ScribeSubPlan]   NVARCHAR (128) NULL,
    [Charge]          FLOAT (53)     NULL
);

