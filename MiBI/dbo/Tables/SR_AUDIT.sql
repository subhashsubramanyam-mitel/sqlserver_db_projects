CREATE TABLE [dbo].[SR_AUDIT] (
    [SfdcId]             VARCHAR (30)  NOT NULL,
    [SR_NUM]             VARCHAR (64)  NULL,
    [Date_Updated]       DATETIME      NOT NULL,
    [Updated_By]         VARCHAR (50)  NULL,
    [Change_Desc]        VARCHAR (255) NULL,
    [Field_Changed]      VARCHAR (100) NULL,
    [Old_Field]          VARCHAR (100) NULL,
    [New_Field]          VARCHAR (100) NULL,
    [Current_Status]     VARCHAR (50)  NULL,
    [Current_Sub_Status] VARCHAR (50)  NULL,
    [Status_Last_Update] DATETIME      NULL,
    [CreatedDate]        DATETIME      NULL,
    CONSTRAINT [PK_SR_AUDIT] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_SR_AUDIT]
    ON [dbo].[SR_AUDIT]([SR_NUM] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_AUDIT] TO [TacEngRole]
    AS [dbo];

