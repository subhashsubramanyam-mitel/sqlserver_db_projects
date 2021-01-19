CREATE TABLE [dbo].[DefectNote] (
    [ID]                 VARCHAR (50)  NOT NULL,
    [CreatedBy]          VARCHAR (500) NULL,
    [CreatedByID]        VARCHAR (50)  NULL,
    [CreatedDate]        DATETIME      NULL,
    [DefectManagementID] VARCHAR (500) NULL,
    [DefectNoteName]     VARCHAR (500) NULL,
    [DefectNum]          VARCHAR (50)  NULL,
    [LastModifiedBy]     VARCHAR (500) NULL,
    [LastModifiedByID]   VARCHAR (50)  NULL,
    [LastModifiedDate]   DATETIME      NULL,
    [Note]               TEXT          NULL,
    [Type]               VARCHAR (500) NULL,
    CONSTRAINT [PK_DefectNote] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DefectNote] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DefectNote] TO [Reporting]
    AS [dbo];

