CREATE VIEW [Santana].[VwUserDetail_Excel]
AS
-- 05152020 MW 
-- View for Santana spreadsheet
SELECT vwuserdetail.accountid
	,vwuserdetail.accountname
	,vwuserdetail.profiletn
	,vwuserdetail.firstname
	,vwuserdetail.lastname
	,vwuserdetail.username
	,vwuserdetail.businessemail
	,vwuserdetail.locationname
	,vwuserdetail.address
	,t.obcid
	,vwuserdetail.profiletype
	,vwuserdetail.extension
	,vwuserdetail.mobility
	,vwuserdetail.fax
	,vwuserdetail.scribe
	,
	--vwuserdetail.callrecording,
	t.CallRecordingType AS callrecording
	,vwuserdetail.conferencing
	,vwuserdetail.grandstream
	,vwuserdetail.ciscospa
	,vwuserdetail.ciscoata
	,vwuserdetail.polycomsoundstation
	,vwuserdetail.linksysspa
	,vwuserdetail.otherdevice
	,vwuserdetail.crm
	,t.[calling restrictions]
	,t.[vm to email notification setting]
	,t.[alert notification address]
	,t.[sound file]
	,t.[sound file address]
	,t.[delete after wav?]
	,t.[shared vm access]
	,t.[is call screening enabled?]
	,t.[call screening rule]
	,t.[call routing - always]
	,t.[always fwd]
	,t.[call routing - num of rings]
	,t.[call routing - no answer]
	,t.[no answer fwd]
	,t.[shared lines]
	,t.[speed dials]
	,t.[vm zero out setting]
	,t.[replace personal vm]
	,t.aliases AS Aliases
FROM dbo.SKYUSERDETAIL vwuserdetail
LEFT OUTER JOIN santana.VWTNCONFIGDETAIL t ON vwuserdetail.profiletn = t.tn
GO

GRANT SELECT
	ON OBJECT::[Santana].[VwUserDetail_Excel]
	TO [SkyImp] AS [dbo];