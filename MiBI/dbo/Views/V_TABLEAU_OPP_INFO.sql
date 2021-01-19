
  create view V_TABLEAU_OPP_INFO as
  -- For Evo's Tableau report MW 09172020
SELECT        
 
		o.TotalSeats, 
		o.EstimatedMRR, 
	 	o.NumOfProfiles, 
		o.OpportunityNumber, 
		o.OppLocations, 
		o.Name as OpportunityName, 
		o.OwnerID,
		o.SubType,
		o.SelfStart,
		u.Name as OppOwner

FROM            
OPPORTUNITY   o inner join
Users u on  o.OwnerID = u.ID



