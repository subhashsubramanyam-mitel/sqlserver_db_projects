CREATE TABLE [dbo].[PH_RAMP_DEFECT] (
    [Id]           VARCHAR (50)   NOT NULL,
    [CreatedDate]  DATETIME       NULL,
    [FirstWeekCR]  DATETIME       NULL,
    [WeekNumberCR] INT            NULL,
    [FirstWeekGA]  DATETIME       NULL,
    [WeekNumberGA] INT            NULL,
    [Build]        NVARCHAR (255) NULL,
    [Version]      NVARCHAR (255) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PH_RAMP_DEFECT] TO [CANDY\brobison]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PH_RAMP_DEFECT] TO [CANDY\alossing]
    AS [dbo];

