﻿CREATE TABLE [dbo].[B_SFDC_BIZ_PERSON] (
    [ID]                    VARCHAR (18)  NOT NULL,
    [BIZIBLE2__CASE__C]     VARCHAR (255) NULL,
    [BIZIBLE2__CONTACT__C]  VARCHAR (18)  NULL,
    [BIZIBLE2__LEAD__C]     VARCHAR (18)  NULL,
    [BIZIBLE2__UNIQUEID__C] VARCHAR (25)  NULL,
    [NAME]                  VARCHAR (63)  NULL,
    [OWNERID]               VARCHAR (18)  NULL,
    CONSTRAINT [PK_B_SFDC_BIZ_PERSON] PRIMARY KEY CLUSTERED ([ID] ASC)
);

