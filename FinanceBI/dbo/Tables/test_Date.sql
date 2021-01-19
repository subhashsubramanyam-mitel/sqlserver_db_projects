CREATE TABLE [dbo].[test_Date] (
    [Id]   UNIQUEIDENTIFIER NULL,
    [test] DATETIME         NOT NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[test_Date] TO [app_megasilo]
    AS [dbo];

