CREATE TABLE [dbo].[SFDC_SAP_AX_ID_MAP] (
    [SfdcId]         NVARCHAR (255) NULL,
    [Name]           NVARCHAR (255) NULL,
    [ShoreTelId_SAP] FLOAT (53)     NOT NULL,
    [OtherERPNo]     FLOAT (53)     NULL,
    CONSTRAINT [PK_SFDC_SAP_AX_ID_MAP] PRIMARY KEY CLUSTERED ([ShoreTelId_SAP] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SFDC_SAP_AX_ID_MAP] TO [nkleinberg]
    AS [dbo];

