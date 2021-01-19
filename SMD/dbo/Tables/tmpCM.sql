CREATE TABLE [dbo].[tmpCM] (
    [IndexId]         VARCHAR (25)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Customer Number] NVARCHAR (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [CostGuard UK ID] NVARCHAR (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CostGuard US ID] NVARCHAR (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CostGuard DE ID] NVARCHAR (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Customer Name]   NVARCHAR (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Managed System]  NVARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);

