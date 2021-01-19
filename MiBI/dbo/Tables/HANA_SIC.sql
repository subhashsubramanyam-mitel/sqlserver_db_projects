CREATE TABLE [dbo].[HANA_SIC] (
    [SIC4]            NVARCHAR (4)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SIC4Description] NVARCHAR (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SIC3]            NVARCHAR (4)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SIC3Description] NVARCHAR (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SIC2]            NVARCHAR (4)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SIC2Description] NVARCHAR (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SIC1]            NVARCHAR (4)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SIC1Description] NVARCHAR (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Industry1]       NVARCHAR (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Industry2]       NVARCHAR (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);

