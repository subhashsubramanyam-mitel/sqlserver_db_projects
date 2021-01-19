 
Create VIEW [dbo].[V_AX_EXCHRATE_ALL]
AS

  select 
  FromDate, ToDate,
  EXCHRATES.currencycode,--TBL2.MaxDate,
  EXCHRATES.exchrate 
FROM SVLCORPAXDB1.PROD.dbo.Exchrates 
 


