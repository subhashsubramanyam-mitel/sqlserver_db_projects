CREATE TABLE [dbo].[SR_MTTR] (
    [Id]          NUMERIC (18) IDENTITY (1, 1) NOT NULL,
    [SR_NUM]      VARCHAR (64) NOT NULL,
    [SubStatus]   VARCHAR (50) NULL,
    [OWNER]       VARCHAR (50) NOT NULL,
    [JOB_TITLE]   VARCHAR (75) NULL,
    [CreateDate]  DATETIME     NOT NULL,
    [CloseDate]   DATETIME     NULL,
    [Product]     VARCHAR (30) NULL,
    [DaysToClose] FLOAT (53)   NULL,
    CONSTRAINT [PK_SR_MTTR] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_MTTR] TO [TacEngRole]
    AS [dbo];

