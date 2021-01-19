CREATE TABLE [ALSandbox].[PMList] (
    [PersonId]  BIGINT        NOT NULL,
    [FullName]  NVARCHAR (40) NOT NULL,
    [StartDate] DATE          NOT NULL,
    [EndDate]   DATE          NULL,
    [Region]    VARCHAR (20)  NULL,
    [Manila]    INT           NULL
);

