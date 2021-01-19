CREATE view dbo.VW_CUSTTABLE as SELECT * from dbo.CUSTTABLE;

GO
GRANT SELECT
    ON OBJECT::[dbo].[VW_CUSTTABLE] TO [CANDY\dherskovich]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[VW_CUSTTABLE] TO [CANDY\etlprod]
    AS [dbo];

