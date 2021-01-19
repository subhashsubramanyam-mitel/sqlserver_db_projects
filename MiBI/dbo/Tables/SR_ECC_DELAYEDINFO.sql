CREATE TABLE [dbo].[SR_ECC_DELAYEDINFO] (
    [SR_NUM]         VARCHAR (30) NOT NULL,
    [Status]         VARCHAR (30) NULL,
    [Feature]        VARCHAR (50) NULL,
    [Owner]          VARCHAR (50) NULL,
    [Priority]       VARCHAR (50) NULL,
    [Date_Open]      DATETIME     NULL,
    [ACT_CLOSE_DT]   DATETIME     NULL,
    [SupportProgram] VARCHAR (50) NULL,
    [SubFeatComp]    VARCHAR (50) NULL,
    CONSTRAINT [PK_SR_ECC_DELAYEDINFO] PRIMARY KEY CLUSTERED ([SR_NUM] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_ECC_DELAYEDINFO] TO [TacEngRole]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[SR_ECC_DELAYEDINFO] TO [ITApps]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SR_ECC_DELAYEDINFO] TO [ITApps]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SR_ECC_DELAYEDINFO] TO [ITApps]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_ECC_DELAYEDINFO] TO [ITApps]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SR_ECC_DELAYEDINFO] TO [ITApps]
    AS [dbo];

