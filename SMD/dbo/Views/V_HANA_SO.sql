


CREATE View [dbo].[V_HANA_SO] as 
 -- SO Output for Tableau  MW 08052020
 select  
*
	FROM OPENQUERY (BWP,  
	'SELECT  
   *
	FROM    "ZMITEL_BOOKINGS.TABLEAU_VIEWS::YR_SO_CV_BK02" '
	 )
 


