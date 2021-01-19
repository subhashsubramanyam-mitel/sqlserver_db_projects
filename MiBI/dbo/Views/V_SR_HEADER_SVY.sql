

CREATE VIEW [dbo].[V_SR_HEADER_SVY]
AS
 
SELECT     SR_HEADER_SVY.SfdcId, SR_NUM, SR_TITLE, SR_HEADER_SVY.PartnerId, Partner, AccountId, Account, SR_AREA, Res_Stat, LOGIN, Date_Open, ACT_CLOSE_DT, SR_Version, Phase, Source, Feature, 
                      Severity, Priority, SR_HEADER_SVY.Status, Sub_Status, FST_NAME, LAST_NAME, EMAIL_ADDR, ContactId, Origin, Trunk_Provider__c, CreatedBy, ContactPhone, LastModifiedDate, 
                      ActiveServiceAgreement, LegacySR_NUM, EndUser, Resolution, ContactSfdcId, JobTitle, SR_HEADER_SVY.OwnerName, OwnerRole, Billable, BillableReason, SalesOrder, CreditCard, 
                      SLAFlag, EngineeringStatus, LastActivity, EndUserTheater, EndUserRegion, EndUserSubRegion, CommitTime,
					CUSTOMERS.ImpactNumber as EndUserId,RESELLER.Theatre as PartnerTheatre,RESELLER.Region as PartnerRegion,RESELLER.SubRegion as PartnerSubRegion
			,DaysToSLA
FROM         SR_HEADER_SVY LEFT OUTER JOIN
			CUSTOMERS ON SR_HEADER_SVY.EndUser= CUSTOMERS.SfdcId LEFT OUTER JOIN
			RESELLER on CUSTOMERS.PartnerId=RESELLER.ImpactNumber


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_SR_HEADER_SVY] TO [TACECC]
    AS [dbo];

