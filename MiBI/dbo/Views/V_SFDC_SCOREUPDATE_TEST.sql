/*
CREATE VIEW [dbo].[V_SFDC_SCOREUPDATE_TEST]
AS

SELECT                                                                  
			b.SfdcId,
			--a.ImpactNumber,
			--a.Over45,
			--a.Licenses,
			--a.SrCount,
			a.TacUtilization, 
			--a.DemoKits as USDemoEquip,
			--a.MobileDemoKits,
			a.SVY_COUNT as NPS_SVY_COUNT,
			a.SCORE as NPS_SCORE,
			--a.AtR_Customers,
			--a.AtR_SupCustomers,
			--a.AtRate,
			a.PartnerCloudDemoProfiles,
			ISNULL(LMS.SSO, 0 ) as SSO, 
			ISNULL(LMS.SSA, 0 ) as SSA,
			ISNULL(LMS.SSCA, 0) as SSCA,
			ISNULL(LMS.SSCE, 0) as SSCE, 
			ISNULL(LMS.DemoSkills, 0) as DemoSkills, --just BR008 for now
			ISNULL(LMS.UCSI, 0) AS UCSI,
			ISNULL(LMS.UCSP, 0) as UCSP,
			ISNULL(LMS.UCSE, 0) as UCSE,
			ISNULL(LMS.CCSI,0) as CCSI,
			ISNULL(LMS.CCSP,0) as CCSP,
			ISNULL(LMS.CCSE,0) as CCSE,
			ISNULL(LMS.SMSI,0) as SMSI,
			ISNULL(LMS.SMSE,0) as SMSE,
			ISNULL(LMS.SESO,0) as SESO,
			ISNULL(LMS.SESA,0) as SESA,
			ISNULL(LMS.OS110,0) as OS110,
			ISNULL(LMS.OS111,0) as OS111,
			ISNULL(LMS.PSC,0) as PSC,
			--ISNULL(a.SBEPractice,0) as SBEPractice,
			IsNull(a.UCPractice,'No') as UCPractice,
			IsNull(a.CCPractice,'No') as CCPractice,
			IsNull(a.MobilityPractice,'No') as MobilityPractice,
			IsNull(a.CloudUCPractice,'No') as CloudUCPractice,
			mr.Cpp1YrPts


FROM 
		CORPDB.STDW.dbo.V_PartnerDetail_V2TEST a LEFT OUTER JOIN
		CORPDB.STDW.dbo.SFDC_PARTNERS b on a.ImpactNumber = b.ImpactNumber LEFT OUTER JOIN
		--PARTNER_CERTS OLMS on a.ImpactNumber = OLMS.ImpactNumber  COLLATE DATABASE_DEFAULT LEFT OUTER JOIN	--JO 03252016 per Monica switched to new calculations
		CORPDB.STDW.dbo.PARTNER_CERTS_V2 LMS on a.ImpactNumber = LMS.ImpactNumber  COLLATE DATABASE_DEFAULT LEFT OUTER JOIN
		CORPDB.STDW.dbo.V_SBE_CONTRACT x on a.ImpactNumber=x.AccountSTID LEFT OUTER JOIN
		V_Cpp1YrPts mr on a.ImpactNumber=mr.ImpactNumber COLLATE DATABASE_DEFAULT
*/




		
		


