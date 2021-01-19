
CREATE VIEW [dbo].[V_HV_CONTRACT]
AS

SELECT AccountSTID
	
FROM CONTRACT
where Type='AUSTRALIA Indirect w/Cloud' and IsCurrent='Yes'
