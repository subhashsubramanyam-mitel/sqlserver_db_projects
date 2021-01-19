CREATE TABLE [dbo].[LKM_DEP_KEYS] (
    [ReqId]                 INT              NOT NULL,
    [CustomerID]            VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SalesOrder]            VARCHAR (15)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SE_ID]                 VARCHAR (15)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [MacAddress]            VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Quantity]              CHAR (2)         COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerName]           VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EndCustomer]           VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CustomerName_LKM]      VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Address1]              VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [City]                  VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [State]                 CHAR (100)       COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Zip]                   VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Country]               VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Phone]                 VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Email]                 VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PrimaryContact]        VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PrimaryContactPhone]   VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PrimaryContactEmail]   VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PrimaryContactTitle]   VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AlternateContact]      VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AlternateContactPhone] VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AlternateContactTitle] VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AlternateContactEmail] VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Description_LKM]       VARCHAR (100)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [UALs_LKM]              INT              NULL,
    [Comment_LKM]           VARCHAR (3000)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PH_Date]               DATETIME         NOT NULL,
    [Key]                   VARCHAR (32)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DateDeprecated_LKM]    DATETIME         NOT NULL,
    [SKU]                   VARCHAR (10)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [LicenseType]           VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Total]                 NUMERIC (38, 11) NULL,
    [ReasonforDeprecation]  VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[LKM_DEP_KEYS] TO [TacEngRole]
    AS [dbo];

