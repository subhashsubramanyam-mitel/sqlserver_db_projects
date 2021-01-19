CREATE VIEW [dbo].[V_AX_EXCHRATE]
AS
-- MW 09072017  setting filter for exc since something odd happened with USD
  select EXCHRATES.currencycode,--TBL2.MaxDate,
  EXCHRATES.exchrate 
FROM SVLCORPAXDB1.PROD.dbo.Exchrates 
INNER join 
	(select currencycode, max(fromdate)as MaxDate from SVLCORPAXDB1.PROD.dbo.exchrates 
	where  DATAAREAID = 'exc'
	group by currencycode) AS TBL2
ON 	exchrates.fromdate = TBL2.MaxDate 
	and exchrates.currencycode = TBL2.currencycode
	and exchrates.DATAAREAID = 'exc'