CREATE TABLE [PCSarchive].[PlanProductRate] (
    [RateId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [Region]       NVARCHAR (6)   NOT NULL,
    [PCPlanName]   NVARCHAR (50)  NOT NULL,
    [ProductId]    INT            NOT NULL,
    [ProdCommRate] FLOAT (53)     NOT NULL,
    [Note]         NVARCHAR (256) NULL
);

