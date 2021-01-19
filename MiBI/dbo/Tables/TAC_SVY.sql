CREATE TABLE [dbo].[TAC_SVY] (
    [Created]                  DATETIME      CONSTRAINT [DF_TAC_SVY_Created] DEFAULT (getdate()) NOT NULL,
    [SvyID]                    VARCHAR (50)  NOT NULL,
    [RespID]                   VARCHAR (50)  NOT NULL,
    [RespTime]                 DATETIME      NOT NULL,
    [SrNum]                    VARCHAR (50)  NULL,
    [KbQuality]                INT           NULL,
    [KbSat]                    INT           NULL,
    [Feedback]                 TEXT          NULL,
    [puKbFindInfo]             INT           NULL,
    [puKbContentSat]           INT           NULL,
    [puKbEaseOfFindingInfoSat] INT           NULL,
    [puKbFirstStep]            INT           NULL,
    [puKbSuggestions]          TEXT          NULL,
    [puKbContactorEmail]       VARCHAR (200) NULL,
    [S4747_FirstName]          VARCHAR (50)  NULL,
    [S4747_LastName]           VARCHAR (50)  NULL,
    [S4747_Email]              VARCHAR (50)  NULL,
    [S4747_Login]              VARCHAR (50)  NULL,
    [S4747_Resp_01]            CHAR (2)      NULL,
    [S4747_Resp_02]            CHAR (2)      NULL,
    [S4747_Resp_03]            CHAR (2)      NULL,
    [S4747_Resp_04]            CHAR (2)      NULL,
    [S4747_Resp_05]            CHAR (2)      NULL,
    [S4747_Resp_06]            CHAR (2)      NULL,
    [S4747_Resp_07]            CHAR (2)      NULL,
    [S4747_Resp_08]            CHAR (2)      NULL,
    [S4747_Resp_09]            CHAR (2)      NULL,
    [S4747_Resp_10]            CHAR (2)      NULL,
    [S4747_Resp_11]            CHAR (2)      NULL,
    [S4747_Resp_12]            CHAR (2)      NULL,
    [S4747_Resp_13]            CHAR (2)      NULL,
    [S4747_Resp_14]            CHAR (2)      NULL,
    [S4747_Resp_15]            CHAR (2)      NULL,
    [S4747_Resp_16]            CHAR (2)      NULL,
    [S4747_Resp_17]            CHAR (2)      NULL,
    [S4747_Resp_18]            CHAR (2)      NULL,
    [S4747_Resp_19]            CHAR (2)      NULL,
    [S4747_Resp_20]            CHAR (2)      NULL,
    [S4747_Resp_21]            CHAR (2)      NULL,
    [S4747_Resp_22]            CHAR (2)      NULL,
    [S4747_Resp_23]            CHAR (2)      NULL,
    [S4747_Resp_24]            CHAR (2)      NULL,
    [S4747_Resp_25]            CHAR (2)      NULL,
    [S4747_Resp_26]            CHAR (2)      NULL,
    [S4747_Resp_27]            CHAR (2)      NULL,
    [S4747_Resp_28]            CHAR (2)      NULL,
    [S4747_Resp_29]            CHAR (2)      NULL,
    [S4747_Resp_30]            CHAR (2)      NULL,
    [S4747_Resp_31]            TEXT          NULL,
    [S4747_Resp_32]            CHAR (2)      NULL,
    [S4747_Resp_33]            CHAR (2)      NULL,
    [S4747_Resp_34]            CHAR (2)      NULL,
    [S4747_Resp_35]            CHAR (2)      NULL,
    [S4747_Resp_36]            CHAR (2)      NULL,
    [S4747_Resp_37]            CHAR (2)      NULL,
    [S4747_Resp_38]            CHAR (2)      NULL,
    [S4747_Resp_39]            TEXT          NULL,
    [S4747_Resp_40]            CHAR (2)      NULL,
    [S4747_Resp_41]            CHAR (2)      NULL,
    CONSTRAINT [PK_TAC_SVY] PRIMARY KEY CLUSTERED ([SvyID] ASC, [RespID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_SVY] TO [CANDY\DCouchman]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_SVY] TO [CANDY\BLynch]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_SVY] TO [CANDY\AHerrell]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_SVY] TO [CANDY\CBurnett]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_SVY] TO [CRAdmin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_SVY] TO [ITApps]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TAC_SVY] TO [CsatData]
    AS [dbo];

