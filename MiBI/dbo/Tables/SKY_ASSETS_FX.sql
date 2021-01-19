CREATE TABLE [dbo].[SKY_ASSETS_FX] (
    [Created]       DATETIME   CONSTRAINT [DF_SKY_ASSETS_FX_Created] DEFAULT (getdate()) NULL,
    [Id]            INT        IDENTITY (1, 1) NOT NULL,
    [M5DBServiceId] FLOAT (53) NOT NULL,
    [ErrStatus]     CHAR (1)   CONSTRAINT [DF_SKY_ASSETS_FX] DEFAULT ('N') NULL,
    [ErrorTxt]      TEXT       NULL,
    CONSTRAINT [PK_SKY_ASSETS_FX] PRIMARY KEY CLUSTERED ([M5DBServiceId] ASC)
);

