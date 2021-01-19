CREATE TABLE [commission].[History_PlanProductRate] (
    [PCMonth]      DATE           NULL,
    [RateId]       BIGINT         NULL,
    [Region]       NVARCHAR (6)   NOT NULL,
    [PCPlanName]   NVARCHAR (50)  NOT NULL,
    [ProductId]    INT            NOT NULL,
    [ProdCommRate] FLOAT (53)     NOT NULL,
    [Note]         NVARCHAR (256) NULL
);

