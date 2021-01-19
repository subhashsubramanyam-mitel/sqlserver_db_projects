CREATE TABLE [dbo].[TzRule] (
    [Id]           INT            NOT NULL,
    [Name]         NVARCHAR (100) NOT NULL,
    [From]         INT            NOT NULL,
    [To]           INT            NOT NULL,
    [Type]         NVARCHAR (100) NOT NULL,
    [In]           INT            NOT NULL,
    [On]           NVARCHAR (100) NOT NULL,
    [At]           TIME (7)       NOT NULL,
    [AtNegative]   BIT            NOT NULL,
    [Save]         TIME (7)       NOT NULL,
    [SaveNegative] BIT            NOT NULL,
    [Letters]      NVARCHAR (100) NOT NULL
);

