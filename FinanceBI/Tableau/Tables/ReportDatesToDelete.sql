CREATE TABLE [Tableau].[ReportDatesToDelete] (
    [DEL_StartDate] DATETIME NOT NULL,
    [DEL_EndDate]   DATETIME NULL,
    [IsDeleted]     BIT      DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ReportDatesToDelete] PRIMARY KEY CLUSTERED ([DEL_StartDate] ASC)
);

