﻿CREATE TABLE [PCBI].[mVw_TEMP] (
    [CommissionType]                  VARCHAR (17)    NOT NULL,
    [Region]                          NVARCHAR (50)   NULL,
    [PCMonth]                         DATE            NULL,
    [AccountGUID]                     VARCHAR (50)    NULL,
    [AccountID]                       BIGINT          NULL,
    [ClientName]                      NVARCHAR (120)  NULL,
    [PaymentPlan]                     NVARCHAR (255)  NULL,
    [LocationGUID]                    VARCHAR (50)    NULL,
    [LocationID]                      INT             NULL,
    [SubAgentGUID]                    NVARCHAR (692)  NULL,
    [SubAgentId]                      NVARCHAR (128)  NULL,
    [SubAgent]                        NVARCHAR (512)  NULL,
    [RepName]                         NVARCHAR (256)  NULL,
    [CreditingPartnerId]              BIGINT          NULL,
    [CreditingPartner]                NVARCHAR (255)  NULL,
    [ProductGUID]                     NVARCHAR (4000) NULL,
    [ProductId]                       BIGINT          NULL,
    [ProductName]                     NVARCHAR (512)  NULL,
    [Description]                     NVARCHAR (1024) NULL,
    [CurrencyCode]                    CHAR (3)        NULL,
    [ChargeType]                      NVARCHAR (50)   NULL,
    [Charge LC]                       MONEY           NULL,
    [Charge]                          MONEY           NULL,
    [CommissionableBillingsAmount LC] MONEY           NULL,
    [CommissionableBillingsAmount]    MONEY           NULL,
    [SalesComm LC]                    MONEY           NULL,
    [SalesComm]                       MONEY           NULL
);

