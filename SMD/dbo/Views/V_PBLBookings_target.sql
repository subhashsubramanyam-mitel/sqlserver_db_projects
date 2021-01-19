

CREATE VIEW [dbo].[V_PBLBookings_target]
AS
select 

* from [SVLCORPSILO1].[MEGASILO].[dbo].[OPPORTUNITY] o
right outer join  [Tableau_PBL_Targets] t
on datepart( mm, o.[CloseDate]) = datepart( mm, t.targetmonthdate)
and datepart (yy, o.[CloseDate]) = datepart( yy, t.targetmonthdate)














