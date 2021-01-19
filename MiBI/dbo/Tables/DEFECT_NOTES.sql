CREATE TABLE [dbo].[DEFECT_NOTES] (
    [SfdcId]           VARCHAR (30) NOT NULL,
    [DEFECT_NUM]       VARCHAR (64) NOT NULL,
    [Note_Created]     DATETIME     NOT NULL,
    [NOTE]             TEXT         NULL,
    [NOTE_TYPE]        VARCHAR (30) NULL,
    [Creator]          VARCHAR (50) NULL,
    [CreatorSfdcId]    VARCHAR (30) NULL,
    [LastModifiedDate] DATETIME     NULL,
    CONSTRAINT [PK_DEFECT_NOTES2] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DEFECT_NOTES] TO [TacEngRole]
    AS [dbo];

