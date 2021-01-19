CREATE TABLE [dbo].[SkyUserDetail] (
    [AccountId]           INT            NULL,
    [AccountName]         NVARCHAR (100) NULL,
    [ProfileTN]           NVARCHAR (15)  NULL,
    [FirstName]           NVARCHAR (120) NULL,
    [LastName]            NVARCHAR (120) NULL,
    [UserName]            NVARCHAR (120) NULL,
    [BusinessEmail]       NVARCHAR (120) NULL,
    [LocationName]        NVARCHAR (200) NULL,
    [Address]             NVARCHAR (100) NULL,
    [ProfileType]         NVARCHAR (20)  NULL,
    [Extension]           NVARCHAR (15)  NULL,
    [Fax]                 VARCHAR (3)    NOT NULL,
    [Scribe]              VARCHAR (3)    NOT NULL,
    [CallRecording]       VARCHAR (3)    NOT NULL,
    [Conferencing]        VARCHAR (3)    NOT NULL,
    [GrandStream]         VARCHAR (3)    NOT NULL,
    [CiscoSPA]            VARCHAR (3)    NOT NULL,
    [CiscoATA]            VARCHAR (3)    NOT NULL,
    [PolycomSoundStation] VARCHAR (3)    NOT NULL,
    [LinkSysSPA]          VARCHAR (3)    NOT NULL,
    [OtherDevice]         VARCHAR (3)    NOT NULL,
    [CRM]                 VARCHAR (3)    NOT NULL,
    [Mobility]            VARCHAR (3)    NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SkyUserDetail] TO [SkyImp]
    AS [dbo];

