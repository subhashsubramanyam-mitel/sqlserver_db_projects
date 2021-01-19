CREATE TABLE [dbo].[SLS_Export] (
    [Customer First Name]                 NVARCHAR (1)   NULL,
    [Customer Last Name]                  NVARCHAR (1)   NULL,
    [Customer Title]                      NVARCHAR (1)   NULL,
    [Customer Email Adress]               NVARCHAR (1)   NULL,
    [Customer Phone]                      NVARCHAR (1)   NULL,
    [Customer Company name]               NVARCHAR (162) NULL,
    [Product Serial]                      NVARCHAR (36)  NULL,
    [Product Type]                        NVARCHAR (49)  NULL,
    [Product Release]                     NVARCHAR (19)  NULL,
    [Product SWA End Date]                DATETIME       NULL,
    [Company Primary Address - City]      NVARCHAR (1)   NULL,
    [Company Primary Address - State]     NVARCHAR (1)   NULL,
    [Company Primary Address - Country]   NVARCHAR (2)   NULL,
    [Company Secondary Address - City]    NVARCHAR (1)   NULL,
    [Company Secondary Address - State]   NVARCHAR (1)   NULL,
    [Company Secondary Address - Country] NVARCHAR (1)   NULL,
    [Country Sales Unit Name]             NVARCHAR (42)  NULL,
    [Partner Customer Number]             NVARCHAR (38)  NULL,
    [Partner Name]                        NVARCHAR (1)   NULL,
    [Reseller Name]                       NVARCHAR (73)  NULL
);

