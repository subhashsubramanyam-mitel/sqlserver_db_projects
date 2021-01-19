CREATE TABLE [dbo].[LeadRebate] (
    [ROWID]       BIGINT          IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [PartnerSTID] VARCHAR (50)    NULL,
    [Partner]     VARCHAR (500)   NULL,
    [VadSTID]     VARCHAR (50)    NULL,
    [VadName]     VARCHAR (500)   NULL,
    [RebatePct]   VARCHAR (50)    NULL,
    [Rebate]      NUMERIC (14, 2) CONSTRAINT [DF_LeadRebate_Rebate] DEFAULT ((0)) NOT NULL,
    [SalesOrder]  VARCHAR (50)    NULL,
    CONSTRAINT [PK_LeadRebate] PRIMARY KEY CLUSTERED ([ROWID] ASC)
);

