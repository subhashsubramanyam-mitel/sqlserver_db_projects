CREATE TABLE [dbo].[SKY_SFDC_ORDERS] (
    [Created]             DATETIME       CONSTRAINT [DF_SKY_SFDC_ORDERS_Created] DEFAULT (getdate()) NULL,
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [CiId]                VARCHAR (50)   NOT NULL,
    [M5DBOrderId]         FLOAT (53)     NULL,
    [OrderId]             NVARCHAR (255) NULL,
    [LichenOrderId]       FLOAT (53)     NULL,
    [OrderType]           NVARCHAR (255) NULL,
    [Name]                NVARCHAR (255) NULL,
    [Status]              NVARCHAR (255) NULL,
    [Accountid]           NVARCHAR (255) NULL,
    [LocationId]          NVARCHAR (255) NULL,
    [CreatedBy]           NVARCHAR (255) NULL,
    [Contact]             NVARCHAR (255) NULL,
    [Owner]               NVARCHAR (255) NULL,
    [InitialM5dbOrderId]  FLOAT (53)     NULL,
    [InitialOrderId]      NVARCHAR (255) NULL,
    [DateCreatedOriginal] DATETIME       NULL,
    [DateLiveScheduled]   DATETIME       NULL,
    [DateBillingStart]    DATETIME       NULL,
    [DateBillingStopped]  DATETIME       NULL,
    [OrderDateClosed]     DATETIME       NULL,
    [InitialMRR]          FLOAT (53)     NULL,
    [PendingMRR]          FLOAT (53)     NULL,
    [ActiveMRR]           FLOAT (53)     NULL,
    [VoidMRR]             FLOAT (53)     NULL,
    [ChangedMRR]          FLOAT (53)     NULL,
    [ClosedMRR]           FLOAT (53)     NULL,
    [InitialNRC]          FLOAT (53)     NULL,
    [PendingNRC]          FLOAT (53)     NULL,
    [ActivatedNRC]        FLOAT (53)     NULL,
    [VoidNRC]             FLOAT (53)     NULL,
    [M5DBAccountId]       FLOAT (53)     NULL,
    [M5DBCompanyId]       FLOAT (53)     NULL,
    [ErrStatus]           CHAR (1)       CONSTRAINT [DF_SKY_SFDC_ORDERS_ErrStatus] DEFAULT ('C') NULL,
    [ErrorTxt]            TEXT           NULL,
    CONSTRAINT [PK_SKY_SFDC_ORDERS_1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SKY_SFDC_ORDERS] TO [SKY_SFDC]
    AS [dbo];

