CREATE TABLE [dbo].[SKY_NPC_CONTACTS] (
    [company]             NVARCHAR (100) NULL,
    [LichenAccountId]     NVARCHAR (50)  NULL,
    [m5dbaccountid]       NVARCHAR (50)  NULL,
    [AccountNumber]       NVARCHAR (50)  NULL,
    [accountSalesForceId] NVARCHAR (50)  NULL,
    [accountteam]         NVARCHAR (50)  NULL,
    [pm]                  NVARCHAR (50)  NULL,
    [pm_email]            NVARCHAR (50)  NULL,
    [salesperson]         NVARCHAR (50)  NULL,
    [salesperson_email]   NVARCHAR (50)  NULL,
    [contactid]           NVARCHAR (50)  NULL,
    [Name]                NVARCHAR (100) NULL,
    [personSalesForceId]  NVARCHAR (50)  NULL,
    [BusinessEmail]       NVARCHAR (50)  NULL,
    [PersonalEmail]       NVARCHAR (50)  NULL,
    [Cellphone]           NVARCHAR (50)  NULL,
    [M5Tn]                NVARCHAR (50)  NULL,
    [firstinvoice]        NVARCHAR (50)  NULL,
    [lastinvoice]         NVARCHAR (50)  NULL,
    [actice_phones]       NVARCHAR (50)  NULL,
    [pending_phones]      NVARCHAR (50)  NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SKY_NPC_CONTACTS] TO [CsatData]
    AS [dbo];

