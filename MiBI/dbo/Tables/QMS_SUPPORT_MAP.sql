﻿CREATE TABLE [dbo].[QMS_SUPPORT_MAP] (
    [SFDCProduct] NVARCHAR (255) NOT NULL,
    [QMSSupport]  NVARCHAR (255) NULL,
    CONSTRAINT [PK_QMS_SUPPORT_MAP] PRIMARY KEY CLUSTERED ([SFDCProduct] ASC)
);
