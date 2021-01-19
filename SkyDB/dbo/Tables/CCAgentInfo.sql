CREATE TABLE [dbo].[CCAgentInfo] (
    [Tn]             NVARCHAR (15) NULL,
    [PersonId]       INT           NULL,
    [isCCAgent]      INT           NULL,
    [isCCSupervisor] INT           NULL,
    [rn]             BIGINT        NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CCAgentInfo] TO [SkyImp]
    AS [dbo];

