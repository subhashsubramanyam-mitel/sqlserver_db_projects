CREATE TABLE [dbo].[PH_HARDWARE] (
    [Created]        DATETIME      NOT NULL,
    [ReqId]          INT           NOT NULL,
    [SystemMac]      VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerName]    VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EndCustomer]    VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ProductVersion] VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Description]    VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SerialNumber]   VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SwitchMac]      VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PH_HARDWARE] TO [TacEngRole]
    AS [dbo];

