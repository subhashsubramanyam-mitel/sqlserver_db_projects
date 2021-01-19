CREATE TABLE [dbo].[CSAT_6328] (
    [Id]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [Created]        DATETIME        CONSTRAINT [DF_CSAT_6328_Created] DEFAULT (getdate()) NOT NULL,
    [INV_ID]         VARCHAR (15)    NULL,
    [INV_Date]       DATETIME        NOT NULL,
    [Resp_ID]        VARCHAR (15)    NULL,
    [Resp_Date]      DATETIME        NULL,
    [Company]        VARCHAR (100)   NULL,
    [Partnername]    VARCHAR (100)   NULL,
    [First_Name]     VARCHAR (25)    NULL,
    [CsatCreated]    DATETIME        NULL,
    [CustActkey]     VARCHAR (15)    NULL,
    [email]          VARCHAR (50)    NULL,
    [Last_Name]      VARCHAR (25)    NULL,
    [Job_Title]      VARCHAR (100)   NULL,
    [Work_Phone]     VARCHAR (50)    NULL,
    [Address]        VARCHAR (100)   NULL,
    [city]           VARCHAR (50)    NULL,
    [state]          VARCHAR (25)    NULL,
    [zip]            VARCHAR (10)    NULL,
    [LOC]            VARCHAR (50)    NULL,
    [Region]         VARCHAR (25)    NULL,
    [Agreement]      VARCHAR (50)    NULL,
    [SR_Email]       VARCHAR (50)    NULL,
    [Part_email]     VARCHAR (50)    NULL,
    [Impact]         VARCHAR (15)    NULL,
    [Comment_1]      TEXT            NULL,
    [Comment_2]      TEXT            NULL,
    [Comment_3]      TEXT            NULL,
    [Comment_4]      TEXT            NULL,
    [Comment_5]      TEXT            NULL,
    [Comment_6]      TEXT            NULL,
    [Q3]             VARCHAR (5)     NULL,
    [Q4]             VARCHAR (5)     NULL,
    [Q5]             VARCHAR (5)     NULL,
    [Comment_7]      TEXT            NULL,
    [Q9]             VARCHAR (5)     NULL,
    [Comment_8]      TEXT            NULL,
    [Q10]            VARCHAR (5)     NULL,
    [Q11]            VARCHAR (5)     NULL,
    [Q13]            VARCHAR (5)     NULL,
    [Q14]            TEXT            NULL,
    [Q15]            VARCHAR (15)    NULL,
    [Comment_9]      TEXT            NULL,
    [Q16]            VARCHAR (5)     NULL,
    [Q17]            VARCHAR (5)     NULL,
    [Comment_10]     TEXT            NULL,
    [Q18]            VARCHAR (5)     NULL,
    [Comment_11]     TEXT            NULL,
    [Comment_12]     TEXT            NULL,
    [Q19]            VARCHAR (5)     NULL,
    [Q20]            VARCHAR (5)     NULL,
    [Q21]            VARCHAR (5)     NULL,
    [Q22]            VARCHAR (5)     NULL,
    [Q23]            VARCHAR (15)    NULL,
    [Q24]            TEXT            NULL,
    [Q26]            VARCHAR (15)    NULL,
    [Comment_13]     TEXT            NULL,
    [Comment_14]     TEXT            NULL,
    [Q31]            VARCHAR (15)    NULL,
    [First_Name2]    VARCHAR (25)    NULL,
    [Title]          VARCHAR (100)   NULL,
    [email2]         VARCHAR (50)    NULL,
    [phone]          VARCHAR (50)    NULL,
    [PROWID]         VARCHAR (15)    NULL,
    [Last_Name2]     VARCHAR (50)    NULL,
    [Final_Month]    VARCHAR (25)    NULL,
    [Final_Day]      VARCHAR (25)    NULL,
    [Final_Year]     VARCHAR (5)     NULL,
    [Final_TimeDate] VARCHAR (50)    NULL,
    [Q1]             VARCHAR (5)     NULL,
    [Comment_15]     TEXT            NULL,
    [Q2]             VARCHAR (5)     NULL,
    [Q6]             VARCHAR (5)     NULL,
    [Q7]             VARCHAR (5)     NULL,
    [Q8]             TEXT            NULL,
    [Q12]            VARCHAR (5)     NULL,
    [Q29]            VARCHAR (5)     NULL,
    [Q30]            TEXT            NULL,
    [Company2]       VARCHAR (100)   NULL,
    [PI]             DECIMAL (18, 2) NULL,
    [Comment_16]     TEXT            NULL,
    [Comment_17]     TEXT            NULL,
    [survey_type]    VARCHAR (50)    NULL,
    [Comment_18]     TEXT            NULL,
    [Comment_19]     TEXT            NULL,
    [Comment_20]     TEXT            NULL,
    [Comment_21]     TEXT            NULL,
    [Comment_22]     TEXT            NULL,
    CONSTRAINT [PK_CSAT_6328] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CSAT_6328]
    ON [dbo].[CSAT_6328]([Resp_ID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CSAT_6328] TO [CANDY\BPaddock]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CSAT_6328] TO [CANDY\JOquinn]
    AS [dbo];

