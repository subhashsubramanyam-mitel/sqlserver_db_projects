CREATE TABLE [dbo].[CP_InstanceSnapshot] (
    [Created]               DATETIME    CONSTRAINT [DF_CP_InstanceSnapshot_Created] DEFAULT (getdate()) NULL,
    [InstanceName]          NCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ActiveSeats]           INT         NULL,
    [PendingNotBuiltSeats]  INT         NULL,
    [PendingBuiltSeats]     INT         NULL,
    [AnticipatedTotalSeats] INT         NULL,
    [Accounts]              INT         NULL,
    CONSTRAINT [PK_CP_InstanceSnapshot] PRIMARY KEY CLUSTERED ([InstanceName] ASC)
);

