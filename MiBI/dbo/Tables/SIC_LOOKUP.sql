CREATE TABLE [dbo].[SIC_LOOKUP] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [Div]      NVARCHAR (15)  NULL,
    [DivDesc]  NVARCHAR (100) NULL,
    [Sic4]     NVARCHAR (50)  NULL,
    [Sic4Desc] NVARCHAR (50)  NULL,
    [Sic2]     NVARCHAR (50)  NULL,
    [Sic2Desc] NVARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_LOOKUP_1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SIC_LOOKUP] TO [PMData]
    AS [dbo];

