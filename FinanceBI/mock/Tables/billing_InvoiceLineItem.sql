﻿CREATE TABLE [mock].[billing_InvoiceLineItem] (
    [Id]                       INT            NOT NULL,
    [DateGenerated]            DATETIME       NOT NULL,
    [InvoiceId]                INT            NOT NULL,
    [LocationId]               INT            NULL,
    [ProductId]                INT            NULL,
    [ServicePriceId]           INT            NULL,
    [Description]              NVARCHAR (512) NOT NULL,
    [DatePeriodStart]          DATETIME       NOT NULL,
    [DatePeriodEnd]            DATETIME       NOT NULL,
    [ChargeTypeId]             INT            NOT NULL,
    [Charge]                   MONEY          NOT NULL,
    [Quantity]                 INT            NOT NULL,
    [FootnoteNumber]           INT            NULL,
    [LichenBillingGroupPlanId] INT            NULL,
    [DateModified]             DATETIME2 (4)  NOT NULL,
    [DateCreated]              DATETIME2 (4)  NOT NULL,
    [ModifiedBy]               NVARCHAR (50)  NOT NULL,
    [TmpLineItemId]            INT            NULL,
    [LineItemTypeId]           INT            NULL,
    [LichenLineItemId]         INT            NOT NULL,
    [InvoiceServiceGroupId]    INT            NULL,
    [PricePlanPriceId]         INT            NULL
);

