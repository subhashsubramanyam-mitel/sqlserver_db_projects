


CREATE view [dbo].[V_HANA_TCURR] as 
 -- call out to HANA for Currency Extract MW 06162020


 select 
	convert(datetime,Left(99999999 - GDATU,8)) as FromDate  --some fucked up shit SAP is
	,FCURR	as FromCurrency
	,TCURR  as ToCurrency
	,UKURS as ExchangeRate
 ,row_number() over (partition by GDATU,FCURR order by UKURS) rn
	FROM OPENQUERY (BWP,  
	'SELECT   * FROM SAPBWP.TCURR where TCURR = ''USD'' ')
 
 



