﻿CREATE TABLE [dbo].[SapAccountMap] (
    [ST_ID]     VARCHAR (50) NOT NULL,
    [SapNumber] VARCHAR (50) NULL,
    CONSTRAINT [PK_SapAccountMap] PRIMARY KEY CLUSTERED ([ST_ID] ASC) WITH (FILLFACTOR = 90)
);

