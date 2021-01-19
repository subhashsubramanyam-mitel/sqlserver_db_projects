﻿CREATE TABLE [dbo].[SR_SLA] (
    [SR_NUM]       VARCHAR (15) NOT NULL,
    [InSLA]        VARCHAR (5)  NULL,
    [LastActivity] DATETIME     NULL,
    CONSTRAINT [PK_SR_SLA] PRIMARY KEY CLUSTERED ([SR_NUM] ASC)
);
