CREATE TABLE [PCSarchive].[PartnerReplacementLocation] (
    [Region]                            NCHAR (6)       NULL,
    [LocationID]                        BIGINT          NULL,
    [Account Name]                      NVARCHAR (255)  NULL,
    [Crediting Partner ID]              BIGINT          NULL,
    [Crediting Partner]                 NVARCHAR (255)  NULL,
    [Location Adjusted Commission Rate] FLOAT (53)      NULL,
    [Include Usage?]                    NCHAR (10)      NULL,
    [SubAgentId]                        NVARCHAR (128)  NULL,
    [SubAgent]                          NVARCHAR (512)  NULL,
    [RepName]                           NVARCHAR (256)  NULL,
    [Notes]                             NVARCHAR (1024) NULL,
    [Id]                                INT             IDENTITY (1, 1) NOT NULL,
    [DateModified]                      DATETIME2 (4)   NOT NULL,
    [DateCreated]                       DATETIME2 (4)   NOT NULL,
    [ModifiedBy]                        NVARCHAR (50)   NOT NULL,
    [Partner From Data]                 NVARCHAR (255)  NULL,
    [lichenlocationid]                  BIGINT          NULL
);

