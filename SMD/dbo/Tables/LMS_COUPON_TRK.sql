﻿CREATE TABLE [dbo].[LMS_COUPON_TRK] (
    [Created]    DATETIME     CONSTRAINT [DF_LMS_COUPON_TRK_Created] DEFAULT (getdate()) NOT NULL,
    [SalesOrder] VARCHAR (15) NOT NULL,
    [Line]       VARCHAR (15) NOT NULL,
    [Status]     VARCHAR (1)  CONSTRAINT [DF_LMS_COUPON_TRK_Status] DEFAULT ('N') NULL,
    CONSTRAINT [PK_LMS_COUPON_TRK] PRIMARY KEY CLUSTERED ([Line] ASC) WITH (FILLFACTOR = 90)
);

