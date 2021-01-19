CREATE TABLE [dbo].[SFDC_BILL_LOG] (
    [Created]         DATETIME        CONSTRAINT [DF_SFDC_BILL_LOG_Created] DEFAULT (getdate()) NULL,
    [Id]              VARCHAR (50)    NOT NULL,
    [SfDeleteEndTime] DATETIME        NULL,
    [SfSoLoadEnd]     DATETIME        NULL,
    [SfLoadErrEnd]    DATETIME        NULL,
    [Errors]          FLOAT (53)      NULL,
    [SfInvLoadEnd]    DATETIME        NULL,
    [InvIn]           FLOAT (53)      NULL,
    [InvOut]          FLOAT (53)      NULL,
    [ZombieInvoices]  INT             NULL,
    [TotalSent]       DECIMAL (18, 2) NULL,
    [TotalRcv]        DECIMAL (18, 2) NULL,
    [Status]          CHAR (1)        CONSTRAINT [DF_SFDC_BILL_LOG_Status] DEFAULT ('N') NULL,
    [Message]         TEXT            NULL,
    CONSTRAINT [PK_SFDC_BILL_LOG] PRIMARY KEY CLUSTERED ([Id] ASC)
);

