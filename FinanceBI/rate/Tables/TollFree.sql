CREATE TABLE [rate].[TollFree] (
    [RateId]   INT           NOT NULL,
    [Carrier]  NVARCHAR (50) NULL,
    [Region]   NVARCHAR (16) NULL,
    [LATA]     NVARCHAR (10) NULL,
    [OCN]      NVARCHAR (10) NULL,
    [LATA OCN] NVARCHAR (20) NULL,
    [NPA]      NVARCHAR (5)  NULL,
    [NXX]      NVARCHAR (5)  NULL,
    [Rate]     FLOAT (53)    NULL
);

