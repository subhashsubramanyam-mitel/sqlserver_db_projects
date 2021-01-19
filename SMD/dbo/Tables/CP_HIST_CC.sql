CREATE TABLE [dbo].[CP_HIST_CC] (
    [Id]                   VARCHAR (255) NOT NULL,
    [ReportDate]           DATETIME      NOT NULL,
    [SvcCluster]           NCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CCClusterName]        NCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ActiveSeats]          INT           NULL,
    [PendingNotBuiltSeats] INT           NULL,
    [PendingBuiltSeats]    INT           NULL,
    [Total]                INT           NULL,
    CONSTRAINT [PK_CP_HIST_CC] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CP_HIST_CC]
    ON [dbo].[CP_HIST_CC]([CCClusterName] ASC, [ReportDate] ASC);

