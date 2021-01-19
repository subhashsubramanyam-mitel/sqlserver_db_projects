CREATE TABLE [dbo].[SR_DEF_INTERFACE] (
    [Id]               VARCHAR (50) NOT NULL,
    [SrId]             VARCHAR (50) NULL,
    [SR_NUM]           VARCHAR (50) NOT NULL,
    [DefectId]         VARCHAR (50) NULL,
    [DEFECT_NUM]       VARCHAR (50) NOT NULL,
    [AssocType]        VARCHAR (50) NULL,
    [CreatedDate]      DATETIME     NULL,
    [LastModifiedDate] DATETIME     NULL,
    CONSTRAINT [PK_SR_DEF_INTERFACE] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_SR_DEF_INTERFACE]
    ON [dbo].[SR_DEF_INTERFACE]([SR_NUM] ASC, [DEFECT_NUM] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_DEF_INTERFACE] TO [TacEngRole]
    AS [dbo];

