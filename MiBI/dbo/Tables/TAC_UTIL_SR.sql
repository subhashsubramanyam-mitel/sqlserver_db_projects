CREATE TABLE [dbo].[TAC_UTIL_SR] (
    [SR_NUM]                VARCHAR (50)  NOT NULL,
    [CREATED]               DATETIME      NOT NULL,
    [DistyRowId]            VARCHAR (15)  NULL,
    [DistyName]             VARCHAR (200) NULL,
    [PartnerRowId]          VARCHAR (15)  NULL,
    [PartnerName]           VARCHAR (200) NULL,
    [Customer]              VARCHAR (200) NULL,
    [EndUserSupportProgram] VARCHAR (100) NULL,
    CONSTRAINT [PK_TAC_UTIL_SR] PRIMARY KEY CLUSTERED ([SR_NUM] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_UTIL_SR] TO [TacEngRole]
    AS [dbo];

