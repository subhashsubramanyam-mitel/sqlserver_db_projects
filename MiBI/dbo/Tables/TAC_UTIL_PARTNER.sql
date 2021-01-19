CREATE TABLE [dbo].[TAC_UTIL_PARTNER] (
    [SE_ID]          VARCHAR (15)    NULL,
    [ImpactNumber]   CHAR (7)        NOT NULL,
    [Partner]        VARCHAR (100)   NULL,
    [Licenses]       INT             NULL,
    [SrCount]        INT             CONSTRAINT [DF_PARTNER_TAC_UTIL_SrCount] DEFAULT ((0)) NULL,
    [SrCount_Annual] INT             CONSTRAINT [DF_PARTNER_TAC_UTIL_SrCount3] DEFAULT ((0)) NULL,
    [Utilization]    DECIMAL (10, 2) CONSTRAINT [DF_PARTNER_TAC_UTIL_Utilization] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_PARTNER_TAC_UTIL] PRIMARY KEY CLUSTERED ([ImpactNumber] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_UTIL_PARTNER] TO [TacEngRole]
    AS [dbo];

