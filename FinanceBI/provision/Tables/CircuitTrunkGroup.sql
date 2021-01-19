CREATE TABLE [provision].[CircuitTrunkGroup] (
    [Id]                 INT            NOT NULL,
    [Name]               NVARCHAR (50)  NOT NULL,
    [OCN]                CHAR (4)       NULL,
    [CarrierAccountId]   INT            NOT NULL,
    [ColocationId]       INT            NULL,
    [TrunkgroupStatusId] INT            NOT NULL,
    [Description]        NVARCHAR (100) NULL,
    [IsSIP]              BIT            NOT NULL,
    [IsOrigination]      BIT            NOT NULL,
    [IsTermination]      BIT            NOT NULL,
    [DateModified]       DATETIME2 (4)  NOT NULL,
    [DateCreated]        DATETIME2 (4)  NOT NULL,
    [ModifiedBy]         NVARCHAR (50)  NOT NULL,
    [RecordVersion]      ROWVERSION     NOT NULL
);

