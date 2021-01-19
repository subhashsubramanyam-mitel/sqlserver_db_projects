CREATE TABLE [dbo].[ITSM] (
    [ID]                VARCHAR (50)  NOT NULL,
    [CreatedBy]         VARCHAR (500) NULL,
    [CreatedByID]       VARCHAR (50)  NULL,
    [CreatedDate]       DATETIME      NULL,
    [DurationInMinutes] VARCHAR (50)  NULL,
    [DurationInSeconds] VARCHAR (50)  NULL,
    [EndDateTime]       DATETIME      NULL,
    [ITSM]              VARCHAR (255) NULL,
    [ITSMType]          VARCHAR (255) NULL,
    [LastModifiedBy]    VARCHAR (500) NULL,
    [LastModifiedByID]  VARCHAR (50)  NULL,
    [LastModifiedDate]  DATETIME      NULL,
    [RecordType]        VARCHAR (255) NULL,
    [StartDateTime]     DATETIME      NULL,
    [Status]            VARCHAR (50)  NULL,
    [SystemsAffected]   VARCHAR (500) NULL,
    [RecordTypeName]    VARCHAR (255) NULL,
    [ITSMTypeName]      VARCHAR (255) NULL,
    [Category]          VARCHAR (255) NULL,
    [TrustColor]        VARCHAR (255) NULL,
    CONSTRAINT [PK_ITSM] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ITSM] TO [CANDY\aneuman]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ITSM] TO [CANDY\alossing]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ITSM] TO [CANDY\MBrondum]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ITSM] TO [CANDY\dorr]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ITSM] TO [CANDY\beswanson]
    AS [dbo];

