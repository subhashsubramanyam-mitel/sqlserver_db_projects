﻿CREATE TABLE [sales].[Contract] (
    [Id]                     INT             NOT NULL,
    [ContractNumber]         VARCHAR (128)   NULL,
    [Name]                   NVARCHAR (128)  NULL,
    [ContractTypeId]         INT             NULL,
    [ContractStatusId]       INT             NOT NULL,
    [AccountId]              INT             NULL,
    [DateContractWon]        DATETIME2 (4)   NULL,
    [ContractLength]         INT             NULL,
    [ContractSpecialTerms]   NVARCHAR (264)  NULL,
    [SalesPersonId]          INT             NULL,
    [LichenQuoteId]          INT             NULL,
    [DateCreatedOriginal]    DATETIME2 (4)   NULL,
    [CreatedByPersonId]      INT             NULL,
    [DateModifiedOriginal]   DATETIME2 (4)   NULL,
    [ModifiedByPersonId]     INT             NULL,
    [DateModified]           DATETIME2 (4)   NOT NULL,
    [DateCreated]            DATETIME2 (4)   NOT NULL,
    [ModifiedBy]             NVARCHAR (50)   NOT NULL,
    [ContractFileName]       NVARCHAR (264)  NULL,
    [ContractFilePath]       NVARCHAR (1000) NULL,
    [ProjectManagerId]       INT             NULL,
    [ContractGoLive]         DATETIME2 (4)   NULL,
    [ClientProgrammerId]     INT             NULL,
    [DataEngineerId]         INT             NULL,
    [BillingLocationId]      INT             NULL,
    [AccountManagerId]       INT             NULL,
    [ContractSignedPersonId] INT             NULL,
    [BusinessTermVersion]    INT             NULL,
    [RenewAutomatically]     BIT             NULL,
    [InstallTermUOM]         CHAR (1)        NULL,
    [InstallTermQuantity]    INT             NULL,
    [DownturnPercentage]     INT             NULL,
    [ProfileAmount]          INT             NULL,
    [SalesForceId]           NVARCHAR (18)   NULL,
    [PlatformTypeId]         INT             NULL,
    [DateSigned]             DATETIME        NULL,
    [CommitmentDate]         DATE            NULL
);

