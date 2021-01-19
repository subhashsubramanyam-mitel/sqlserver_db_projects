CREATE TABLE [enum].[CdrRouteType] (
    [id]           BIGINT       NOT NULL,
    [name]         VARCHAR (20) NOT NULL,
    [DateModified] DATETIME     NOT NULL,
    [DateCreated]  DATETIME     NOT NULL,
    [authId]       BIGINT       NOT NULL,
    [createAuthId] BIGINT       NOT NULL
);

