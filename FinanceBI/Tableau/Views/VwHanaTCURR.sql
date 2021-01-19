


CREATE view [Tableau].[VwHanaTCURR] as
 -- call out to HANA for Currency Extract MW 06162020

select * from SMD.SMD.dbo.V_HANA_TCURR where rn = 1
