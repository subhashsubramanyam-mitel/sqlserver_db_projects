CREATE TABLE [tmp].[m5db_device_RouterAccess] (
    [Id]                   INT           NOT NULL,
    [RouterId]             INT           NOT NULL,
    [Ip]                   VARCHAR (16)  NOT NULL,
    [RouterAccessStatusId] INT           NOT NULL,
    [DateModified]         DATETIME2 (4) NOT NULL
);

