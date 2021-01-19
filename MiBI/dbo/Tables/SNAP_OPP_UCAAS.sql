CREATE TABLE [dbo].[SNAP_OPP_UCAAS] (
    [SnapDate]             DATETIME        NOT NULL,
    [DealSize]             VARCHAR (500)   NULL,
    [EstimatedMRR]         DECIMAL (18, 2) NULL,
    [LeadSource]           VARCHAR (500)   NULL,
    [MRRAmount]            DECIMAL (18, 2) NULL,
    [RecordType]           VARCHAR (100)   NULL,
    [Stage]                VARCHAR (500)   NULL,
    [Type]                 VARCHAR (100)   NULL,
    [SubType]              VARCHAR (500)   NULL,
    [CountryCode]          VARCHAR (50)    NULL,
    [ProductInterest]      VARCHAR (500)   NULL,
    [OpportunityRegion]    VARCHAR (500)   NULL,
    [OpportunitySubRegion] VARCHAR (500)   NULL,
    [OpportunityTheater]   VARCHAR (500)   NULL,
    [ForecastCategory]     VARCHAR (50)    NULL,
    [TCV]                  FLOAT (53)      NULL,
    [MRR]                  DECIMAL (38, 2) NULL,
    [Total]                INT             NULL,
    [TotalSeats]           FLOAT (53)      NULL
);

