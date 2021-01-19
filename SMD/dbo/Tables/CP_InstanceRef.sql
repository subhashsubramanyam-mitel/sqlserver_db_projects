CREATE TABLE [dbo].[CP_InstanceRef] (
    [InstanceName]          NVARCHAR (255) NULL,
    [SCCP]                  FLOAT (53)     NULL,
    [PSeries]               FLOAT (53)     NULL,
    [SIP]                   FLOAT (53)     NULL,
    [Override]              FLOAT (53)     NULL,
    [InstanceType]          NVARCHAR (255) NULL,
    [PctSIP]                FLOAT (53)     NULL,
    [PctP]                  FLOAT (53)     NULL,
    [StopProvisioningLimit] FLOAT (53)     NULL,
    [Max]                   FLOAT (53)     NULL,
    [InstanceRegion]        NVARCHAR (255) NULL,
    [InstanceBuildSequence] FLOAT (53)     NULL,
    [ProvisionStartDate]    DATE           NULL,
    [Platform]              VARCHAR (50)   NULL
);

