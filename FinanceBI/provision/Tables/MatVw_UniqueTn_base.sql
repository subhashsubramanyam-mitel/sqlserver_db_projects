CREATE TABLE [provision].[MatVw_UniqueTn_base] (
    [AccountId]    INT            NULL,
    [Id]           NVARCHAR (10)  NULL,
    [LocationId]   INT            NULL,
    [Label]        NVARCHAR (100) NULL,
    [TnType]       NVARCHAR (50)  NOT NULL,
    [Carrier]      NVARCHAR (100) NULL,
    [ProfileId]    INT            NULL,
    [ProfileName]  NVARCHAR (100) NULL,
    [IsConference] INT            NULL,
    [IsDID]        INT            NULL,
    [IsMainLine]   INT            NULL,
    [TnStatus]     NVARCHAR (30)  NULL
);

