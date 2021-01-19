CREATE TABLE [dbo].[DIMENSIONS] (
    [DESCRIPTION]          NVARCHAR (60) COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [NUM]                  NVARCHAR (30) COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [DIMENSIONCODE]        INT           NOT NULL,
    [INCHARGE]             NVARCHAR (40) COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [CLOSED]               INT           NOT NULL,
    [REVERSESIGN]          INT           NOT NULL,
    [COLUMN_]              INT           NOT NULL,
    [BOLDTYPEFACE]         INT           NOT NULL,
    [ITALIC]               INT           NOT NULL,
    [LINEEXCEED]           INT           NOT NULL,
    [LINESUB]              INT           NOT NULL,
    [UNDERLINETXT]         INT           NOT NULL,
    [UNDERLINENUMERALS]    INT           NOT NULL,
    [COSBLOCKPOSTCOST]     INT           NOT NULL,
    [COSBLOCKPOSTWORK]     INT           NOT NULL,
    [COSBLOCKDISTRIBUTION] INT           NOT NULL,
    [COSBLOCKALLOCATION]   INT           NOT NULL,
    [SEMPUBLISH]           INT           NOT NULL,
    [DATAAREAID]           NVARCHAR (4)  COLLATE Latin1_General_CI_AS_KS NOT NULL,
    [RECVERSION]           INT           NOT NULL,
    [RECID]                BIGINT        NOT NULL,
    [COMPANYGROUP]         NVARCHAR (10) COLLATE Latin1_General_CI_AS_KS NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DIMENSIONS] TO [CANDY\dherskovich]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DIMENSIONS] TO [CANDY\etlprod]
    AS [dbo];

