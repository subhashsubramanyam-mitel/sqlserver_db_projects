CREATE TABLE [company].[CustomerVertical] (
    [M5DBAccountID]   VARCHAR (50)  COLLATE Latin1_General_BIN NULL,
    [SIC4]            NVARCHAR (4)  NOT NULL,
    [SIC4Description] NVARCHAR (60) NULL,
    [SIC3]            NVARCHAR (4)  NOT NULL,
    [SIC3Description] NVARCHAR (60) NULL,
    [SIC2]            NVARCHAR (4)  NOT NULL,
    [SIC2Description] NVARCHAR (60) NULL,
    [SIC1]            NVARCHAR (4)  NOT NULL,
    [SIC1Description] NVARCHAR (60) NULL,
    [Industry1]       NVARCHAR (60) NOT NULL,
    [Industry2]       NVARCHAR (60) NOT NULL
);

