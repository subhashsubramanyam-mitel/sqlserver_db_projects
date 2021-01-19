CREATE TABLE [dbo].[DEFECT_ATT] (
    [Created]    DATETIME      NULL,
    [DEFECT_NUM] VARCHAR (50)  NULL,
    [FILE_NAME]  VARCHAR (200) NULL,
    [PATH]       VARCHAR (200) NULL,
    [FILE_EXT]   VARCHAR (50)  NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DEFECT_ATT] TO [TacEngRole]
    AS [dbo];

