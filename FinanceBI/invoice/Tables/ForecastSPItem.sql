﻿CREATE TABLE [invoice].[ForecastSPItem] (
    [BillingCategoryId]     INT             NOT NULL,
    [LineItemId]            INT             NULL,
    [ServiceId]             INT             NULL,
    [ProductId]             INT             NULL,
    [Name]                  NVARCHAR (128)  NULL,
    [TN]                    NVARCHAR (15)   NULL,
    [DateGenerated]         DATE            NOT NULL,
    [LocationId]            INT             NOT NULL,
    [AccountId]             INT             NOT NULL,
    [InvoiceGroupId]        INT             NULL,
    [InvoiceId]             INT             NULL,
    [DatePeriodStart_Local] DATE            NOT NULL,
    [DatePeriodEnd_Local]   DATE            NOT NULL,
    [Charge]                NUMERIC (20, 4) NULL,
    [ChargeCategory]        NVARCHAR (64)   NOT NULL,
    [OneTimeCharge]         MONEY           NULL,
    [MonthlyCharge]         MONEY           NULL,
    [Prorates]              MONEY           NULL,
    [MRR]                   MONEY           NULL,
    [Usage]                 MONEY           NULL,
    [Credits]               MONEY           NULL,
    [Regulatory]            MONEY           NULL,
    [Surcharge]             MONEY           NULL,
    [Unclassified]          MONEY           NULL,
    [FootnoteNumber]        INT             NULL,
    [MonthsBilled]          FLOAT (53)      NULL,
    [Resub_MoM]             NUMERIC (19, 4) NULL,
    [Resub_YoY]             NUMERIC (19, 4) NULL,
    [DateComputed]          DATE            NOT NULL,
    [BillingStage]          NVARCHAR (50)   NOT NULL
);

