CREATE TABLE [dbo].[SR_ACTIVITY] (
    [SfdcId]           VARCHAR (30)  NOT NULL,
    [SR_NUM]           VARCHAR (50)  NOT NULL,
    [Internal]         VARCHAR (30)  NULL,
    [Type]             VARCHAR (100) NULL,
    [Description]      VARCHAR (MAX) NULL,
    [Comments]         VARCHAR (MAX) NULL,
    [CREATED]          DATETIME      NOT NULL,
    [Billable]         VARCHAR (10)  NOT NULL,
    [Duration]         VARCHAR (30)  NULL,
    [LastModifiedDate] DATETIME      NULL,
    [SR_SfdcId]        VARCHAR (50)  NULL,
    CONSTRAINT [PK_SR_ACTIVITY_1] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_ACTIVITY] TO [TacEngRole]
    AS [dbo];

