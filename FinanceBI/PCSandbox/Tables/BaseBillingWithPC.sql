CREATE TABLE [PCSandbox].[BaseBillingWithPC] (
    [PCMonth]                         DATE            NULL,
    [Region]                          NVARCHAR (50)   NOT NULL,
    [AccountID]                       BIGINT          NULL,
    [ClientName]                      NVARCHAR (100)  NULL,
    [LocationID]                      INT             NOT NULL,
    [Address]                         NVARCHAR (100)  NULL,
    [City]                            NVARCHAR (100)  NULL,
    [CodeAlpha]                       NVARCHAR (10)   NULL,
    [ZipCode]                         NVARCHAR (20)   NULL,
    [LichenClassName]                 NVARCHAR (4000) NULL,
    [ProductId]                       INT             NULL,
    [ProductName]                     NVARCHAR (512)  NULL,
    [ServiceId]                       INT             NULL,
    [ChargeType]                      NVARCHAR (50)   NULL,
    [Charge LC]                       MONEY           NOT NULL,
    [Charge]                          MONEY           NULL,
    [CurrencyCode]                    CHAR (3)        NULL,
    [Description]                     NVARCHAR (512)  NOT NULL,
    [DatePeriodStart]                 DATE            NOT NULL,
    [DatePeriodEnd]                   DATE            NOT NULL,
    [InvoiceMonth]                    DATE            NULL,
    [LineItemId]                      BIGINT          NOT NULL,
    [IsCommisssionable]               INT             NULL,
    [CommissionableBillingsAmount LC] MONEY           NULL,
    [CommissionableBillingsAmount]    MONEY           NULL,
    [CreditingPartnerId]              INT             NULL,
    [CreditingPartner]                NVARCHAR (255)  NULL,
    [PaymentPlan]                     NVARCHAR (255)  NULL,
    [CommRate]                        FLOAT (53)      NULL,
    [PartnerCommissionAmount LC]      MONEY           NULL,
    [PartnerCommissionAmount]         MONEY           NULL,
    [SubAgentId]                      NVARCHAR (128)  NULL,
    [SubAgent]                        NVARCHAR (512)  NULL,
    [RepName]                         NVARCHAR (256)  NULL,
    [CommissionId]                    INT             IDENTITY (1, 1) NOT NULL,
    [LocationChange]                  INT             NULL,
    [AccountChange]                   INT             NULL,
    [ServiceChange]                   INT             NULL,
    [Ac isBillable]                   BIT             NULL,
    [DateCreated]                     DATETIME        NOT NULL,
    [LichenLocationId]                INT             NULL,
    [LichenAccountId]                 INT             NULL,
    [CenturyMonth]                    INT             NULL,
    [InvoiceCount]                    INT             NULL
);


GO
GRANT INSERT
    ON OBJECT::[PCSandbox].[BaseBillingWithPC] TO [CANDY\TAbenova]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[PCSandbox].[BaseBillingWithPC] TO [CANDY\TAbenova]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[PCSandbox].[BaseBillingWithPC] TO [CANDY\TAbenova]
    AS [dbo];

