CREATE TABLE [dbo].[SMD_ETL_TRK] (
    [Id]        INT      IDENTITY (1, 1) NOT NULL,
    [Created]   DATETIME CONSTRAINT [DF_SMD_ETL_TRK_Created] DEFAULT (getdate()) NOT NULL,
    [StartTime] DATETIME CONSTRAINT [DF_SMD_ETL_TRK_StartTime] DEFAULT (getdate()) NOT NULL,
    [EndTime]   DATETIME CONSTRAINT [DF_SMD_ETL_TRK_EndTime] DEFAULT (getdate()) NOT NULL
);

