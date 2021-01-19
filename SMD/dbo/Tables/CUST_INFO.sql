CREATE TABLE [dbo].[CUST_INFO] (
    [SECreatedDate]  DATETIME        NULL,
    [SE_ID]          NVARCHAR (255)  COLLATE Latin1_General_BIN NULL,
    [CustomerId]     VARCHAR (50)    COLLATE Latin1_General_BIN NULL,
    [NAME]           VARCHAR (100)   COLLATE Latin1_General_BIN NOT NULL,
    [Region]         VARCHAR (50)    COLLATE Latin1_General_BIN NULL,
    [Country]        VARCHAR (100)   COLLATE Latin1_General_BIN NULL,
    [Partner_Csn]    VARCHAR (50)    COLLATE Latin1_General_BIN NULL,
    [Employees]      FLOAT (53)      NULL,
    [Industry]       NVARCHAR (100)  COLLATE Latin1_General_BIN NULL,
    [SIC]            VARCHAR (50)    COLLATE Latin1_General_BIN NOT NULL,
    [Size]           VARCHAR (8)     COLLATE Latin1_General_BIN NULL,
    [Licenses]       NUMERIC (38)    NULL,
    [UserLic]        NUMERIC (38)    NULL,
    [SumOfList]      NUMERIC (38, 2) NULL,
    [VersionFromSR]  VARCHAR (50)    COLLATE Latin1_General_BIN NULL,
    [CustCreateQtr]  VARCHAR (10)    COLLATE Latin1_General_BIN NULL,
    [SbeCustomer]    VARCHAR (3)     COLLATE Latin1_General_BIN NOT NULL,
    [InstallDate_ph] DATETIME        NULL,
    [Version_ph]     VARCHAR (50)    COLLATE Latin1_General_BIN NULL,
    [ImpactNumber]   VARCHAR (14)    COLLATE Latin1_General_BIN NOT NULL,
    [SupportEnd]     DATETIME        NULL
);

