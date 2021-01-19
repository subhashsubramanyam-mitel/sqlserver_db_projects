CREATE VIEW [dbo].[V_SHOR_NPS_BAK11202014]
AS
SELECT     
		FIELD26 AS PrimaryKey, 
		convert(char(10),FIELD2,101) AS Date, 
		FIELD91 AS Score, 
		FIELD37 AS ServiceTime, 
		'Premises' as Soloution
FROM         CE_SVY_2014
UNION ALL
select 
		Field20 AS PrimaryKey, 
		cast(convert(char(10),Field2,101) as datetime) as Date,
		Field89 AS Score, 
		null AS ServiceTime, 
		'Cloud' as Soloution
  from SKY_NPS_SVY_RAW

