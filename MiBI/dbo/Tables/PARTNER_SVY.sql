CREATE TABLE [dbo].[PARTNER_SVY] (
    [Partner_Csn] VARCHAR (15)    NOT NULL,
    [SVY_DATE]    DATETIME        NOT NULL,
    [SVY_ID]      BIGINT          NOT NULL,
    [PRT_INDX]    NUMERIC (19, 2) NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PARTNER_SVY] TO [TacEngRole]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[PARTNER_SVY] TO [TacEngRole]
    AS [dbo];

