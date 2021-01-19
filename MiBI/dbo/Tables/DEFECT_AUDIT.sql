CREATE TABLE [dbo].[DEFECT_AUDIT] (
    [Id]            NUMERIC (18)  IDENTITY (1, 1) NOT NULL,
    [DEFECT_NUM]    VARCHAR (64)  NOT NULL,
    [Changed_Date]  DATETIME      NOT NULL,
    [CREATED_BY]    VARCHAR (15)  NOT NULL,
    [Field_Changed] VARCHAR (100) NULL,
    [New_Value]     VARCHAR (100) NULL,
    [Old_Value]     VARCHAR (100) NULL,
    [MRT_Target]    VARCHAR (50)  NULL,
    [MRT_Id]        VARCHAR (30)  NULL,
    [Description]   VARCHAR (255) NULL,
    [LOGIN]         VARCHAR (50)  NOT NULL,
    [Defect_Found]  VARCHAR (100) NULL,
    CONSTRAINT [PK_DEFECT_MRT] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DEFECT_MRT]
    ON [dbo].[DEFECT_AUDIT]([DEFECT_NUM] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DEFECT_AUDIT] TO [TacEngRole]
    AS [dbo];

