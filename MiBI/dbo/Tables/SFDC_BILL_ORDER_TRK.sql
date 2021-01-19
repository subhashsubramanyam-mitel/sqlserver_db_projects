CREATE TABLE [dbo].[SFDC_BILL_ORDER_TRK] (
    [Created]       DATETIME       CONSTRAINT [DF_SFDC_BILL_ORDER_TRK_Created] DEFAULT (getdate()) NOT NULL,
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [SalesOrder]    NVARCHAR (20)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [OrderDate]     DATETIME       NULL,
    [PartnerSfdcId] NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EndCust]       VARCHAR (50)   NULL,
    [Billings]      FLOAT (53)     NULL,
    [Status]        CHAR (1)       CONSTRAINT [DF_SFDC_BILL_ORDER_TRK_Status] DEFAULT ('N') NULL,
    [Error]         TEXT           NULL,
    [SfdcOrderId]   VARCHAR (50)   NULL,
    [GOV]           VARCHAR (15)   NULL,
    [MAP]           VARCHAR (15)   NULL,
    CONSTRAINT [PK_SFDC_BILL_ORDER_TRK] PRIMARY KEY CLUSTERED ([Id] ASC)
);

